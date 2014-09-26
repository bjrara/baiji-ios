//
//  BJUnitTestSerializer.m
//  BaijiCore
//
//  Created by user on 14-9-25.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJUnitTestSerializer.h"
#import "BJTestSerializerSample.h"
#import "BJEnum1ValuesSpecific.h"
#import "BJSpecificJsonWriter.h"
#import "JSONKit.h"

@implementation BJUnitTestSerializer

- (void)testBoolean {
    [self runTestField:@"boolean1" value:[NSNumber numberWithBool:YES]];
}

- (void)testInt {
    [self runTestField:@"int1" value:[NSNumber numberWithInt:42]];
}

- (void)testLong {
    [self runTestField:@"bigint1" value:[NSNumber numberWithLong:1024L * 1024L * 16L]];
}

- (void)testDouble {
    [self runTestField:@"double1" value:[NSNumber numberWithDouble:24.00000001]];
}

- (void)testString {
    [self runTestField:@"string1" value:@"testString"];
}

- (void)testBytes {
    NSData *bytes = [@"testBytes" dataUsingEncoding:NSUTF8StringEncoding];
    [self runTestField:@"bytes1" value:bytes];
}

- (void)testDateTime {
    [self runTestField:@"date1" value:[NSDate date]];
}

- (void)testEnum {
    BJEnum1ValuesSpecific *enum1 = [[BJEnum1ValuesSpecific alloc] init];
    [enum1 setValue:RED];
    [self runTestField:@"enum1" value:enum1];
}

- (void)testArray {
    [self runTestField:@"list1" value:[NSArray arrayWithObjects:@"a", @"b", @"c", nil]];
}

- (void)testMap {
    NSMutableDictionary *map = [[NSMutableDictionary alloc] init];
    [map setObject:[NSNumber numberWithInt:1] forKey:@"1a"];
    [map setObject:[NSNumber numberWithInt:2] forKey:@"2b"];
    [map setObject:[NSNumber numberWithInt:3] forKey:@"3c"];
    [self runTestField:@"map1" value:map];
    [map release];
}

- (void)testNullable {
    [self runTestField:@"nullableint" value:[NSNumber numberWithInt:1]];
    [self runTestField:@"nullableint" value:nil];
}

- (void)runTestField:(NSString *)fieldName value:(id)value {
    [self serializeAndDeserializeField:fieldName value:value];
}

- (BJTestSerializerSample *)serializeAndDeserializeField:(NSString *)fieldName value:(id)value {
    BJTestSerializerSample *record = [[BJTestSerializerSample alloc] init];
    [record setObject:value forName:fieldName];
    BJSpecificJsonWriter *writer = [[BJSpecificJsonWriter alloc] init];
    NSData *data = [writer writeObject:record];
    id test = [data objectFromJSONData];
    GHTestLog(@"%@", [test description]);
    return nil;
}
@end
