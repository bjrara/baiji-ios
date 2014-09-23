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
    [self runTestWithSchema:@"null" referringType:BJSchemaTypeNull];
    [self runTestWithSchema:@"{ \"type\": \"null\" }" referringType:BJSchemaTypeNull];
}

- (void)testBoolean {
    [self runTestWithSchema:@"boolean" referringType:BJSchemaTypeBoolean];
    [self runTestWithSchema:@"{ \"type\": \"boolean\" }" referringType:BJSchemaTypeBoolean];
}

- (void)testInt {
    [self runTestWithSchema:@"int" referringType:BJSchemaTypeInt];
    [self runTestWithSchema:@"{ \"type\": \"int\" }" referringType:BJSchemaTypeInt];
}

- (void)testLong {
    [self runTestWithSchema:@"long" referringType:BJSchemaTypeLong];
    [self runTestWithSchema:@"{ \"type\": \"long\" }" referringType:BJSchemaTypeLong];
}

- (void)testFloat {
    [self runTestWithSchema:@"float" referringType:BJSchemaTypeFloat];
    [self runTestWithSchema:@"{ \"type\": \"float\" }" referringType:BJSchemaTypeFloat];
}

- (void)testDouble {
    [self runTestWithSchema:@"double" referringType:BJSchemaTypeDouble];
    [self runTestWithSchema:@"{ \"type\": \"double\" }" referringType:BJSchemaTypeDouble];
}

- (void)testBytes {
    [self runTestWithSchema:@"bytes" referringType:BJSchemaTypeBytes];
    [self runTestWithSchema:@"{ \"type\": \"bytes\" }" referringType:BJSchemaTypeBytes];
}

- (void)testString {
    [self runTestWithSchema:@"string" referringType:BJSchemaTypeString];
    [self runTestWithSchema:@"{ \"type\": \"string\" }" referringType:BJSchemaTypeString];
}

- (void)runTestWithSchema:(NSString *)jSchema referringType:(BJSchemaType)type {
    BJSchema *schema = [BJSchema parse:jSchema];
    GHAssertTrue([schema isKindOfClass:[BJPrimitiveSchema class]], nil);
    GHAssertEquals(type, [schema type], nil);
    GHAssertTrue([BJSchemaTestBase string:jSchema isEqualToSchema:schema], nil);
    GHAssertTrue([BJSchemaTestBase validateDescription:schema], nil);
}
@end
