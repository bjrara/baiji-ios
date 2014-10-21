//
//  BJPerfTestJsonSerializer.m
//  BaijiCore
//
//  Created by zmy周梦伊 on 10/21/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import "BJPerfTestJsonSerializer.h"
#import "BJTestSerializerSample.h"
#import "BJEnum1Values.h"
#import "BJEnum2Values.h"
#import "BJRecord.h"
#import "BJRecord2.h"
#import "BJRecord2Container.h"
#import "BJJsonSerializer.h"
#import "JSONKit.h"

@implementation BJPerfTestJsonSerializer

+ (BJJsonSerializer *)serializer {
    static BJJsonSerializer *__serializer;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __serializer = [[BJJsonSerializer alloc] init];
    });
    return __serializer;
}

- (void)testMultiThreadSerialize {
    const int loop = 10;
    for (int i = 0; i < loop; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            long identifier = [[NSThread currentThread] hash] + i;
            BJTestSerializerSample *expected = [self sampleWithId:identifier];
            NSData *stream = [[BJPerfTestJsonSerializer serializer] serialize:expected];
            BJTestSerializerSample *actual = [[BJPerfTestJsonSerializer serializer] deserialize:[BJTestSerializerSample class] from:stream];
            [self checkActual:actual referring:expected];
            GHAssertEquals([expected.bigint1 longValue], identifier, nil);
        });
    }
}

- (void)checkActual:(BJTestSerializerSample *)actual
          referring:(BJTestSerializerSample *)expected {
    GHAssertTrue([[expected bigint1] isEqual:[actual bigint1]] &&
                 [[expected boolean1] isEqual:[actual boolean1]] &&
                 [[expected double1] isEqual:[actual double1]] &&
                 [[expected enum1] isEqual:[actual enum1]] &&
                 [[expected int1] isEqual:[actual int1]] &&
                 [[expected string1] isEqualToString:[actual string1]], nil);
    GHAssertNil([expected nullableint], nil);
    GHAssertTrue([[expected bytes1] isEqualToData:[expected bytes1]], nil);
    GHAssertEquals((long)[[expected date1] timeIntervalSince1970], (long)[[actual date1] timeIntervalSince1970], nil);
    
    GHAssertTrue([[expected list1] isEqualToArray:[actual list1]] &&
                 [[expected map1] isEqualToDictionary:[actual map1]], nil);
    GHAssertTrue([[expected record] isEqual:[actual record]], nil);
    
    BJRecord2 *expectedRecord2 = [expected.container1.record2List objectAtIndex:0];
    BJRecord2 *actualRecord2 = [actual.container1.record2List objectAtIndex:0];
    
    GHAssertTrue([[expectedRecord2 bigint2] isEqual:[actualRecord2 bigint2]], nil);
    GHAssertTrue([[expectedRecord2 enum2] isEqual:[actualRecord2 enum2]], nil);
    GHAssertTrue([[expectedRecord2 map2] isEqualToDictionary:[actualRecord2 map2]], nil);
}

- (BJTestSerializerSample *)sampleWithId:(long)identifier {
    BJTestSerializerSample *sample = [[BJTestSerializerSample alloc] init];
    sample.bigint1 = [NSNumber numberWithLong:identifier];
    sample.boolean1 = [NSNumber numberWithBool:NO];
    sample.double1 = [NSNumber numberWithDouble:2.099328];
    sample.enum1 = [[[BJEnum1Values alloc] initWithValue:BJEnum1ValuesGREEN] autorelease];
    sample.int1 = [NSNumber numberWithInt:2000];
    sample.string1 = @"testSerialize";
    sample.bytes1 = [@"testBytes" dataUsingEncoding:NSUTF8StringEncoding];
    sample.date1 = [NSDate date];
    sample.list1 = [NSArray arrayWithObjects:@"a", @"b", @"c", nil];
    NSMutableDictionary *map1 = [[NSMutableDictionary alloc] init];
    [map1 setObject:[NSNumber numberWithInt:1] forKey:@"1a"];
    [map1 setObject:[NSNumber numberWithInt:2] forKey:@"2b"];
    [map1 setObject:[NSNumber numberWithInt:3] forKey:@"3c"];
    sample.map1 = map1;
    sample.record = [[[BJRecord alloc] initWithSBoolean:[NSNumber numberWithBool:NO] sInt:[NSNumber numberWithInt:1] sString:@"testRecord"] autorelease];
    sample.container1 = [[[BJRecord2Container alloc] initWithRecord2List:[NSArray arrayWithObjects:[self record2], nil]] autorelease];
    [map1 release];
    return [sample autorelease];
}

- (BJRecord2 *)record2 {
    BJRecord2 *record2 = [[BJRecord2 alloc] init];
    record2.bigint2 = [NSNumber numberWithLong:2048L];
    record2.enum2 = [[[BJEnum2Values alloc] initWithValue:BJEnum2ValuesPLANE] autorelease];
    NSMutableDictionary *recordMap = [[NSMutableDictionary alloc] init];
    [recordMap setObject:[[BJRecord alloc] initWithSBoolean:[NSNumber numberWithBool:YES] sInt:[NSNumber numberWithInt:1] sString:@"testRecord"] forKey:@"m1"];
    [recordMap setObject:[[BJRecord alloc] initWithSBoolean:[NSNumber numberWithBool:YES] sInt:[NSNumber numberWithInt:2] sString:@"testRecord"] forKey:@"m2"];
    record2.map2 = recordMap;
    [recordMap release];
    return [record2 autorelease];
}

@end
