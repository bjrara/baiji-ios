//
//  BJSchemaTestArray.m
//  BaijiCore
//
//  Created by user on 14-9-23.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJSchemaTestArray.h"
#import "BJSchema.h"
#import "BJArraySchema.h"

@implementation BJSchemaTestArray

- (void)testArray {
    [self runTestWithSchema:@"{\"type\": \"array\", \"items\": \"long\"}" referringItemType:@"long"];
}

- (void)runTestWithSchema:(NSString *)jSchema referringItemType:(NSString *)itemType {
    BJSchema *schema = [BJSchema parse:jSchema];
    GHAssertTrue([schema isKindOfClass:[BJArraySchema class]], nil);
    GHAssertEquals(BJSchemaTypeArray, [schema type], nil);
    
    BJArraySchema *ars = (BJArraySchema *)schema;
    GHAssertEquals(itemType, [[ars itemSchema] name], nil);
    
    [BJSchemaTestBase string:jSchema isEqualToSchema:schema];
    [BJSchemaTestBase validateDescription:schema];
}

@end
