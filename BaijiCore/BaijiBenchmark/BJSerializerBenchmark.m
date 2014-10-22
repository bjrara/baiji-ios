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
#import "SBJson4StreamParser.h"
#import "BJSpecificEnum.h"

@implementation BJSerializerBenchmark

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
    benchmark([[[BJEnum1Values alloc] initWithValue:BJEnum1ValuesRED] autorelease], @"{\"type\":\"enum\",\"name\":\"Enum1Values\",\"namespace\":\"com.ctriposs.baiji.specific\",\"doc\":null,\"symbols\":[\"BLUE\",\"RED\",\"GREEN\"]}");
}

- (void)benchmarkBytes:(BJBenchmark)benchmark {
    benchmark([@"testBytes" dataUsingEncoding:NSUTF8StringEncoding], @"\"bytes\"");
}

- (void)benchmarkArray:(BJBenchmark)benchmark {
    benchmark([NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], nil], @"{\"type\":\"array\",\"items\":\"int\"}");
}

- (void)benchmarkMap:(BJBenchmark)benchmark {
    NSMutableDictionary *map = [[NSMutableDictionary alloc] init];
    [map setObject:[NSNumber numberWithInt:1] forKey:@"1a"];
    [map setObject:[NSNumber numberWithInt:2] forKey:@"2b"];
    [map setObject:[NSNumber numberWithInt:3] forKey:@"3c"];
    benchmark(map, @"{\"type\":\"map\",\"values\":\"int\"}");
    [map release];
}

- (void)batch {
    [self benchmarkInt:^(id object, NSString *type) {
        [self.serializerDelegate benchmark:type fieldValue:object];
    }];
    [self benchmarkBoolean:^(id object, NSString *type) {
        [self.serializerDelegate benchmark:type fieldValue:object];
    }];
    [self benchmarkLong:^(id object, NSString *type) {
        [self.serializerDelegate benchmark:type fieldValue:object];
    }];
    [self benchmarkDouble:^(id object, NSString *type) {
        [self.serializerDelegate benchmark:type fieldValue:object];
    }];
    [self benchmarkString:^(id object, NSString *type) {
        [self.serializerDelegate benchmark:type fieldValue:object];
    }];
    [self benchmarkEnum:^(id object, NSString *type) {
        [self.serializerDelegate benchmark:type fieldValue:object];
    }];
    [self benchmarkArray:^(id object, NSString *type) {
        [self.serializerDelegate benchmark:type fieldValue:object];
    }];
    [self benchmarkMap:^(id object, NSString *type) {
        [self.serializerDelegate benchmark:type fieldValue:object];
    }];
}

- (void)dealloc {
    [self.serializerDelegate release];
    [super dealloc];
}

@end

@interface BJJsonSerializerBenchmark()

@property (nonatomic, strong) BJJsonSerializer *serializer;

@end

@implementation BJJsonSerializerBenchmark

@synthesize masterDelegate = _masterDelegate;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.serializer = [[BJJsonSerializer alloc] init];
    }
    return self;
}

- (void)benchmark:(NSString *)type fieldValue:(id)object {
    float writingResult;
    float readingResult;
    [BJGenericBenchmarkRecord clear];
    [BJGenericBenchmarkRecord setRecordType:type];
    BJGenericBenchmarkRecord *jsonObj = [[BJGenericBenchmarkRecord alloc] init];
    [jsonObj setObject:object atIndex:0];
    
    NSOutputStream *writingSource = [[NSOutputStream alloc] initToMemory];
    [writingSource open];
    NSDate *start = [NSDate date];
    for (int i = 0; i < 10; i++) {
        NSData *stream = [self.serializer serialize:jsonObj];
        [writingSource write:[stream bytes] maxLength:[stream length]];
    }
    writingResult = -[start timeIntervalSinceNow] * 1000 / 10;
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
        [self.serializer deserialize:[BJGenericBenchmarkRecord class] from:[NSData dataWithBytes:buffer length:length/10]];
    }
    readingResult = -[start timeIntervalSinceNow] * 1000 / 10;
    [readingSource close];
    [readingSource release];
    [temp release];
    
    [self notifyResult:type writing:writingResult reading:readingResult];
}

- (void)notifyResult:(NSString *)type writing:(float)writingResult reading:(float)readingResult {
    [self.masterDelegate serializer:@"BaijiJSON" didFinish:type writing:writingResult reading:readingResult];
}

- (void)dealloc {
    [self.masterDelegate release];
    [self.serializer release];
    [super dealloc];
}

@end

@implementation BJAppleJsonSerializerBenchmark

@synthesize masterDelegate = _masterDelegate;

- (void)benchmark:(NSString *)type fieldValue:(id)object {
    if ([object isKindOfClass:[BJSpecificEnum class]]) {
        object = [((BJSpecificEnum *)object) name];
    }
    float writingResult;
    float readingResult;
    
    NSDictionary *jsonObj = [NSDictionary dictionaryWithObject:object forKey:@"fieldValue"];
    NSOutputStream *writingSource = [[NSOutputStream alloc] initToMemory];
    [writingSource open];
    NSDate *start = [NSDate date];
    for (int i = 0; i < 10; i++) {
        [NSJSONSerialization writeJSONObject:jsonObj toStream:writingSource options:NSJSONWritingPrettyPrinted error:nil];
    }
    writingResult = -[start timeIntervalSinceNow] * 1000 / 10;
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
        [NSJSONSerialization JSONObjectWithData:[NSData dataWithBytes:buffer length:length/10] options:NSJSONReadingAllowFragments error:nil];
    }
    readingResult = -[start timeIntervalSinceNow] * 1000 / 10;
    [readingSource close];
    [readingSource release];
    [temp release];
    
    [self notifyResult:type writing:writingResult reading:readingResult];
    
}

- (void)notifyResult:(NSString *)type writing:(float)writingResult reading:(float)readingResult {
    [self.masterDelegate serializer:@"NSJSONSerialization" didFinish:type writing:writingResult reading:readingResult];
}

- (void)dealloc {
    [self.masterDelegate release];
    [super dealloc];
}

@end

@interface BJSBJsonSerializerBenchmark()

@property (nonatomic, strong) SBJson4StreamParser *deserializer;
@property (nonatomic, strong) SBJson4Writer *serializer;

@end

@implementation BJSBJsonSerializerBenchmark

@synthesize masterDelegate = _masterDelegate;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.deserializer = [[SBJson4StreamParser alloc] init];
        self.serializer = [[SBJson4Writer alloc] init];
    }
    return self;
}

- (void)benchmark:(NSString *)type fieldValue:(id)object {
    if ([object isKindOfClass:[BJSpecificEnum class]]) {
        object = [((BJSpecificEnum *)object) name];
    }
    
    float writingResult;
    float readingResult;
    
    NSDictionary *jsonObj = [NSDictionary dictionaryWithObject:object forKey:@"fieldValue"];
    NSOutputStream *writingSource = [[NSOutputStream alloc] initToMemory];
    [writingSource open];
    NSDate *start = [NSDate date];
    for (int i = 0; i < 10; i++) {
        NSData *stream = [self.serializer dataWithObject:jsonObj];
        [writingSource write:[stream bytes] maxLength:[stream length]];
    }
    writingResult = -[start timeIntervalSinceNow] * 1000 / 10;
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
        [self.deserializer parse:[NSData dataWithBytes:buffer length:length/10]];
    }
    readingResult = -[start timeIntervalSinceNow] * 1000 / 10;
    [readingSource close];
    [readingSource release];
    [temp release];
    
    [self notifyResult:type writing:writingResult reading:readingResult];
}

- (void)notifyResult:(NSString *)type writing:(float)writingResult reading:(float)readingResult {
    [self.masterDelegate serializer:@"SBJSON" didFinish:type writing:writingResult reading:readingResult];
}

- (void)dealloc {
    [self.masterDelegate release];
    [self.serializer release];
    [self.deserializer release];
    [super dealloc];
}

@end
