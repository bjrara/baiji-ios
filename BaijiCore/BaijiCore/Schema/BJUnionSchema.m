//
//  BJUnionSchema.m
//  BaijiCore
//
//  Created by user on 14-9-19.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJUnionSchema.h"
#import "BJError.h"
#import "BJPropertyMap.h"
#import "BJSchema.h"
#import "BJSchemaName.h"

@interface BJUnionSchema()

@property (nonatomic, readwrite, retain) NSArray *schemas;

@end

@implementation BJUnionSchema

+ (BJUnionSchema *)sharedInstanceForSchemas:(NSArray *)jsonObj
                                 properties:(BJPropertyMap *)properties
                                      names:(BJSchemaNames *)names
                                   encSpace:(NSString *)encSpace {
    NSMutableArray *schemas = [[NSMutableArray alloc] init];
    NSMutableDictionary *uniqueSchemas = [[NSMutableDictionary alloc] init];
    for (id entry in jsonObj) {
        BJSchema *unionType = [BJSchema parseJson:entry names:names encSpace:encSpace];
        if(unionType == nil)
            [NSException exceptionWithName:BJSchemaParseException
                                    reason:[NSString stringWithFormat:@"Invalid JSON in union: %@", jsonObj]
                                  userInfo:nil];
        NSString *name = [unionType name];
        if([uniqueSchemas objectForKey:name] != nil)
            [NSException exceptionWithName:BJSchemaParseException
                                    reason:[NSString stringWithFormat:@"Duplicate type in union: %@", name]
                                  userInfo:nil];
        [uniqueSchemas setObject:name forKey:name];
        [schemas addObject:unionType];
    }
    [uniqueSchemas release];
    return [[BJUnionSchema alloc] initWithSchemas:[schemas autorelease] properties:properties];
}

- (id)initWithSchemas:(NSArray *)schemas properties:(BJPropertyMap *)properties {
    self = [super initWithType:BJSchemaTypeUnion properties:properties];
    if(self) {
        if(schemas == nil)
            [NSException exceptionWithName:BJArgumentException reason:@"union schemas cannot be empty." userInfo:nil];
        self.schemas = schemas;
    }
    return self;
}

- (NSUInteger)count {
    return [self.schemas count];
}

- (BJSchema *)schemaAtIndex:(NSUInteger)index {
    return [self.schemas objectAtIndex:index];
}

- (NSArray *)jsonObjectWithSchemaNames:(BJSchemaNames *)names encSpace:(NSString *)encSpace {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (BJSchema *schema in self.schemas) {
        [array addObject:[schema jsonObjectWithSchemaNames:names encSpace:encSpace]];
    }
    return array;
}

#pragma override NSObject methods

- (BOOL)isEqual:(id)object {
    if(object == self)
        return YES;
    if(![object isKindOfClass:[BJUnionSchema class]])
        return NO;
    BJUnionSchema *that = (BJUnionSchema *)object;
    return [self.properties isEqualToDictionary:[that properties]];
}

- (NSUInteger)hash {
    int result = 53;
    for (BJSchema *schema in self.schemas)
        result += 89 * [schema hash];
    result += [self.properties hash];
    return result;
}

- (void)dealloc {
    [self.schemas release];
    [super dealloc];
}

@end
