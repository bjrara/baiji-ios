//
//  BJField.m
//  BaijiCore
//
//  Created by user on 14-9-18.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJField.h"
#import "BJError.h"
#import "BJJsonHelper.h"
#import "BJSchema.h"
#import "BJPropertyMap.h"

@interface BJField()

@property (nonatomic, readwrite, retain) NSString *name;
@property (nonatomic, readwrite, retain) NSArray *aliases;
@property (nonatomic, readwrite) int pos;
@property (nonatomic, readwrite, retain) NSString *doc;
@property (nonatomic, readwrite, retain) id defaultValue;
@property (nonatomic, readwrite) BJSortOrder ordering;
@property (nonatomic, readwrite, retain) BJSchema *schema;
@property (nonatomic, readwrite, retain) BJPropertyMap *properties;

@end

@implementation BJField

NSString *const BJSortOrderNames[] = {
    [BJSortOrderAscending] = @"ASCENDING",
    [BJSortOrderDescending] = @"DESCENDING",
    [BJSortOrderIgnore] = @"IGNORE"
};

- (id)initWithSchema:(BJSchema *)schema
                name:(NSString *)name
             aliases:(NSArray *)aliases
                 pos:(int)pos
                 doc:(NSString *)doc
             defaultValue:(id)defaultValue
            ordering:(BJSortOrder)ordering
          properties:(BJPropertyMap *)properties {
    self = [super init];
    if(self) {
        if(name == nil || [name length] == 0) {
            [NSException exceptionWithName:BJArgumentException reason:@"name cannot be null." userInfo:nil];
        }
        if(schema == nil) {
            [NSException exceptionWithName:BJArgumentException reason:@"schema cannot be null." userInfo:nil];
        }
        self.schema = schema;
        self.name = name;
        self.aliases = aliases;
        self.pos = pos;
        self.doc = doc;
        self.defaultValue = defaultValue;
        self.ordering = ordering;
        self.properties = properties;
    }
    return self;
}

+ (BJSortOrder)sortOrderForValue:(NSString *)value {
    if([value isEqualToString:BJSortOrderNames[BJSortOrderAscending]])
        return BJSortOrderAscending;
    if([value isEqualToString:BJSortOrderNames[BJSortOrderDescending]])
        return BJSortOrderDescending;
    if([value isEqualToString:BJSortOrderNames[BJSortOrderIgnore]])
        return BJSortOrderIgnore;
    return -1;
}

+ (NSArray *)aliasesForObject:(id)obj {
    id jAliases = [obj objectForKey:@"aliases"];
    if(jAliases == nil)
        return nil;
    if([BJJsonHelper typeForObject:jAliases] != BJJsonTypeArray)
        [NSException exceptionWithName:BJSchemaParseException reason:@"Aliases must be of format JSON array of strings." userInfo:nil];
    NSMutableArray *aliases = [[NSMutableArray alloc] init];
    for(id alias in aliases) {
        if([BJJsonHelper typeForObject:alias] != BJJsonTypeText)
            [NSException exceptionWithName:BJSchemaParseException reason:@"Aliases must be of format JSON array of strings." userInfo:nil];
        [aliases addObject:alias];
    }
    return aliases;
}

- (id)jsonObjectWithNames:(BJSchemaNames *)names encSpace:(NSString *)encSpace {
    NSMutableDictionary *jObj = [[NSMutableDictionary alloc] init];
    [BJJsonHelper addToObjectIfNotNullOrEmpty:jObj key:@"name" value:self.name];
    [BJJsonHelper addToObjectIfNotNullOrEmpty:jObj key:@"doc" value:self.doc];
    
    if(self.defaultValue != nil)
        [jObj setObject:self.defaultValue forKey:@"default"];
    if(self.schema != nil) {
        [jObj setObject:[self.schema jsonObjectWithSchemaNames:names encSpace:encSpace] forKey:@"type"];
    }
    if(self.properties != nil)
        [self.properties addToObject:jObj];
    if(self.aliases != nil) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (NSString *alias in self.aliases) {
            [array addObject:alias];
        }
        [jObj setObject:array forKey:@"aliases"];
    }
    return jObj;
}

- (void)dealloc {
    if(self.aliases)
        [self.aliases release];
    if(self.doc)
        [self.doc release];
    if(self.defaultValue)
        [self.defaultValue release];
    if(self.properties)
        [self.properties release];
    [self.name release];
    [self.schema release];
    [super dealloc];
}

@end
