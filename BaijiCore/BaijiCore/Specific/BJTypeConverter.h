//
//  BJTypeConverter.h
//  BaijiCore
//
//  Created by zmy周梦伊 on 10/27/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^BJConvert)(id object);

@interface BJTypeConverter : NSObject

+ (instancetype)sharedInstance;

- (id)convert:(id)object from:(Class)fromClazz to:(Class)toClazz;

- (void)registerConverter:(BJConvert)convert from:(Class)fromClazz to:(Class)toClazz;

@end
