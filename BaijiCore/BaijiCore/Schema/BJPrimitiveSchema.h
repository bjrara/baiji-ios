//
//  BJPrimitiveSchema.h
//  BaijiCore
//
//  Created by user on 14-9-18.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJUnnamedSchema.h"

@interface BJPrimitiveSchema : BJUnnamedSchema

+ (id)sharedInstanceForType:(NSString *)type;
+ (id)sharedInstanceForType:(NSString *)type properties:(BJPropertyMap *)properties;

@end
