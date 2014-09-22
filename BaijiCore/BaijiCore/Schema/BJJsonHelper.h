//
//  BJJsonHelper.h
//  BaijiCore
//
//  Created by user on 14-9-17.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BJPropertyMap;

typedef enum {
    BJJsonTypeArray,
    BJJsonTypeText,
    BJJsonTypeObject,
}BJJsonType;

@interface BJJsonHelper : NSObject

+ (BJPropertyMap *)propertiesFromObject:(id)obj;
+ (NSString *)requiredStringForObject:(NSDictionary *)obj field:(NSString *)field;
+ (NSString *)optionalStringForObject:(NSDictionary *)obj field:(NSString *)field;
+ (void)addToObjectIfNotNullOrEmpty:(NSDictionary *)jsonObj key:(NSString *)key value:(NSString *)value;
+ (void)validate:(NSString *)field;
+ (BJJsonType)typeForObject:(id)jsonObj;

@end