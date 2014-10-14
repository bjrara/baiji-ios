//
//  BJTestJsonSerializer.m
//  BaijiCore
//
//  Created by Mengyi Zhou on 10/14/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import "BJUnitTestJsonSerializer.h"
#import "BJTestSerializerSample.h"
#import "BJEnum1ValuesSpecific.h"
#import "BJJsonSerializer.h"
#import "BJMutableSpecificRecord.h"
#import "BJMutableRecord.h"

@implementation BJUnitTestJsonSerializer

- (void)testSimpleSerialize {
    BJTestSerializerSample *expected = [[BJTestSerializerSample alloc] init];
    expected.bigint1 = [NSNumber numberWithLong:16 * 1024 * 1024L];
    expected.boolean1 = [NSNumber numberWithBool:NO];
    expected.double1 = [NSNumber numberWithDouble:2.099328];
    expected.enum1 = [[[BJEnum1ValuesSpecific alloc] initWithValue:GREEN] autorelease];
    expected.int1 = [NSNumber numberWithInt:231];
    expected.string1 = @"testSerialize";
    expected.bytes1 = [@"testBytes" dataUsingEncoding:NSUTF8StringEncoding];
    expected.date1 = [NSDate date];
    
    NSData *stream = [self serialize:expected];
    BJTestSerializerSample *actual = [self deserialize:stream clazz:[BJTestSerializerSample class]];
    
    GHAssertTrue([[expected bigint1] isEqual:[actual bigint1]] &&
                 [[expected boolean1] isEqual:[actual boolean1]] &&
                 [[expected double1] isEqual:[actual double1]] &&
                 [[expected enum1] isEqual:[actual enum1]] &&
                 [[expected int1] isEqual:[actual int1]] &&
                 [[expected string1] isEqualToString:[actual string1]], nil);
    GHAssertNil([expected nullableint], nil);
    GHAssertTrue([[expected bytes1] isEqualToData:[expected bytes1]], nil);
    GHAssertEquals((long)[[expected date1] timeIntervalSince1970], (long)[[actual date1] timeIntervalSince1970], nil);
    [expected release];
}

- (void)testNestedSerialize {
    BJTestSerializerSample *expected = [[BJTestSerializerSample alloc] init];
}

- (id<BJMutableRecord>)deserialize:(NSData *)stream clazz:(Class)clazz{
    BJJsonSerializer *serializer = [[[BJJsonSerializer alloc] init] autorelease];
    return [serializer deserialize:clazz from:stream];
}

- (NSData *)serialize:(BJMutableSpecificRecord *)expected {
    BJJsonSerializer *serializer = [[[BJJsonSerializer alloc] init] autorelease];
    return [serializer serialize:expected];
}

@end
