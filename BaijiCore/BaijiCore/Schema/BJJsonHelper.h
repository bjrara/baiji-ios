//
//  BJJsonHelper.h
//  BaijiCore
//
//  Created by user on 14-9-17.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BJPropertyMap;

@interface BJJsonHelper : NSObject

+ (BJPropertyMap *)propertiesForObject:(NSDictionary *)obj;
+ (NSString *)requiredStringForObject:(NSDictionary *)obj field:(NSString *)field;
+ (NSString *)optionalStringForObject:(NSDictionary *)obj field:(NSString *)field;
+ (void) addToJsonObject:(NSDictionary *)jsonObj withKey:(NSString *)key value:(NSString *)value;
+ (void) validate:(NSString *)field;

@end
