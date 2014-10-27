//
//  BJTypeConverter.h
//  BaijiCore
//
//  Created by zmy周梦伊 on 10/27/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^BJConvert)(id object, Class clazz);

@interface BJTypeConverter : NSObject

+ (instancetype)sharedInstance;

+ (void)registerConverter:(BJConvert)convert from:(NSString *)fromClazz to:(NSString *)toClazz;

+ (void)registerConverter:(BJConvert)convert fromClass:(Class)fromClazz toClass:(Class)toClazz;

@end
