//
//  BJMapSchema.h
//  BaijiCore
//
//  Created by user on 14-9-22.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJUnnamedSchema.h"

@class BJSchema;

@interface BJMapSchema : BJUnnamedSchema

@property (nonatomic, readonly) BJSchema *valueSchema;

- (id)initWithValueSchema:(BJSchema *)valueSchema properties:(BJPropertyMap *)properties;
+ (BJMapSchema *)sharedInstanceForObject:(NSDictionary *)jsonObj
                              properties:(BJPropertyMap *)properties
                                   names:(BJSchemaNames *)names
                                encSpace:(NSString *)encSpace;
@end
