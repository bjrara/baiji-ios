//
//  BJSchemaTestRecord.m
//  BaijiCore
//
//  Created by user on 14-9-23.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJSchemaTestRecord.h"
#import "BJSchema.h"
#import "BJRecordSchema.h"
#import "BJField.h"

@implementation BJSchemaTestRecord

- (void)testRecord1 {
    [self runTestWithSchema:@"{\"type\":\"record\",\"name\":\"LongList\",\"fields\":[{\"name\":\"f1\",\"type\":\"long\"},{\"name\":\"f2\",\"type\": \"int\"}]}"
            referringFields:[NSArray arrayWithObjects:@"f1", @"long", @"100", @"f2", @"int", @"10", nil]];
}

- (void)testRecord2 {
    [self runTestWithSchema:@"{\"type\":\"record\",\"name\":\"LongList\",\"fields\":[{\"name\":\"f1\",\"type\":\"long\", \"default\": \"100\"},{\"name\":\"f2\",\"type\": \"int\"}]}"
            referringFields:[NSArray arrayWithObjects:@"f1", @"long", @"100", @"f2", @"int", @"10", nil]];
}

- (void)testRecord3 {
    [self runTestWithSchema:@"{\"type\":\"record\",\"name\":\"LongList\",\"fields\":[{\"name\":\"value\",\"type\":\"long\", \"default\": \"100\"},{\"name\":\"next\",\"type\":[\"LongList\",\"null\"]}]}"
            referringFields:[NSArray arrayWithObjects:@"value", @"long", @"100", @"next", @"union", @"", nil]];
}

- (void)runTestWithSchema:(NSString *)jSchema referringFields:(NSArray *)fields {
    BJSchema *schema = [BJSchema parse:jSchema];
    GHAssertTrue([schema isKindOfClass:[BJRecordSchema class]], nil);
    GHAssertEquals(BJSchemaTypeRecord, [schema type], nil);
    
    BJRecordSchema *rs = (BJRecordSchema *)schema;
    GHAssertEquals([fields count] / 3, [rs count], nil);
    for (int i = 0; i < [fields count]; i += 3) {
        BJField *f = [rs fieldForName:[fields objectAtIndex:i]];
        GHAssertEqualStrings([fields objectAtIndex: i + 1], [[f schema] name], nil);
    }
    
    [BJSchemaTestBase string:jSchema isEqualToSchema:schema];
    [BJSchemaTestBase validateDescription:schema];
}

@end
