//
//  BJSchemaTestEnum.m
//  BaijiCore
//
//  Created by user on 14-9-22.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJSchemaTestEnum.h"
#import "BJEnumSchema.h"
#import "BJSchema.h"

@implementation BJSchemaTestEnum

- (void)testEnum_2 {
    NSMutableDictionary *values = [[NSMutableDictionary alloc] init];
    [values setObject:[NSNumber numberWithInt:0] forKey:@"A"];
    [values setObject:[NSNumber numberWithInt:1] forKey:@"B"];
    [self runTestWithSchema:@"{\"type\": \"enum\", \"name\": \"Test\", \"symbols\": [\"A\", \"B\"]}"
           referringSymbols:[NSArray arrayWithObjects:@"A", @"B", nil]
               symbolValues:values];
    [values release];
}

- (void)testEnum_5 {
    NSMutableDictionary *values = [[NSMutableDictionary alloc] init];
    [values setObject:[NSNumber numberWithInt:0] forKey:@"A"];
    [values setObject:[NSNumber numberWithInt:1] forKey:@"B"];
    [values setObject:[NSNumber numberWithInt:5] forKey:@"C"];
    [values setObject:[NSNumber numberWithInt:6] forKey:@"D"];
    [values setObject:[NSNumber numberWithInt:1] forKey:@"E"];
    [values setObject:[NSNumber numberWithInt:7] forKey:@"F"];
    [self runTestWithSchema:@"{\"type\": \"enum\", \"name\": \"Test\", \"symbols\": [\"A\", \"B\", {\"name\": \"C\", \"value\": 5}, \"D\", {\"name\": \"E\", \"value\": 1}, {\"name\": \"F\", \"value\": 7}]}"
           referringSymbols:[NSArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", nil]
               symbolValues:values];
    [values release];
    
}

- (void)runTestWithSchema:(NSString *)jSchema referringSymbols:(NSArray *)symbols symbolValues:(NSDictionary *)values {
    BJSchema *schema = [BJSchema parse:jSchema];
    GHAssertTrue([schema isKindOfClass:[BJEnumSchema class]], nil);
    GHAssertEquals(BJSchemaTypeEnum, [schema type], nil);
    BJEnumSchema *es = (BJEnumSchema *)schema;
    GHAssertEquals([symbols count], [es size], nil);
    
    int i = 0;
    int lastValue = -1;
    for(NSString *symbol in [es symbols]) {
        NSString *expectedSymbol = [symbols objectAtIndex:i++];
        GHAssertTrue([expectedSymbol isEqualToString: symbol], nil);
        NSNumber *expectedValue = [values objectForKey:expectedSymbol];
        expectedValue = expectedValue != nil ? expectedValue : [NSNumber numberWithInt:lastValue + 1];
        GHAssertEquals([expectedValue intValue], [es oridinalForSymbol:symbol], nil);
        lastValue = [expectedValue intValue];
    }
    GHAssertTrue([BJSchemaTestBase string:jSchema isEqualToSchema:schema], nil);
    GHAssertTrue([BJSchemaTestBase validateDescription:schema], nil);
}

@end