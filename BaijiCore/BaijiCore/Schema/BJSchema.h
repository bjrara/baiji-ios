//
//  BJSchema.h
//  BaijiCore
//
//  Created by user on 14-9-17.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BJPropertyMap;
@class BJSchemaNames;

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
    BJSchemaTypeNull,
    BJSchemaTypeDateTime
} BJSchemaType;

extern NSString *const BJSchemaTypeNames[];

@interface BJSchema : NSObject

@property (nonatomic, readonly) BJSchemaType type;
@property (nonatomic, readonly) BJPropertyMap *properties;

- (id)initWithType:(BJSchemaType)type properties:(BJPropertyMap *)properties;
+ (BJSchema *)parse:(NSString *)jString;
+ (NSString *)nameForType:(BJSchemaType)type;
- (NSString *)propertyForKey:(NSString *)key;
- (NSString *)name;
+ (BJSchema *)parseJson:(id)jsonObj names:(BJSchemaNames *)names encSpace:(NSString *)encSpace;
- (NSMutableDictionary *)startObject;
- (id)jsonObjectWithSchemaNames:(BJSchemaNames *)names encSpace:(NSString *)encSpace;
- (id)jsonFieldsWithSchemaNames:(BJSchemaNames *)names encSpace:(NSString *)encSpace;

@end
