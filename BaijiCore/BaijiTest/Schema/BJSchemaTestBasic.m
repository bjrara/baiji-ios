//
//  BJSchemaTestBasic.m
//  BaijiCore
//
//  Created by user on 14-9-23.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJSchemaTestBasic.h"
#import "BJSchema.h"
#import "BJError.h"

@implementation BJSchemaTestBasic

- (void)testPrimitiveTypes_shortHand {
    [self runTestWithSchema:@"null" referringValidation:YES];
    [self runTestWithSchema:@"boolean" referringValidation:YES];
    [self runTestWithSchema:@"int" referringValidation:YES];
    [self runTestWithSchema:@"long" referringValidation:YES];
    [self runTestWithSchema:@"float" referringValidation:YES];
    [self runTestWithSchema:@"double" referringValidation:YES];
    [self runTestWithSchema:@"bytes" referringValidation:YES];
    [self runTestWithSchema:@"string" referringValidation:YES];
    [self runTestWithSchema:@"\"null\"" referringValidation:YES];
    [self runTestWithSchema:@"\"boolean\"" referringValidation:YES];
    [self runTestWithSchema:@"\"int\"" referringValidation:YES];
    [self runTestWithSchema:@"\"long\"" referringValidation:YES];
    [self runTestWithSchema:@"\"float\"" referringValidation:YES];
    [self runTestWithSchema:@"\"double\"" referringValidation:YES];
    [self runTestWithSchema:@"\"bytes\"" referringValidation:YES];
    [self runTestWithSchema:@"\"string\"" referringValidation:YES];
}

- (void)testPrimitiveTypes_longer {
    [self runTestWithSchema:@"{ \"type\": \"null\" }" referringValidation:YES];
    [self runTestWithSchema:@"{ \"type\": \"boolean\" }" referringValidation:YES];
    [self runTestWithSchema:@"{ \"type\": \"int\" }" referringValidation:YES];
    [self runTestWithSchema:@"{ \"type\": \"long\" }" referringValidation:YES];
    [self runTestWithSchema:@"{ \"type\": \"float\" }" referringValidation:YES];
    [self runTestWithSchema:@"{ \"type\": \"double\" }" referringValidation:YES];
    [self runTestWithSchema:@"{ \"type\": \"bytes\" }" referringValidation:YES];
    [self runTestWithSchema:@"{ \"type\": \"string\" }" referringValidation:YES];
}

- (void)testRecord {
    [self runTestWithSchema:@"{\"type\": \"record\",\"name\": \"Test\",\"fields\": [{\"name\": \"f\",\"type\": \"long\"}]}"
        referringValidation:YES];
    [self runTestWithSchema:@"{\"type\": \"record\",\"name\": \"Test\",\"fields\": [{\"name\": \"f1\",\"type\": \"long\"},{\"name\": \"f2\", \"type\": \"int\"}]}"
        referringValidation:YES];
    [self runTestWithSchema:@"{\"type\": \"error\",\"name\": \"Test\",\"fields\": [{\"name\": \"f1\",\"type\": \"long\"},{\"name\": \"f2\", \"type\": \"int\"}]}"
        referringValidation:YES];
    [self runTestWithSchema:@"{\"type\":\"record\",\"name\":\"LongList\",\"fields\":[{\"name\":\"value\",\"type\":\"long\"},{\"name\":\"next\",\"type\":[\"LongList\",\"null\"]}]}"
        referringValidation:YES];
    [self runTestWithSchema:@"{\"type\":\"record\",\"name\":\"LongList\",\"fields\":[{\"name\":\"value\",\"type\":\"long\"},{\"name\":\"next\",\"type\":[\"LongListA\",\"null\"]}]}"
        referringValidation:NO];
    [self runTestWithSchema:@"{\"type\":\"record\",\"name\":\"LongList\"}"
        referringValidation:NO];
    [self runTestWithSchema:@"{\"type\":\"record\",\"name\":\"LongList\", \"fields\": \"hi\"}"
        referringValidation:NO];
}

- (void)testEnum {
    [self runTestWithSchema:@"{\"type\": \"enum\", \"name\": \"Test\", \"symbols\": [\"A\", \"B\"]}"
        referringValidation:YES];
    [self runTestWithSchema:@"{\"type\": \"enum\", \"name\": \"Status\", \"symbols\": \"Normal Caution Critical\"}"
        referringValidation:NO];
    [self runTestWithSchema:@"{\"type\": \"enum\", \"name\": [ 0, 1, 1, 2, 3, 5, 8 }, \"symbols\": [\"Golden\", \"Mean\"]}"
        referringValidation:NO];
    [self runTestWithSchema:@"{\"type\": \"enum\", \"symbols\" : [\"I\", \"will\", \"fail\", \"no\", \"name\"]}"
        referringValidation:NO];
    [self runTestWithSchema:@"{\"type\": \"enum\", \"name\": \"Test\", \"symbols\" : [\"AA\", \"AA\"]}"
        referringValidation:NO];
}

- (void)testArray {
    [self runTestWithSchema:@"{\"type\": \"array\", \"items\": \"long\"}" referringValidation:YES];
    [self runTestWithSchema:@"{\"type\": \"array\",\"items\": {\"type\": \"enum\", \"name\": \"Test\", \"symbols\": [\"A\", \"B\"]}}"
        referringValidation:YES];
}

- (void)testMap {
    [self runTestWithSchema:@"{\"type\": \"map\", \"values\": \"long\"}" referringValidation:YES];
    [self runTestWithSchema:@"{\"type\": \"map\",\"values\": {\"type\": \"enum\", \"name\": \"Test\", \"symbols\": [\"A\", \"B\"]}}"
        referringValidation:YES];
}

- (void)testUnion {
    [self runTestWithSchema:@"[\"string\", \"null\", \"long\"]" referringValidation:YES];
    [self runTestWithSchema:@"[\"string\", \"long\", \"long\"]" referringValidation:NO];
    [self runTestWithSchema:@"[{\"type\": \"array\", \"items\": \"long\"}, {\"type\": \"array\", \"items\": \"string\"}]"
        referringValidation:NO];
}

- (void)runTestWithSchema:(NSString *)jSchema referringValidation:(BOOL)valid {
    @try {
        [BJSchema parse:jSchema];
        GHAssertTrue(valid, nil);
    } @catch (NSException *ex) {
        if(valid)
            @throw [NSException exceptionWithName:BJSchemaParseException reason:@"Parse failure." userInfo:nil];
        GHAssertFalse(valid, nil);
    }
}

@end
