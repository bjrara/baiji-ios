//
//  BJSchema.h
//  BaijiCore
//
//  Created by user on 14-9-17.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

@class BJPropertyMap;

#import <Foundation/Foundation.h>

typedef enum{
    BJSchemaTypeRecord,
    BJSchemaTypeEnum,
    BJSchemaTypeArray,
    BJSchemaTypeMap,
    BJSchemaTypeUnion,
    BJSchemaTypeString,
    BJSchemaTypeBytes,
    BJSchemaTypeInt,
    BJSchemaTypeLong,
    BJSchemaTypeFloat,
    BJSchemaTypeDouble,
    BJSchemaTypeBoolean,
    BJSchemaTypeNull
} BJSchemaType;

extern NSString *const BJSchemaTypeNames[];

@interface BJSchema : NSObject

@property (nonatomic, readonly) BJSchemaType type;
@property (nonatomic, readonly) BJPropertyMap *properties;

- (id)initWithType:(BJSchemaType)type properties:(BJPropertyMap *)properties;
+ (BJSchema *)parse:(NSString *)json;
- (NSString *)propertyForKey:(NSString *)key;

@end
