//
//  BJUnitTestSerializer.m
//  BaijiCore
//
//  Created by user on 14-9-25.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJUnitTestSerialization.h"
#import "BJTestSerializerSample.h"
#import "BJSpecificJsonWriter.h"
#import "BJSpecificJsonParser.h"
#import "BJEnum1Values.h"

@implementation BJUnitTestSerialization

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
    BJEnum1Values *enum1 = [[BJEnum1Values alloc] init];
    [enum1 setValue:BJEnum1ValuesRED];
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
    BJTestSerializerSample *r2 = [self serializeAndDeserializeField:fieldName value:value];
    if ([value isKindOfClass:[NSDate class]]){
        long interval1 = [((NSDate *)value) timeIntervalSince1970];
        long interval2 = [((NSDate *)[r2 fieldForName:fieldName]) timeIntervalSince1970];
        GHAssertTrue(interval1 == interval2, nil);
        return;
    }
    if(value == nil) {
        GHAssertNULL([r2 fieldForName:fieldName], nil);
        return;
    }
    GHAssertTrue([value isEqual:[r2 fieldForName:fieldName]], nil);
}

- (BJTestSerializerSample *)serializeAndDeserializeField:(NSString *)fieldName value:(id)value {
    BJTestSerializerSample *record = [[BJTestSerializerSample alloc] init];
    [record setObject:value forName:fieldName];
    
    BJSpecificJsonWriter *writer = [[BJSpecificJsonWriter alloc] init];
    NSData *data = [writer writeObject:record];
    GHTestLog(@"%@", [[data objectFromJSONData] description]);
    BJSpecificJsonParser *parser = [[BJSpecificJsonParser alloc] init];
    return [parser readData:data clazz:[BJTestSerializerSample class]];
}
@end
