//
//  BJSchemaTestUnion.m
//  BaijiCore
//
//  Created by user on 14-9-23.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJSchemaTestUnion.h"
#import "BJSchema.h"
#import "BJUnionSchema.h"

@implementation BJSchemaTestUnion

- (void)testUnion {
    [self runTestWithSchema:@"[\"string\", \"null\", \"long\"]"
             referringTypes:[NSArray arrayWithObjects:@"string", @"null", @"long", nil]];
}

- (void)runTestWithSchema:(NSString *)jSchema referringTypes:(NSArray *)types {
    BJSchema *schema = [BJSchema parse:jSchema];
    GHAssertTrue([schema isKindOfClass:[BJUnionSchema class]], nil);
    GHAssertEquals(BJSchemaTypeUnion, [schema type], nil);
    
    BJUnionSchema *us = (BJUnionSchema *)schema;
    GHAssertEquals([types count], [us count], nil);
    for (int i = 0; i < [us count]; i++) {
        GHAssertEquals([types objectAtIndex:i], [[[us schemas] objectAtIndex:i] name], nil);
    }
    
    [BJSchemaTestBase string:jSchema isEqualToSchema:schema];
    [BJSchemaTestBase validateDescription:schema];
}

@end
