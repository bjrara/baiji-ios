//
//  BJSchema.m
//  BaijiCore
//
//  Created by user on 14-9-17.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJSchema.h"
#import "BJError.h"
#import "BJSchemaNames.h"
#import "BJNamedSchema.h"
#import "BJPrimitiveSchema.h"
#import "JSONKit.h"
#import "BJJsonHelper.h"
#import "BJPropertyMap.h"
#import "BJArraySchema.h"
#import "BJUnionSchema.h"
#import "BJMapSchema.h"

@implementation BJSchema

NSString *const BJSchemaTypeNames[] = {
    [BJSchemaTypeRecord] = @"record",
    [BJSchemaTypeEnum] = @"enum",
    [BJSchemaTypeArray] = @"array",
    [BJSchemaTypeMap] = @"map",
    [BJSchemaTypeUnion] = @"union",
    [BJSchemaTypeString] = @"string",
    [BJSchemaTypeBytes] = @"bytes",
    [BJSchemaTypeInt] = @"int",
    [BJSchemaTypeLong] = @"long",
    [BJSchemaTypeFloat] = @"float",
    [BJSchemaTypeDouble] = @"double",
    [BJSchemaTypeBoolean] = @"boolean",
    [BJSchemaTypeNull] = @"null"
};

- (id)initWithType:(BJSchemaType)type properties:(BJPropertyMap *)properties {
    self = [super init];
    if(self) {
        _type = type;
        _properties = properties;
    }
    return self;
}

+ (BJSchema *)parse:(NSString *)jString {
    if(jString == nil || [jString length] == 0)
        [NSException exceptionWithName:BJArgumentException
                                reason:@"input json cannot be null"
                              userInfo:nil];
    return [self parse:jString withSchemaName:[[[BJSchemaNames alloc] init] autorelease] encSpace:nil];
    
}

+ (BJSchema *)parse:(NSString *)json withSchemaName:(BJSchemaNames *)names encSpace:(NSString *)encSpace {
    BJSchema *schema = [BJPrimitiveSchema sharedInstanceForType:json];
    if(schema)
        return schema;
    @try {
        id jsonObj = [json objectFromJSONString];
        return [self parseJson:jsonObj names:names encSpace:encSpace];
    } @catch(NSException *ex) {
        [NSException exceptionWithName:BJSchemaParseException
                                reason:[NSString stringWithFormat:@"Could not parse %@\n%@", [ex reason], json]
                              userInfo:nil];
    }
}

+ (BJSchema *)parseJson:(id)jsonObj names:(BJSchemaNames *)names encSpace:(NSString *)encSpace {
    if(jsonObj == nil)
        [NSException exceptionWithName:BJArgumentException reason:@"node cannot be null." userInfo:nil];
    
    switch ([BJJsonHelper typeForObject:jsonObj]) {
        case BJJsonTypeText:{
            BJPrimitiveSchema *ps = [BJPrimitiveSchema sharedInstanceForType:jsonObj];
            if(ps)
                return ps;
            BJNamedSchema *schema = [names schemaWithName:jsonObj space:nil encSpace:encSpace];
            if(schema)
                return schema;
            [NSException exceptionWithName:BJSchemaParseException reason:[NSString stringWithFormat:@"Undefined name: %@", jsonObj] userInfo:nil];
            break;
        }
        case BJJsonTypeArray: {
            return [BJUnionSchema sharedInstanceForSchemas:jsonObj properties:nil names:names encSpace:encSpace];
        }
        case BJJsonTypeObject:{
            id type = [jsonObj objectForKey:@"type"];
            if(type == nil) {
                [NSException exceptionWithName:BJSchemaParseException reason:@"Property type is required." userInfo:nil];
            }
            BJPropertyMap *properties = [BJJsonHelper propertiesFromObject:type];
            
            switch ([BJJsonHelper typeForObject:type]) {
                case BJJsonTypeText:{
                    NSString *typeString = type;
                    if([typeString isEqualToString:@"array"]) {
                        return [BJArraySchema sharedInstanceForObject:jsonObj properties:properties names:names encSpace:encSpace];
                    } else if([typeString isEqualToString:@"map"]) {
                        return [BJMapSchema sharedInstanceForObject:jsonObj properties:properties names:names encSpace:encSpace];
                    }
                    BJPrimitiveSchema *ps = [BJPrimitiveSchema sharedInstanceForType:type];
                    if(ps)
                        return ps;
                    return [BJNamedSchema sharedInstanceForObject:jsonObj
                                                       properties:properties
                                                            names:names
                                                         encSpace:encSpace];
                }
                case BJJsonTypeArray:{
                    return [BJUnionSchema sharedInstanceForSchemas:type properties:properties names:names encSpace:encSpace];
                }
                default:break;//end of switch type
            }
            break;//end of BJJsonTypeObject case
        }
        default:break;//end of switch jsonObj
    }
    return nil;
}

+ (NSString *)nameForType:(BJSchemaType)type {
    return BJSchemaTypeNames[type];
}

- (NSString *)propertyForKey:(NSString *)key {
    if(self.properties == nil)
        return nil;
    return [self.properties objectForKey:key];
}

- (NSString *)name {
    [NSException exceptionWithName:BJCallException reason:@"name is not implemented" userInfo:nil];
    return nil;
}

- (NSString *)description {
    NSMutableDictionary *jObj = [self jsonObjectWithSchemaNames:[[BJSchemaNames alloc] init] encSpace:nil];
    return [jObj JSONString];
}

- (id)jsonObjectWithSchemaNames:(BJSchemaNames *)names encSpace:(NSString *)encSpace {
    NSMutableDictionary *jObj = [self startObject];
    [jObj setObject:[self jsonFieldsWithSchemaNames:names encSpace:encSpace] forKey:@"fields"];
    return jObj;
}

- (id)jsonFieldsWithSchemaNames:(BJSchemaNames *)names encSpace:(NSString *)encSpace {
    [NSException exceptionWithName:BJCallException reason:@"jsonFieldsWithSchemaNames:encSpace: is not implemented." userInfo:nil];
    return nil;
}

- (NSMutableDictionary *)startObject {
    NSMutableDictionary *jObj = [[NSMutableDictionary alloc] init];
    [jObj setObject:[BJSchema nameForType:self.type] forKey:@"type"];
    return jObj;
}

#pragma override NSObject methods

- (BOOL) isEqual:(id)object {
    if(object == self) {
        return YES;
    }
    if(![object isKindOfClass:[BJSchema class]]) {
        return NO;
    }
    BJSchema *that = (BJSchema *)object;
    if(self.type != [that type]) {
        return NO;
    }
    return self.properties != nil ? [self.properties isEqualToDictionary:[that properties]] : [that properties] == nil;
}

- (NSUInteger)hash {
    return self.type + [self.properties hash];
}

@end
