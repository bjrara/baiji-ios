//
//  BJMapSchema.m
//  BaijiCore
//
//  Created by user on 14-9-22.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJMapSchema.h"
#import "BJError.h"
#import "BJSchema.h"
#import "BJPropertyMap.h"

@implementation BJMapSchema

- (id)initWithValueSchema:(BJSchema *)valueSchema properties:(BJPropertyMap *)properties {
    self = [super initWithType:BJSchemaTypeMap properties:properties];
    if(self) {
        if(valueSchema == nil)
            [NSException exceptionWithName:BJArgumentException reason:@"valueSchema cannot be null." userInfo:nil];
        _valueSchema = valueSchema;
    }
    return self;
}

+ (BJMapSchema *)sharedInstanceForObject:(NSDictionary *)jsonObj
                              properties:(BJPropertyMap *)properties
                                   names:(BJSchemaNames *)names
                                encSpace:(NSString *)encSpace {
    id jValues = [jsonObj objectForKey:@"values"];
    if(jValues == nil)
        [NSException exceptionWithName:BJCallException reason:@"Map does not have 'values'." userInfo:nil];
    BJSchema *valueSchema = [BJSchema parseJson:jValues names:names encSpace:encSpace];
    return [[BJMapSchema alloc] initWithValueSchema:valueSchema properties:properties];
}

- (NSDictionary *)jsonObjectWithSchemaNames:(BJSchemaNames *)names encSpace:(NSString *)encSpace {
    NSMutableDictionary *jObj = [super jsonObjectWithSchemaNames:names encSpace:encSpace];
    [jObj setObject:[self jsonFieldsWithSchemaNames:names encSpace:encSpace] forKey:@"values"];
    return jObj;
}

- (id)jsonFieldsWithSchemaNames:(BJSchemaNames *)names encSpace:(NSString *)encSpace {
    return [self.valueSchema jsonObjectWithSchemaNames:names encSpace:encSpace];
}

#pragma override NSObject methods

- (BOOL)isEqual:(id)object {
    if(self == object)
        return YES;
    if(![object isKindOfClass:[BJMapSchema class]])
        return NO;
    BJMapSchema *that = (BJMapSchema *)object;
    if(that == nil)
        return NO;
    return [self.valueSchema isEqual:[that valueSchema]] && [self.properties isEqualToDictionary:[that properties]];
}

- (NSUInteger)hash {
    return 29 * [self.valueSchema hash] + [self.properties hash];
}

@end
