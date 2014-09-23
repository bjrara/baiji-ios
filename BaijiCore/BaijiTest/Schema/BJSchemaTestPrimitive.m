//
//  BJSchemaTestPrimitive.m
//  BaijiCore
//
//  Created by user on 14-9-22.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJSchemaTestPrimitive.h"
#import "BJSchema.h"
#import "BJPrimitiveSchema.h"

@implementation BJSchemaTestPrimitive

- (void)testNull {
    [self testPrimitiveBySchema:@"null" type:BJSchemaTypeNull];
    [self testPrimitiveBySchema:@"{ \"type\": \"null\" }" type:BJSchemaTypeNull];
}

- (void)testBoolean {
    [self testPrimitiveBySchema:@"boolean" type:BJSchemaTypeBoolean];
    [self testPrimitiveBySchema:@"{ \"type\": \"boolean\" }" type:BJSchemaTypeBoolean];
}

- (void)testInt {
    [self testPrimitiveBySchema:@"int" type:BJSchemaTypeInt];
    [self testPrimitiveBySchema:@"{ \"type\": \"int\" }" type:BJSchemaTypeInt];
}

- (void)testLong {
    [self testPrimitiveBySchema:@"long" type:BJSchemaTypeLong];
    [self testPrimitiveBySchema:@"{ \"type\": \"long\" }" type:BJSchemaTypeLong];
}

- (void)testFloat {
    [self testPrimitiveBySchema:@"float" type:BJSchemaTypeFloat];
    [self testPrimitiveBySchema:@"{ \"type\": \"float\" }" type:BJSchemaTypeFloat];
}

- (void)testDouble {
    [self testPrimitiveBySchema:@"double" type:BJSchemaTypeDouble];
    [self testPrimitiveBySchema:@"{ \"type\": \"double\" }" type:BJSchemaTypeDouble];
}

- (void)testBytes {
    [self testPrimitiveBySchema:@"bytes" type:BJSchemaTypeBytes];
    [self testPrimitiveBySchema:@"{ \"type\": \"bytes\" }" type:BJSchemaTypeBytes];
}

- (void)testString {
    [self testPrimitiveBySchema:@"string" type:BJSchemaTypeString];
    [self testPrimitiveBySchema:@"{ \"type\": \"string\" }" type:BJSchemaTypeString];
}

- (void)testPrimitiveBySchema:(NSString *)jSchema type:(BJSchemaType)type {
    BJSchema *schema = [BJSchema parse:jSchema];
    GHAssertTrue([schema isKindOfClass:[BJPrimitiveSchema class]], nil);
    GHAssertEquals(type, [schema type], nil);
    GHAssertTrue([BJSchemaTestBase string:jSchema isEqualToSchema:schema], nil);
    GHAssertTrue([BJSchemaTestBase validateDescription:schema], nil);
}
@end
