//
//  BJSchemaTestBase.h
//  BaijiCore
//
//  Created by user on 14-9-22.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHTestCase.h"

@class BJSchema;

@interface BJSchemaTestBase : GHTestCase

+ (BOOL)string:(NSString *)schemaString isEqualToSchema:(BJSchema *)schema;
+ (BOOL)validateDescription:(BJSchema *)schema;

@end
