//
//  BJNamedSchema.h
//  BaijiCore
//
//  Created by user on 14-9-17.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJSchema.h"

@class BJSchemaName;
@class BJPropertyMap;
@class BJSchemaNames;

typedef void (^BJFieldsHandler)(NSMutableDictionary *jObj);

@interface BJNamedSchema : BJSchema

@property (nonatomic, readonly, retain) BJSchemaName *schemaName;
@property (nonatomic, readonly, retain) NSString *doc;
@property (nonatomic, readonly, retain) NSArray *aliases;

+ (BJNamedSchema *)sharedInstanceForObject:(NSDictionary *)jsonObj
                                properties:(BJPropertyMap *)properties
                                     names:(BJSchemaNames *)names
                                  encSpace:(NSString *)encSpace;
- (id)initWithType:(BJSchemaType)type
        schemaName:(BJSchemaName *)schemaName
               doc:(NSString *)doc
           aliases:(NSArray *)aliases
        properties:(BJPropertyMap *)properties
             names:(BJSchemaNames *)names;
- (id)jsonObjectWithSchemaNames:(BJSchemaNames *)names encSpace:(NSString *)encSpace fieldsHandler:(BJFieldsHandler)handler;
- (NSString *)name;
- (NSString *)ns;
- (NSString *)fullname;
+ (BJSchemaName *)schemaNameForObject:(NSDictionary *)jsonObj encSpace:(NSString *)encSpace;
+ (NSArray *)aliasesForObject:(NSDictionary *)jsonObj space:(NSString *)space encSpace:(NSString *)encSpace;
- (BOOL)inAliasesForName:(BJSchemaName *)schemaName;

@end
