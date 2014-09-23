//
//  BJRecordSchema.m
//  BaijiCore
//
//  Created by user on 14-9-18.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJRecordSchema.h"
#import "BJSchemaName.h"
#import "BJSchemaNames.h"
#import "BJError.h"
#import "JSONKit.h"
#import "BJField.h"
#import "BJJsonHelper.h"

@interface BJRecordSchema()

@property (nonatomic, readonly) BOOL request;
@property (nonatomic, readonly) NSMutableDictionary *fieldLookup;
@property (nonatomic, readonly) NSMutableDictionary *fieldAliasLookup;

@end

@implementation BJRecordSchema

- (id)initWithName:(BJSchemaName *)name
               doc:(NSString *)doc
           aliases:(NSArray *)aliases
        properties:(BJPropertyMap *)properties
            fields:(NSArray *)fields
           request:(BOOL)request {
    self = [super initWithType:BJSchemaTypeRecord
                    schemaName:name
                           doc:doc
                       aliases:aliases
                    properties:properties
                         names:[[[BJSchemaNames alloc] init] autorelease]];
    if(self) {
        if(!request && [name name] == nil)
            [NSException exceptionWithName:BJSchemaParseException reason:@"name cannot be null for record schema." userInfo:nil];
        _fields = fields;
        _request = request;
        
        NSMutableDictionary *fieldMap = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *fieldAliasMap = [[NSMutableDictionary alloc] init];
        for (BJField *field in fields) {
            [BJRecordSchema addToFieldMap:fieldMap WithName:[field name] field:field];
            [BJRecordSchema addToFieldMap:fieldAliasMap WithName:[field name] field:field];
            if([field aliases] != nil) {
                for(NSString *alias in [field aliases]) {
                    [BJRecordSchema addToFieldMap:fieldAliasMap WithName:alias field:field];
                }
            }
        }
        _fieldLookup = fieldMap;
        _fieldAliasLookup = fieldAliasMap;
        [fieldMap release];
        [fieldAliasMap release];
    }
    return self;
}

- (id)initWithName:(BJSchemaName *)name
               doc:(NSString *)doc
           aliases:(NSArray *)aliases
        properties:(BJPropertyMap *)properties
            fields:(NSArray *)fields
           request:(BOOL)request
          fieldMap:(NSMutableDictionary *)fieldMap
     fieldAliasMap:(NSMutableDictionary *)fieldAliasMap
             names:(BJSchemaNames *)names {
    self = [super initWithType:BJSchemaTypeRecord
                    schemaName:name
                           doc:doc
                       aliases:aliases
                    properties:properties
                         names:names];
    if(self) {
        if(!request && [name name] == nil)
            [NSException exceptionWithName:BJSchemaParseException reason:@"name cannot be null for record schema." userInfo:nil];
        _fields = fields;
        _request = request;
        _fieldLookup = fieldMap;
        _fieldAliasLookup = fieldAliasMap;
    }
    return self;
}

+ (BJRecordSchema *)sharedInstanceForObject:(NSDictionary *)jsonObj
                                 properties:(BJPropertyMap *)properties
                                      names:(BJSchemaNames *)names
                                   encSpace:(NSString *)encSpace {
    BOOL request = NO;
    id jFields = [jsonObj objectForKey:@"fields"];
    if(jFields == nil) {
        //anonymous record from messages
        jFields = [jsonObj objectForKey:@"request"];
        if(jFields)
            request = YES;
    }
    if(jFields == nil) {
        [NSException exceptionWithName:BJSchemaParseException reason:@"'fields' cannot be null for record" userInfo:nil];
    }
    if([BJJsonHelper typeForObject:jFields] != BJJsonTypeArray){
        [NSException exceptionWithName:BJSchemaParseException reason:@"'fields' is not an array for record" userInfo:nil];
    }
    BJSchemaName *name = [BJNamedSchema schemaNameForObject:jsonObj encSpace:encSpace];
    NSArray *aliases = [BJNamedSchema aliasesForObject:jsonObj space:[name space] encSpace:[name encSpace]];
    NSString *doc = [BJJsonHelper optionalStringForObject:jsonObj field:@"doc"];
    
    NSMutableArray *fields = [[NSMutableArray alloc] init];
    NSMutableDictionary *fieldMap = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *fieldAliasMap = [[NSMutableDictionary alloc] init];
    BJRecordSchema *result = [[BJRecordSchema alloc] initWithName:name
                                                              doc:doc
                                                          aliases:aliases
                                                       properties:properties
                                                           fields:fields
                                                          request:request
                                                         fieldMap:fieldMap
                                                    fieldAliasMap:fieldAliasMap
                                                            names:names];
    int fieldPos = 0;
    for (id jField in jFields) {
        NSString *fieldName = [BJJsonHelper requiredStringForObject:jField field:@"name"];
        BJField *field = [BJRecordSchema createFieldFromObject:jField pos:fieldPos++ names:names encSpace:[name space]];
        [fields addObject:field];
        [BJRecordSchema addToFieldMap:fieldMap WithName:fieldName field:field];
        [BJRecordSchema addToFieldMap:fieldAliasMap WithName:fieldName field:field];
        
        if([field aliases] != nil) {
            for(NSString *alias in [field aliases]) {
                [BJRecordSchema addToFieldMap:fieldAliasMap WithName:alias field:field];
            }
        }
    }
    return result;
}

+ (void)addToFieldMap:(NSMutableDictionary *)map WithName:(NSString *)name field:(BJField *)field {
    if([map objectForKey:name])
        [NSException exceptionWithName:BJSchemaParseException
                                reason:[NSString stringWithFormat:@"field or alias %@ is a duplicate name.", name]
                              userInfo:nil];
    [map setObject:field forKey:name];
}

+ (BJField *)createFieldFromObject:(id)jsonObj pos:(int)pos names:(BJSchemaNames *)names encSpace:(NSString *)encSpace {
    NSString *name = [BJJsonHelper requiredStringForObject:jsonObj field:@"name"];
    NSString *doc = [BJJsonHelper optionalStringForObject:jsonObj field:@"doc"];
    NSString *order = [BJJsonHelper optionalStringForObject:jsonObj field:@"order"];
    BJSortOrder sortOrder = BJSortOrderIgnore;
    if(order)
        sortOrder = [BJField sortOrderForValue:[order uppercaseString]];
    NSArray *aliases = [BJField aliasesForObject:jsonObj];
    BJPropertyMap *properties = [BJJsonHelper propertiesFromObject:jsonObj];
    id jDefaultValue = [jsonObj objectForKey:@"default"];
    id jType = [jsonObj objectForKey:@"type"];
    if(jType == nil)
        [NSException exceptionWithName:BJSchemaParseException
                                reason:[NSString stringWithFormat:@"'type' was not found for field: %@", name]
                              userInfo:nil];
    BJSchema *schema = [BJSchema parseJson:jType names:names encSpace:encSpace];
    return [[[BJField alloc] initWithSchema:schema
                                      name:name
                                   aliases:aliases
                                       pos:pos
                                       doc:doc
                              defaultValue:jDefaultValue
                                  ordering:sortOrder
                                properties:properties] autorelease];
}

- (NSUInteger)count {
    return [self.fields count];
}

- (BJField *)fieldForName:(NSString *)name {
    if(name == nil || [name length] == 0) {
        [NSException exceptionWithName:BJArgumentException reason:@"name cannot be null." userInfo:nil];
    }
    return [self.fieldLookup objectForKey:name];
}

- (NSDictionary *)jsonObjectWithSchemaNames:(BJSchemaNames *)names encSpace:(NSString *)encSpace {
    return [super jsonObjectWithSchemaNames:names encSpace:encSpace fieldsHandler:^(NSMutableDictionary *jObj) {
        NSArray *jFields = [self jsonFieldsWithSchemaNames:names encSpace:encSpace];
        if(jFields) {
            [jObj setObject:jFields forKey:@"fields"];
        }
    }];
}

- (NSArray *)jsonFieldsWithSchemaNames:(BJSchemaNames *)names encSpace:(NSString *)encSpace {
    if(self.fields != nil && [self.fields count] > 0) {
        NSMutableArray *jFields = [[[NSMutableArray alloc] init] autorelease];
        for (BJField *field in self.fields) {
            [jFields addObject:[field jsonObjectWithNames:names encSpace:[self ns]]];
        }
        return jFields;
    }
    return nil;
}

- (void)dealloc {
    [_fieldLookup release];
    [_fieldAliasLookup release];
    [super dealloc];
}

@end
