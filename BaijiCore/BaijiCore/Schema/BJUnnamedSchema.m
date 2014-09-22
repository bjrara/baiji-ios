//
//  BJUnnamedSchema.m
//  BaijiCore
//
//  Created by user on 14-9-18.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJUnnamedSchema.h"

@implementation BJUnnamedSchema

- (NSString *)name {
    return [BJSchema nameForType:[self type]];
}

- (id)jsonObjectWithSchemaNames:(BJSchemaNames *)names encSpace:(NSString *)encSpace {
    NSMutableDictionary *jObj = [self startObject];
    return jObj;
}

@end
