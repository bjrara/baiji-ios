//
//  BJArraySchema.h
//  BaijiCore
//
//  Created by user on 14-9-19.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJUnnamedSchema.h"

@class BJSchema;
@class BJPropertyMap;

@interface BJArraySchema :BJUnnamedSchema

@property (nonatomic, readonly) BJSchema *itemSchema;

- (id)initWithItemSchema:(BJSchema *)itemSchema properties:(BJPropertyMap *)properties;
+ (BJArraySchema *)sharedInstanceForObject:(NSDictionary *)jsonObj
                                properties:(BJPropertyMap *)properties
                                     names:(BJSchemaNames *)names
                                  encSpace:(NSString *)encSpace;
@end
