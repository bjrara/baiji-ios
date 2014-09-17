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

@interface BJNamedSchema : BJSchema

@property (nonatomic, readonly) BJSchemaName *schemaName;
@property (nonatomic, readonly) NSString *doc;
@property (nonatomic, readonly) NSArray *aliases;

+ (BJNamedSchema *)sharedInstanceForObject:(NSDictionary *)obj
                                properties:(BJPropertyMap *)properties
                                     names:(BJSchemaNames *)names
                                  encSpace:(NSString *)encSpace;
- (id)initWithType:(BJSchemaType)type
        schemaName:(BJSchemaName *)schemaName
               doc:(NSString *)doc
           aliases:(NSArray *)aliases
        properties:(BJPropertyMap *)properties
             names:(BJSchemaNames *)names;
- (NSString *)name;
- (NSString *)ns;
- (NSString *)fullname;
- (BOOL)inAliasesForName:(BJSchemaName *)schemaName;

@end
