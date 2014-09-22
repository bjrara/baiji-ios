//
//  BJUnionSchema.h
//  BaijiCore
//
//  Created by user on 14-9-19.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJUnnamedSchema.h"

@class BJPropertyMap;
@class BJSchema;
@class BJSchemaName;

@interface BJUnionSchema : BJUnnamedSchema

@property (nonatomic, readonly) NSArray *schemas;

+ (BJUnionSchema *)sharedInstanceForSchemas:(NSArray *)jsonObj
                                 properties:(BJPropertyMap *)properties
                                      names:(BJSchemaNames *)names
                                   encSpace:(NSString *)encSpace;
- (id)initWithSchemas:(NSArray *)schemas properties:(BJPropertyMap *)properties;
- (int)count;
- (BJSchema *)schemaAtIndex:(NSUInteger)index;

@end