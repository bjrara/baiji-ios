//
//  BJEnum1Values.m
//  BaijiCore
//
//  Created by user on 14-9-25.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJEnum1ValuesSpecific.h"

//TODO need further tests
NSString *const BJEnum1ValuesNames[] = {
    [BLUE] = @"BLUE",
    [RED] = @"RED",
    [GREEN] = @"GREEN"
};

@implementation BJEnum1ValuesSpecific

- (NSString *)name {
    return BJEnum1ValuesNames[self.value];
}

+ (NSUInteger)ordinalForName:(NSString *)name {
    if([BJEnum1ValuesNames[BLUE] isEqual:name])
        return BLUE;
    if([BJEnum1ValuesNames[RED] isEqual:name])
        return RED;
    if([BJEnum1ValuesNames[GREEN] isEqual:name])
        return GREEN;
    return -1;
}

#pragma override NSObject methods

- (BOOL)isEqual:(id)object {
    if (object == nil)
        return NO;
    if (![object isKindOfClass:[BJEnum1ValuesSpecific class]]) {
        return NO;
    }
    BJEnum1ValuesSpecific *that = (BJEnum1ValuesSpecific *)object;
    if(self.value == [that value]) {
        return YES;
    }
    return NO;
}

@end
