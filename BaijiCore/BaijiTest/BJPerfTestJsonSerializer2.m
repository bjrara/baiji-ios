//
//  BJPerfTestJsonSerializer2.m
//  BaijiCore
//
//  Created by zmy周梦伊 on 10/29/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import "BJPerfTestJsonSerializer2.h"
#import "BJJsonSerializer.h"
#import "BJTestSerializerSampleList.h"

@implementation BJPerfTestJsonSerializer2

- (void)setUp {
    [self testDeserializeWithSrc:@"b10records"];
}

- (void)testDeserialize_71kb {
    float result = [self testDeserializeWithSrc:@"b10records"];
    GHTestLog(@"Deserialize 71kb: %0.3f μs", result);
}

- (void)testDeserialize_357kb {
    float result = [self testDeserializeWithSrc:@"b50records"];
    GHTestLog(@"Deserialize 357kb: %0.3f μs", result);
}

- (void)testDeserialize_6kb {
    float result = [self testDeserializeWithSrc:@"t10records"];
    GHTestLog(@"Deserialize 6kb: %0.3f μs", result);
}

- (void)testDeserialize_29kb {
    float result = [self testDeserializeWithSrc:@"t50records"];
    GHTestLog(@"Deserialize 29kb: %0.3f μs", result);
}

- (float)testDeserializeWithSrc:(NSString *)fileName {
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", fileName] ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    BJJsonSerializer *serializer = [[BJJsonSerializer alloc] init];
    NSDate *start = [NSDate date];
    for (int i = 0; i < 10; i++) {
        [serializer deserialize:[BJTestSerializerSampleList class] from:data];
    }
    [serializer release];
    return -[start timeIntervalSinceNow] * 1000 * 1000 / 10;
}

@end