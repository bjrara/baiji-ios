//
//  BJSchemaTestBase.m
//  BaijiCore
//
//  Created by user on 14-9-22.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJSchemaTestBase.h"
#import "BJSchema.h"

@implementation BJSchemaTestBase

+ (BOOL)string:(NSString *)schemaString isEqualToSchema:(BJSchema *)schema {
    if([schema isEqual:schema]) {
        BJSchema *schema2 = [BJSchema parse:schemaString];
        return [schema hash] == [schema2 hash];
    }
    return NO;
}

+ (BOOL)validateDescription:(BJSchema *)schema {
    return [schema isEqual:[BJSchema parse:[schema description]]];
}

@end
