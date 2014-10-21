//
//  BJBenchmarkSerializer.m
//  BaijiCore
//
//  Created by zmy周梦伊 on 10/21/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import "BJBenchmarkSerializer.h"
#import "BJGenericBenchmarkRecord.h"
#import "BJJsonSerializer.h"

@implementation BJBenchmarkSerializer

+ (BJJsonSerializer *)serializer {
    static BJJsonSerializer *__serializer;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __serializer = [[BJJsonSerializer alloc] init];
    });
    return __serializer;
}

- (void)benchmarkInt {
    [self benchmarkSingleField:[NSNumber numberWithInt:42] forType:@"\"int\""];
}

- (void)benchmarkBoolean {
    [self benchmarkSingleField:[NSNumber numberWithBool:YES] forType:@"\"boolean\""];
}

- (void)benchmarkLong {
    [self benchmarkSingleField:[NSNumber numberWithLong:1024 *1024 * 16L] forType:@"\"long\""];
}

- (void)benchmarkDouble {
    [self benchmarkSingleField:[NSNumber numberWithDouble:24.0000001] forType:@"\"double\""];
}

- (void)benchmarkString {
    [self benchmarkSingleField:@"testString" forType:@"\"string\""];
}

- (void)benchmarkEnum {
    [self benchmarkSingleField:1 forType:@"{\"type\":\"enum\",\"name\":\"Enum1Values\",\"namespace\":\"com.ctriposs.baiji.specific\",\"doc\":null,\"symbols\":[\"BLUE\",\"RED\",\"GREEN\"]}"];
}

- (void)benchmarkBytes {
    [self benchmarkSingleField:@"testBytes" forType:@"\"bytes\""];
}

- (void)benchmarkSingleField:(id)fieldValue
                     forType:(NSString *)fieldType {
    [BJGenericBenchmarkRecord setRecordType:fieldType];
    BJGenericBenchmarkRecord *record = [[BJGenericBenchmarkRecord alloc] init];
    [record setObject:fieldValue atIndex:0];
    
    NSData *stream = [[BJBenchmarkSerializer serializer] serialize:record];
    [[BJBenchmarkSerializer serializer]deserialize:[BJGenericBenchmarkRecord class] from:stream];
}

@end
