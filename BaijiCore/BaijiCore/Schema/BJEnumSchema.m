//
//  BJEnumSchema.m
//  BaijiCore
//
//  Created by user on 14-9-17.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJEnumSchema.h"
#import "BJSchemaName.h"
#import "BJSchemaNames.h"
#import "BJPropertyMap.h"
#import "BJJsonHelper.h"
#import "BJError.h"

@interface BJEnumSchema()

@property (nonatomic, readonly) NSDictionary *symbolMap;

@end

@implementation BJEnumSchema

+ (BJEnumSchema *)sharedInstanceForObject:(NSDictionary *)jsonObj
                               properties:(BJPropertyMap *)properties
                                    names:(BJSchemaNames *)names
                                 encSpace:(NSString *)encSpace {
    BJSchemaName *name = [BJNamedSchema schemaNameForObject:jsonObj encSpace:encSpace];
    NSArray *alias = [BJNamedSchema aliasesForObject:jsonObj space:[name space] encSpace:[name encSpace]];
    NSString *doc = [BJJsonHelper optionalStringForObject:jsonObj field:@"doc"];
    
    id jSymbols = [jsonObj objectForKey:@"symbols"];
    if(jSymbols == nil)
        [NSException exceptionWithName:BJSchemaParseException reason:@"Enum has no symbols." userInfo:nil];
    if(![jSymbols isKindOfClass:[NSArray class]])
        [NSException exceptionWithName:BJSchemaParseException reason:@"Symbols field in enum must be an array." userInfo:nil];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSMutableDictionary *map = [[NSMutableDictionary alloc] init];
    __block int lastValue = -1;
    for (id jSymbol in jSymbols) {
        NSNumber *explicitValue = nil;
        NSNumber *actualValue;
        NSString *symbol;
        switch ([BJJsonHelper typeForObject:jSymbol]) {
            case BJJsonTypeText: {
                symbol = jSymbol;
                actualValue = [NSNumber numberWithInt:++lastValue];
                break;
            }
            case BJJsonTypeObject: {
                id symbolName = [jSymbol objectForKey:@"name"];
                if(symbol == nil)
                    [NSException exceptionWithName:BJSchemaParseException
                                            reason:[NSString stringWithFormat:@"Missing symbol name: %@", jSymbol]
                                          userInfo:nil];
                if([BJJsonHelper typeForObject:symbolName] != BJJsonTypeText)
                    [NSException exceptionWithName:BJSchemaParseException
                                            reason:[NSString stringWithFormat:@"Symbol name must be a string: %@", jSymbol]
                                          userInfo:nil];
                symbol = symbolName;
                id symbolValue = [jSymbol objectForKey:@"value"];
                if(symbolValue != nil)
                    explicitValue = [NSNumber numberWithInt:[symbolValue intValue]];
                actualValue = explicitValue != nil ? explicitValue : [NSNumber numberWithInt:lastValue + 1];
                lastValue = [actualValue intValue];
                break;
            }
            default:{
                [NSException exceptionWithName:BJSchemaParseException
                                        reason:[NSString stringWithFormat:@"Invalid symbol object: %@", jSymbol]
                                      userInfo:nil];
                break;
            }
        }
        explicitValue = explicitValue != nil ? explicitValue : [NSNumber numberWithInt:-1];
        NSArray *values = [NSArray arrayWithObjects:explicitValue, actualValue, nil];
        [map setObject:values forKey:symbol];
        [array addObject:symbol];
    }
    return [[BJEnumSchema alloc] initWithSchemaName:name
                                                doc:doc
                                            aliases:alias
                                            symbols:array
                                          symbolMap:map
                                         properties:properties
                                              names:names];
}

- (id)initWithSchemaName:(BJSchemaName *)schemaName
                     doc:(NSString *)doc
                 aliases:(NSArray *)aliases
                 symbols:(NSDictionary *)symbols
              properties:(BJPropertyMap *)properties {
    self = [super initWithType:BJSchemaTypeEnum
                    schemaName:schemaName
                           doc:doc
                       aliases:aliases
                    properties:properties
                         names:[[[BJSchemaNames alloc] init] autorelease]];
    if(self) {
        if([schemaName name] == nil)
            [NSException exceptionWithName:BJSchemaParseException reason:@"name cannot be null for enum schema." userInfo:nil];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSMutableDictionary *map = [[NSMutableDictionary alloc] init];
        __block int lastValue = -1;
        [symbols enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSArray *values;
            if(obj) {
                lastValue = [obj intValue];
                values = [[NSArray alloc] initWithObjects:obj, obj, nil];
                [array addObject:key];
                [map setObject:values forKey:key];
                [values release];
            } else {
                values = [[NSArray alloc] initWithObjects:nil, ++lastValue, nil];
                [array addObject:key];
                [map setObject:values forKey:key];
                [values release];
            }
        }];
        _symbols = [NSArray arrayWithArray:array];
        _symbolMap = [NSDictionary dictionaryWithDictionary:map];
        [array release];
        [map release];
    }
    return self;
}

- (id)initWithSchemaName:(BJSchemaName *)schemaName
                     doc:(NSString *)doc
                 aliases:(NSArray *)aliases
                 symbols:(NSArray *)symbols
               symbolMap:(NSDictionary *)symbolMap
              properties:(BJPropertyMap *)properties
                   names:(BJSchemaNames *)names {
    self = [super initWithType:BJSchemaTypeEnum
                    schemaName:schemaName
                           doc:doc
                       aliases:aliases
                    properties:properties
                         names:names];
    if(self) {
        if([schemaName name] == nil)
            [NSException exceptionWithName:BJSchemaParseException reason:@"name cannot be null for enum schema." userInfo:nil];
        _symbols = symbols;
        _symbolMap = symbolMap;
    }
    return self;
}

- (NSUInteger)size {
    return [self.symbols count];
}

- (int)oridinalForSymbol:(NSString *)symbol {
    NSArray *values = [self.symbolMap objectForKey:symbol];
    if(values)
        return [[values objectAtIndex:1] intValue];
    [NSException exceptionWithName:BJRuntimeException
                            reason:[NSString stringWithFormat:@"No such symbol: %@", symbol]
                          userInfo:nil];
    return -1;
}

- (NSString *)symbolForValue:(int)value {
    __block NSString *symbol;
    [self.symbolMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSArray *values = obj;
        if([[values objectAtIndex:1] intValue] == value) {
            symbol = key;
            *stop = YES;
        }
    }];
    return symbol;
}

- (BOOL)containsSymbol:(NSString *)symbol {
    return [self.symbolMap objectForKey:symbol] != nil;
}

- (NSDictionary *)jsonObjectWithSchemaNames:(BJSchemaNames *)names encSpace:(NSString *)encSpace {
    return [super jsonObjectWithSchemaNames:names encSpace:encSpace fieldsHandler:^(NSMutableDictionary *jObj) {
        [jObj setObject:[self jsonFieldsWithSchemaNames:names encSpace:encSpace] forKey:@"symbols"];
    }];
}

- (NSArray *)jsonFieldsWithSchemaNames:(BJSchemaNames *)names encSpace:(NSString *)encSpace {
    NSMutableArray *jArray = [[NSMutableArray alloc] init];
    for (NSString *symbol in self.symbols) {
        NSArray *values = [self.symbolMap objectForKey:symbol];
        id item;
        if ([[values objectAtIndex:0] intValue] > -1) {
            item = [[NSMutableDictionary alloc] initWithCapacity:2];
            [item setObject:symbol forKey:@"name"];
            [item setObject:[values objectAtIndex:1] forKey:@"value"];
        } else {
            item = symbol;
        }
        [jArray addObject:item];
    }
    return jArray;
}

#pragma override NSObject methods

- (BOOL)isEqual:(id)object {
    if(object == self)
        return YES;
    if(![object isKindOfClass:[BJEnumSchema class]])
        return NO;
    BJEnumSchema *that = (BJEnumSchema *)object;
    if([[self schemaName] isEqual:[that schemaName]]
       && [self.symbols count] == [that.symbols count]) {
        for (int i = 0; i < [self.symbols count]; ++i) {
            if(![[self.symbols objectAtIndex:i] isEqual:[that.symbols objectAtIndex:i]]) {
                return NO;
            }
        }
        return [self.symbolMap isEqualToDictionary:that.symbolMap];
    }
    return NO;
}

- (NSUInteger)hash {
    int value = [[self schemaName] hash] + [[self properties] hash];
    for (NSString *symbol in self.symbols) {
        value += 23 * [symbol hash];
    }
    return value;
}

@end
