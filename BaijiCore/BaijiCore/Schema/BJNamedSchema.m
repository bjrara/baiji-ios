//
//  BJNamedSchema.m
//  BaijiCore
//
//  Created by user on 14-9-17.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJNamedSchema.h"
#import "BJSchemaName.h"
#import "BJSchemaNames.h"
#import "BJError.h"
#import "BJJsonHelper.h"
#import "BJRecordSchema.h"
#import "BJEnumSchema.h"

@interface BJNamedSchema()

@property (nonatomic, readwrite, retain) BJSchemaName *schemaName;
@property (nonatomic, readwrite, retain) NSString *doc;
@property (nonatomic, readwrite, retain) NSArray *aliases;

@end

@implementation BJNamedSchema

+ (BJNamedSchema *)sharedInstanceForObject:(NSDictionary *)jsonObj
                                properties:(BJPropertyMap *)properties
                                     names:(BJSchemaNames *)names
                                  encSpace:(NSString *)encSpace {
    NSString *type = [BJJsonHelper requiredStringForObject:jsonObj field:@"type"];
    if([@"enum" isEqualToString:type])
        return [BJEnumSchema sharedInstanceForObject:jsonObj properties:properties names:names encSpace:encSpace];
    else if([@"record" isEqualToString:type])
        return [BJRecordSchema sharedInstanceForObject:jsonObj properties:properties names:names encSpace:encSpace];
    else
        return [names schemaWithName:type space:nil encSpace:encSpace];
}

- (id)initWithType:(BJSchemaType)type
        schemaName:(BJSchemaName *)schemaName
               doc:(NSString *)doc
           aliases:(NSArray *)aliases
        properties:(BJPropertyMap *)properties
             names:(BJSchemaNames *)names {
    self = [super initWithType:type properties:properties];
    if(self) {
        self.schemaName = schemaName;
        self.doc = doc;
        self.aliases = aliases;
        if([schemaName name] != nil && [names addWithSchemaName:schemaName namedSchema:self]) {
            [NSException exceptionWithName:BJRuntimeException
                                    reason:[NSString stringWithFormat:@"Duplicated schema name %@", [schemaName string]]
                                  userInfo:nil];
        }
    }
    return self;
}

- (NSString *)name {
    return [self.schemaName name];
}

- (NSString *)ns {
    return [self.schemaName ns];
}

- (NSString *)fullname {
    return [self.schemaName fullName];
}

+ (BJSchemaName *)schemaNameForObject:(NSDictionary *)jsonObj encSpace:(NSString *)encSpace {
    NSString *name = [BJJsonHelper optionalStringForObject:jsonObj field:@"name"];
    NSString *ns = [BJJsonHelper optionalStringForObject:jsonObj field:@"namespace"];
    return [[[BJSchemaName alloc] initWithName:name space:ns encSpace:encSpace] autorelease];
}

+ (NSArray *)aliasesForObject:(NSDictionary *)jsonObj space:(NSString *)space encSpace:(NSString *)encSpace {
    id jAliases = [jsonObj objectForKey:@"aliases"];
    if(jAliases == nil)
        return nil;
    if([BJJsonHelper typeForObject:jAliases] != BJJsonTypeArray)
        [NSException exceptionWithName:BJSchemaParseException reason:@"Aliases must be of format JSON array of strings." userInfo:nil];
    NSMutableArray *aliases = [[NSMutableArray alloc] init];
    for (id alias in jAliases) {
        if([BJJsonHelper typeForObject:alias] != BJJsonTypeText)
            [NSException exceptionWithName:BJSchemaParseException reason:@"Aliases must be of format JSON array of strings." userInfo:nil];
        BJSchemaName *aliasName = [[BJSchemaName alloc] initWithName:alias space:space encSpace:encSpace];
        [aliases addObject:aliasName];
        [aliasName release];
    }
    return [aliases autorelease];
}

- (BOOL)inAliasesForName:(BJSchemaName *)schemaName {
    if(self.aliases == nil)
        return NO;
    for (BJSchemaName *alias in self.aliases) {
        if([schemaName isEqual:alias])
            return YES;
    }
    return NO;
}

// 'fields' property does not own doc or aliases.
- (id)jsonFieldsWithSchemaNames:(BJSchemaNames *)names encSpace:(NSString *)encSpace {
    [NSException exceptionWithName:BJCallException reason:@"jsonFieldsWithSchemaNames:encSpace: is not implemented." userInfo:nil];
    return nil;
}

- (id)jsonObjectWithSchemaNames:(BJSchemaNames *)names encSpace:(NSString *)encSpace {
    [NSException exceptionWithName:BJCallException reason:@"jsonObjectWithSchemaNames:encSpace: is not implemented." userInfo:nil];
    return nil;
}

- (id)jsonObjectWithSchemaNames:(BJSchemaNames *)names encSpace:(NSString *)encSpace fieldsHandler:(BJFieldsHandler)handler {
    NSMutableDictionary *jObj = [super startObject];
    if(![names addwithNamedSchema:self]) {
        // schema is already in the list, write name only.
        BJSchemaName *schemaName = [self schemaName];
        NSString *name;
        if([schemaName space] != encSpace) {
            name = [NSString stringWithFormat:@"%@.%@", [schemaName space], [schemaName name]];
        } else {
            name = [schemaName name];
        }
        [jObj setObject:name forKey:@"name"];
        return jObj;
    } else {
        [self.schemaName addToObject:jObj names:names];
        if(self.doc != nil && [self.doc length] != 0) {
            [jObj setObject:self.doc forKey:@"doc"];
        }
        if(self.aliases) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (BJSchemaName *alias in self.aliases) {
                NSString *fullName = [alias space] != nil ? [NSString stringWithFormat:@"%@.%@", [alias space], [alias name]] : [alias name];
                [array addObject:fullName];
            }
            [jObj setObject:array forKey:@"aliases"];
            [array release];
        }
        handler(jObj);
        return jObj;
    }
    return nil;
}

- (void)dealloc {
    if(self.doc)
        [self.doc release];
    if(self.aliases)
        [self.aliases release];
    [self.schemaName release];
    [super dealloc];
}
@end
