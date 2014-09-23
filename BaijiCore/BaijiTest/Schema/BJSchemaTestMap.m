//
//  BJSchemaTestMap.m
//  BaijiCore
//
//  Created by user on 14-9-23.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJSchemaTestMap.h"
#import "BJSchema.h"
#import "BJMapSchema.h"

@implementation BJSchemaTestMap

- (void)testMap {
    [self runTestWithSchema:@"{\"type\": \"map\", \"values\": \"long\"}" referringValueType:@"long"];
}

- (void)runTestWithSchema:(NSString *)jSchema referringValueType:(NSString *)valueType {
    BJSchema *schema = [BJSchema parse:jSchema];
    GHAssertTrue([schema isKindOfClass:[BJMapSchema class]], nil);
    GHAssertEquals(BJSchemaTypeMap, [schema type], nil);
    
    BJMapSchema *ms = (BJMapSchema *)schema;
    GHAssertEquals(valueType, [[ms valueSchema] name], nil);
    
    [BJSchemaTestBase string:jSchema isEqualToSchema:schema];
    [BJSchemaTestBase validateDescription:schema];
}

@end