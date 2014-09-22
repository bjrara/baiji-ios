//
//  BJField.h
//  BaijiCore
//
//  Created by user on 14-9-18.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BJSchema;
@class BJPropertyMap;
@class BJSchemaNames;

typedef enum {
    BJSortOrderAscending,
    BJSortOrderDescending,
    BJSortOrderIgnore
}BJSortOrder;

extern NSString *const BJSortOrderNames[];

@interface BJField : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSArray *aliases;
@property (nonatomic, readonly) int pos;
@property (nonatomic, readonly) NSString *doc;
@property (nonatomic, readonly) id defaultValue;
@property (nonatomic, readonly) BJSortOrder ordering;
@property (nonatomic, readonly) BJSchema *schema;
@property (nonatomic, readonly) BJPropertyMap *properties;

- (id)initWithSchema:(BJSchema *)schema
                name:(NSString *)name
             aliases:(NSArray *)aliases
                 pos:(int)pos
                 doc:(NSString *)doc
             defaultValue:(id)defaultValue
            ordering:(BJSortOrder)sortOrder
          properties:(BJPropertyMap *)properties;
+ (BJSortOrder)sortOrderForValue:(NSString *)value;
+ (NSArray *)aliasesForObject:(id)obj;
- (id)jsonObjectWithNames:(BJSchemaNames *)names encSpace:(NSString *)encSpace;

@end
