//
//  BJBenchmarkSerializer.m
//  BaijiCore
//
//  Created by zmy周梦伊 on 10/21/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import "BJSerializerBenchmark.h"
#import "BJGenericBenchmarkRecord.h"
#import "BJJsonSerializer.h"
#import "BJEnum1Values.h"
#import "SBJson4Writer.h"
#import "SBJson4Parser.h"
#import "BJSpecificEnum.h"
#import "BJEnum2Values.h"
#import "BJModelFilling2.h"
#import "JSONKit.h"

@interface BJSerializerBenchmark()

@property (nonatomic, assign) BOOL reportAllowed;
@property (atomic, retain) NSMutableArray *aggregatedResults;
@property (atomic, retain) id<BJBenchmarkCandidateDelegate> serializerDelegate;

@end

@implementation BJSerializerBenchmark

- (instancetype)initWithSerializer:(id<BJBenchmarkCandidateDelegate>)serializer {
    self = [super init];
    if (self) {
        self.reportAllowed = NO;
        self.serializerDelegate = serializer;
        _aggregatedResults = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return self;
}

- (void)benchmarkInt:(BJBenchmark)benchmark {
    benchmark([NSNumber numberWithInt:42], @"\"int\"");
}

- (void)benchmarkBoolean:(BJBenchmark)benchmark {
    benchmark([NSNumber numberWithBool:YES], @"\"boolean\"");
}

- (void)benchmarkLong:(BJBenchmark)benchmark {
    benchmark([NSNumber numberWithLong:1024 *1024 * 16L], @"\"long\"");
}

- (void)benchmarkDouble:(BJBenchmark)benchmark {
    benchmark([NSNumber numberWithDouble:24.0000001], @"\"double\"");
}

- (void)benchmarkString:(BJBenchmark)benchmark {
    benchmark(@"testString", @"\"string\"");
}

- (void)benchmarkEnum:(BJBenchmark)benchmark {
    benchmark([[[BJEnum1Values alloc] initWithValue:BJEnum1ValuesRED] autorelease], @"{\"type\":\"enum\",\"name\":\"BJEnum1Values\",\"namespace\":\"com.ctriposs.baiji.specific\",\"doc\":null,\"symbols\":[\"BLUE\",\"RED\",\"GREEN\"]}");
}

- (void)benchmarkBytes:(BJBenchmark)benchmark {
    benchmark([@"testBytes" dataUsingEncoding:NSUTF8StringEncoding], @"\"bytes\"");
}

- (void)benchmarkArray:(BJBenchmark)benchmark {
    benchmark([NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], nil], @"{\"type\":\"array\",\"items\":\"int\"}");
}

- (void)benchmarkRecord:(BJBenchmark)benchmark {
    BJEnum2Values *enum2 = [[BJEnum2Values alloc] initWithValue:BJEnum2ValuesPLANE];
    BJModelFilling2 *record = [[BJModelFilling2 alloc] initWithEnumfilling:enum2 listfilling:[NSArray arrayWithObjects:@"a", @"b", @"c", nil] longfilling:[NSNumber numberWithLong:1024 * 1024 * 1024] stringfilling:@"stringfilling"];
    benchmark(record, [[record schema] description]);
    [record release];
    [enum2 release];
}

- (void)benchmarkMap:(BJBenchmark)benchmark {
    NSMutableDictionary *map = [[NSMutableDictionary alloc] init];
    [map setObject:[NSNumber numberWithInt:1] forKey:@"1a"];
    [map setObject:[NSNumber numberWithInt:2] forKey:@"2b"];
    [map setObject:[NSNumber numberWithInt:3] forKey:@"3c"];
    benchmark(map, @"{\"type\":\"map\",\"values\":\"int\"}");
    [map release];
}

- (void)benchmarkMultiThreads {
    BJEnum2Values *enum2 = [[BJEnum2Values alloc] initWithValue:BJEnum2ValuesPLANE];
    BJModelFilling2 *record = [[BJModelFilling2 alloc] initWithEnumfilling:enum2 listfilling:[NSArray arrayWithObjects:@"a", @"b", @"c", nil] longfilling:[NSNumber numberWithLong:1024 * 1024 * 1024] stringfilling:@"stringfilling"];
    const int loop = 10;
    __block NSArray *results = nil;
    for (int i = 0; i < loop; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            results = [self benchmarkSingleField:[[record schema] description] value:record];
            [self notifyMultiThreadsResults:results];
        });
    }
    [record release];
    [enum2 release];
}

- (void)notifyMultiThreadsResults:(NSArray *)singleThreadResult {
    [self.aggregatedResults addObject:singleThreadResult];
    if ([self.aggregatedResults count] == 10) {
        float aggregatedWritingResult = 0.0;
        float aggregatedReadingResult = 0.0;
        for (NSArray *result in self.aggregatedResults) {
            aggregatedWritingResult += [[result objectAtIndex:1] floatValue];
            aggregatedReadingResult += [[result objectAtIndex:2] floatValue];
        }
        [self notifyResult:[NSArray arrayWithObjects:@"\"10 threads\"", [NSNumber numberWithFloat:aggregatedWritingResult / 10], [NSNumber numberWithFloat:aggregatedReadingResult / 10], [singleThreadResult objectAtIndex:3], nil]];
    }
}

- (NSArray *)benchmarkSingleField:(NSString *)type value:(id)object {
    BJGenericBenchmarkRecord *record = [[BJGenericBenchmarkRecord alloc] init];
    [record setRecordType:type];
    [record setObject:object atIndex:0];
    
    float writingResult, readingResult;
    
    NSOutputStream *writingSource = [[NSOutputStream alloc] initToMemory];
    [writingSource open];
    NSDate *start = [NSDate date];
    for (int i = 0; i < 10; i++) {
        [self.serializerDelegate write:type record:record source:writingSource];
    }
    writingResult = -[start timeIntervalSinceNow] * 1000 * 1000 / 10;
    NSData *temp = [writingSource propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
    [writingSource close];
    [writingSource release];
    
    NSUInteger length = [temp length];
    NSInputStream *readingSource = [[NSInputStream alloc] initWithData:temp];
    [readingSource open];
    start = [NSDate date];
    for (int i = 0; i < 10; i++) {
        uint8_t buffer[length/10];
        [readingSource read:buffer maxLength:length/10];
        [self.serializerDelegate read:type stream:[NSData dataWithBytes:buffer length:length/10]];
    }
    readingResult = -[start timeIntervalSinceNow] * 1000 * 1000 / 10;
    [readingSource close];
    [readingSource release];
    [record release];
    return [NSArray arrayWithObjects:type, [NSNumber numberWithFloat:writingResult], [NSNumber numberWithFloat:readingResult], [NSNumber numberWithInt:length/10],nil];
}

- (void)notifyResult:(NSArray *)result{
    if (self.reportAllowed) {
        [self.masterDelegate serializer:[self.serializerDelegate name]
                              didFinish:[result objectAtIndex:0]
                                writing:[[result objectAtIndex:1] floatValue]
                                reading:[[result objectAtIndex:2] floatValue]
                                 length:[[result objectAtIndex:3] intValue]];
    }
}

- (void)batch {
    for (int i = 0; i < 1000; i++) {
        [self run];
    }
    self.reportAllowed = YES;
    [self run];
    if ([self.serializerDelegate supportMultiThreads]) {
        [self benchmarkMultiThreads];
    } else {
        [self notifyResult:[NSArray arrayWithObjects:@"\"10 threads\"",
                            [NSNumber numberWithFloat:-1],
                            [NSNumber numberWithFloat:-1],
                            [NSNumber numberWithInt:0], nil]];
    }
    NSLog(@"%@", [self.serializerDelegate name]);
}

- (void)run {
    [self benchmarkInt:^(id object, NSString *type) {
        [self notifyResult:[self benchmarkSingleField:type value:object]];
    }];
    [self benchmarkBoolean:^(id object, NSString *type) {
        [self notifyResult:[self benchmarkSingleField:type value:object]];
    }];
    [self benchmarkLong:^(id object, NSString *type) {
        [self notifyResult:[self benchmarkSingleField:type value:object]];
    }];
    [self benchmarkDouble:^(id object, NSString *type) {
        [self notifyResult:[self benchmarkSingleField:type value:object]];
    }];
    [self benchmarkString:^(id object, NSString *type) {
        [self notifyResult:[self benchmarkSingleField:type value:object]];
    }];
    [self benchmarkEnum:^(id object, NSString *type) {
        [self notifyResult:[self benchmarkSingleField:type value:object]];
    }];
    [self benchmarkArray:^(id object, NSString *type) {
        [self notifyResult:[self benchmarkSingleField:type value:object]];
    }];
    [self benchmarkMap:^(id object, NSString *type) {
        [self notifyResult:[self benchmarkSingleField:type value:object]];
    }];
    [self benchmarkRecord:^(id object, NSString *type) {
        [self notifyResult:[self benchmarkSingleField:type value:object]];
    }];
}

- (void)dealloc {
    [self.serializerDelegate release];
    [super dealloc];
}

@end

@interface BJJsonSerializerBenchmark()

@property (nonatomic, retain) BJJsonSerializer *serializer;

@end

@implementation BJJsonSerializerBenchmark

- (instancetype)init {
    self = [super init];
    if (self) {
        _serializer = [[BJJsonSerializer alloc] init];
    }
    return self;
}

- (void)write:(NSString *)type record:(BJGenericBenchmarkRecord *)record source:(NSOutputStream *)writingSource{
    NSData *stream = [self.serializer serialize:record];
    [writingSource write:[stream bytes] maxLength:[stream length]];
}

- (void)read:(NSString *)type stream:(NSData *)stream {
    [self.serializer deserialize:[BJGenericBenchmarkRecord class] from:stream];
}

- (NSString *)name {
    return @"BaijiJSON";
}

- (BOOL)supportMultiThreads {
    return YES;
}

- (void)dealloc {
    [self.serializer release];
    [super dealloc];
}

@end

@interface BJAppleJsonSerializerBenchmark()

@property (atomic) BOOL isEnum;
@property (atomic) BOOL isRecord;

@end

@implementation BJAppleJsonSerializerBenchmark

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)write:(NSString *)type record:(BJGenericBenchmarkRecord *)record source:(NSOutputStream *)writingSource {
    id object = [record fieldAtIndex:0];
    self.isEnum = [object isKindOfClass:[BJSpecificEnum class]];
    self.isRecord = [object isKindOfClass:[BJModelFilling2 class]];
    if (self.isEnum) {
        object = [((BJEnum1Values *)object) name];
    }
    NSDictionary *jsonObj = [NSDictionary dictionaryWithObject:self.isRecord ? [self dictionaryFromRecord:object] : object forKey:@"fieldValue"];
    NSData *stream = [NSJSONSerialization dataWithJSONObject:jsonObj options:0 error:nil];
    [writingSource write:[stream bytes] maxLength:[stream length]];
}

- (void)read:(NSString *)type stream:(NSData *)stream {
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:stream options:NSJSONReadingAllowFragments error:nil];
    BJGenericBenchmarkRecord *record = [[BJGenericBenchmarkRecord alloc] init];
    if (self.isEnum) {
        NSUInteger ordinal = [BJEnum1Values ordinalForName:[parsedObject objectForKey:@"fieldValue"]];
        BJEnum1Values *value = [[BJEnum1Values alloc] initWithValue:ordinal];
        [record setObject:value atIndex:0];
        [value release];
    } else {
        [record setObject:[parsedObject objectForKey:@"fieldValue"] atIndex:0];
    }
    [record release];
}

- (NSDictionary *)dictionaryFromRecord:(BJModelFilling2 *)record {
    NSMutableDictionary *jsonObj = [[NSMutableDictionary alloc] init];
    [jsonObj setObject:record.listfilling forKey:@"listfilling"];
    [jsonObj setObject:[record.enumfilling name] forKey:@"enumfilling"];
    [jsonObj setObject:record.stringfilling forKey:@"stringfilling"];
    return [jsonObj autorelease];
}

- (NSString *)name {
    return @"NSJSON";
}

- (BOOL)supportMultiThreads {
    return YES;
}

@end

@interface BJSBJsonSerializerBenchmark()

@property (atomic) BOOL isEnum;
@property (atomic) BOOL isRecord;
@property (nonatomic, retain) SBJson4Writer *serializer;

@end

@implementation BJSBJsonSerializerBenchmark

- (instancetype)init {
    self = [super init];
    if (self) {
        _serializer = [[SBJson4Writer alloc] init];
    }
    return self;
}

- (void)write:(NSString *)type record:(BJGenericBenchmarkRecord *)record source:(NSOutputStream *)writingSource {
    id object = [record fieldAtIndex:0];
    self.isEnum = [object isKindOfClass:[BJSpecificEnum class]];
    self.isRecord = [object isKindOfClass:[BJModelFilling2 class]];
    if (self.isEnum) {
        object = [((BJSpecificEnum *)object) name];
    }
    NSDictionary *jsonObj = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:self.isRecord ? [self dictionaryFromRecord:object] : object forKey:@"fieldValue"] forKey:@"fieldValue"];
    NSData *stream = [self.serializer dataWithObject:jsonObj];
    [writingSource write:[stream bytes] maxLength:[stream length]];
}

- (void)read:(NSString *)type stream:(NSData *)stream {
    SBJson4Parser *deserializer = [SBJson4Parser parserWithBlock:^(id item, BOOL *stop) {
        BJGenericBenchmarkRecord *record = [[BJGenericBenchmarkRecord alloc] init];
        if (self.isEnum) {
            NSUInteger ordinal = [BJEnum1Values ordinalForName:[item objectForKey:@"fieldValue"]];
            BJEnum1Values *value = [[BJEnum1Values alloc] initWithValue:ordinal];
            [record setObject:value atIndex:0];
            [value release];
        } else {
            [record setObject:[item objectForKey:@"fieldValue"] atIndex:0];
        }
        [record release];
    } allowMultiRoot:NO unwrapRootArray:NO errorHandler:^(NSError *error) {
        [NSException exceptionWithName:@"SBJsonSerializationError" reason:[error localizedDescription] userInfo:nil];
    }];
    [deserializer parse:stream];
}

- (NSString *)name {
    return @"SBJSON";
}

- (NSDictionary *)dictionaryFromRecord:(BJModelFilling2 *)record {
    NSMutableDictionary *jsonObj = [[NSMutableDictionary alloc] init];
    [jsonObj setObject:record.listfilling forKey:@"listfilling"];
    [jsonObj setObject:[record.enumfilling name] forKey:@"enumfilling"];
    [jsonObj setObject:record.stringfilling forKey:@"stringfilling"];
    return [jsonObj autorelease];
}

- (BOOL)supportMultiThreads {
    return NO;
}

- (void)dealloc {
    [self.serializer release];
    [super dealloc];
}

@end

@interface BJJsonKitSerializerBenchmark()

@property (atomic) BOOL isEnum;
@property (atomic) BOOL isRecord;

@end

@implementation BJJsonKitSerializerBenchmark


- (void)write:(NSString *)type record:(BJGenericBenchmarkRecord *)record source:(NSOutputStream *)writingSource {
    id object = [record fieldAtIndex:0];
    self.isEnum = [object isKindOfClass:[BJSpecificEnum class]];
    self.isRecord = [object isKindOfClass:[BJModelFilling2 class]];
    if (self.isEnum) {
        object = [((BJSpecificEnum *)object) name];
    }
    NSDictionary *jsonObj = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:self.isRecord ? [self dictionaryFromRecord:object] : object forKey:@"fieldValue"] forKey:@"fieldValue"];
    NSData *stream = [jsonObj JSONData];
    [writingSource write:[stream bytes] maxLength:[stream length]];
}

- (void)read:(NSString *)type stream:(NSData *)stream {
    NSDictionary *parsedObject = [stream objectFromJSONData];
    BJGenericBenchmarkRecord *record = [[BJGenericBenchmarkRecord alloc] init];
    if (self.isEnum) {
        NSUInteger ordinal = [BJEnum1Values ordinalForName:[parsedObject objectForKey:@"fieldValue"]];
        BJEnum1Values *value = [[BJEnum1Values alloc] initWithValue:ordinal];
        [record setObject:value atIndex:0];
        [value release];
    } else {
        [record setObject:[parsedObject objectForKey:@"fieldValue"] atIndex:0];
    }
    [record release];
}

- (NSDictionary *)dictionaryFromRecord:(BJModelFilling2 *)record {
    NSMutableDictionary *jsonObj = [[NSMutableDictionary alloc] init];
    [jsonObj setObject:record.listfilling forKey:@"listfilling"];
    [jsonObj setObject:[record.enumfilling name] forKey:@"enumfilling"];
    [jsonObj setObject:record.stringfilling forKey:@"stringfilling"];
    return [jsonObj autorelease];
}

- (NSString *)name {
    return @"JSONKit";
}

- (BOOL)supportMultiThreads {
    return YES;
}

@end
