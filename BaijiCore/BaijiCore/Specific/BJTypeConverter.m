//
//  BJTypeConverter.m
//  BaijiCore
//
//  Created by zmy周梦伊 on 10/27/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import "BJTypeConverter.h"
#import "BJBaseTypeConverter.h"
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
        [BJBaseTypeConverter registerConverters];
    }
    return self;
}

+ (id)convert:(id)object to:(Class)clazz {
    NSString *key = [NSString stringWithFormat:@"%@-%@", NSStringFromClass([object class]), NSStringFromClass(clazz)];
    BJConvert convert = [converterCache objectForKey:key];
    if (convert) {
        return convert(object, clazz);
    } else {
        [NSException exceptionWithName:BJRuntimeException reason:[NSString stringWithFormat:@"Cannot find type converter converting %@ to %@", NSStringFromClass([object class]), NSStringFromClass(clazz)] userInfo:nil];
    }
    return  nil;
}

+ (void)registerConverter:(BJConvert)convert from:(NSString *)fromClazz to:(NSString *)toClazz {
    NSString *key = [NSString stringWithFormat:@"%@-%@", fromClazz, toClazz];
    [converterCache setObject:convert forKey:key];
}
+ (void)registerConverter:(BJConvert)convert fromClass:(Class)fromClazz toClass:(Class)toClazz {
    NSString *key = [NSString stringWithFormat:@"%@-%@", NSStringFromClass(fromClazz), NSStringFromClass(toClazz)];
    [converterCache setObject:convert forKey:key];
}

@end
