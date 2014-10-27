//
//  BJBaseTypeConverter.m
//  BaijiCore
//
//  Created by zmy周梦伊 on 10/27/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import "BJBaseTypeConverter.h"
#import "BJTypeConverter.h"

@implementation BJBaseTypeConverter

+ (void)registerConverters {
    [BJTypeConverter registerConverter:^id(id object, Class clazz) {
        return [NSNumber numberWithInt:(int)object];
    } from:@"int8_t" to:@"int"];
    [BJTypeConverter registerConverter:^id(id object, Class clazz) {
        return [object charValue];
    } from:@"int" to:@"int8_t"];
    [BJTypeConverter registerConverter:^id(id object, Class clazz) {
        return [NSNumber numberWithInt:(int)object];
    } from:@"uint8_t" to:@"int"];
    [BJTypeConverter registerConverter:^id(id object, Class clazz) {
        return [object unsignedCharValue];
    } from:@"int" to:@"uint8_t"];
    [BJTypeConverter registerConverter:^id(id object, Class clazz) {
        return [[NSNumber numberWithUnsignedLong:object] stringValue];
    } from:@"unsignedLong" to:@"NSString"];
    [BJTypeConverter registerConverter:^id(id object, Class clazz) {
        return [NSNumber numberWithUnsignedLong:[object unsignedLongValue]];
    } from:@"NSString" to:@"unsignedLong"];
    [BJTypeConverter registerConverter:^id(id object, Class clazz) {
        return [object stringValue];
    } fromClass:[NSString class] toClass:[NSDecimalNumber class]];
    [BJTypeConverter registerConverter:^id(id object, Class clazz) {
        return [NSDecimalNumber decimalNumberWithString:object];
    } fromClass:[NSDecimalNumber class] toClass:[NSString class]];
}

@end