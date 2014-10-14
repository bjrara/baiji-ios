//
//  BJEnum.m
//  BaijiCore
//
//  Created by user on 14-9-25.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJSpecificEnum.h"

@implementation BJSpecificEnum

- (id)initWithValue:(NSUInteger)value {
    self = [super init];
    if(self) {
        self.value = value;
    }
    return self;
}

- (NSString *)name {
    return nil;
}

+ (NSUInteger)ordinalForName:(NSString *)name {
    return -1;
}

@end
