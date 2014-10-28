//
//  BJTypeConverter.m
//  BaijiCore
//
//  Created by zmy周梦伊 on 10/27/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import "BJTypeConverter.h"
#import "BJError.h"

@implementation BJTypeConverter

static NSMutableDictionary *converterCache;

+ (instancetype)sharedInstance {
    static BJTypeConverter *__converter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __converter = [[BJTypeConverter alloc] init];
    });
    return __converter;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        converterCache = [[NSMutableDictionary alloc] init];
        [self registerBaseTypeConverters];
    }
    return self;
}

- (id)convert:(id)object from:(Class)fromClazz to:(Class)toClazz {
    NSString *key = [NSString stringWithFormat:@"%@-%@", NSStringFromClass(fromClazz), NSStringFromClass(toClazz)];
    BJConvert convert = [converterCache objectForKey:key];
    if (convert) {
        return convert(object);
    } else {
        [NSException exceptionWithName:BJRuntimeException reason:[NSString stringWithFormat:@"Cannot find type converter converting %@", key] userInfo:nil];
    }
    return nil;
}

- (void)registerConverter:(BJConvert)convert from:(Class)fromClazz to:(Class)toClazz {
    NSString *key = [NSString stringWithFormat:@"%@-%@", NSStringFromClass(fromClazz), NSStringFromClass(toClazz)];
    [converterCache setObject:convert forKey:key];
}

- (void)registerBaseTypeConverters {
    [self registerConverter:^id(id object) {
        return [object stringValue];
    } from:[NSNumber class] to:[NSString class]];
    [self registerConverter:^id(id object) {
        return [NSNumber numberWithUnsignedLong:strtoul([object UTF8String], NULL, 10)];
    } from:[NSString class] to:[NSNumber class]];
    [self registerConverter:^id(id object) {
        return [NSDecimalNumber decimalNumberWithString:object];
    } from:[NSString class] to:[NSDecimalNumber class]];
    [self registerConverter:^id(id object) {
        return [object stringValue];
    } from:[NSDecimalNumber class] to:[NSString class]];
}

@end
