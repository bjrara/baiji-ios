//
//  BJPrimitiveSchema.m
//  BaijiCore
//
//  Created by user on 14-9-18.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJPrimitiveSchema.h"
#import "BJPropertyMap.h"
#import "BJError.h"

@interface BJPrimitiveSchema()

@end

@implementation BJPrimitiveSchema

+ (NSDictionary *)typeMap {
    static NSDictionary *typeMap;
    
    NSMutableDictionary *map = [[NSMutableDictionary alloc] init];
    [map setObject:[NSNumber numberWithInt:BJSchemaTypeNull] forKey:@"null"];
    [map setObject:[NSNumber numberWithInt:BJSchemaTypeBoolean] forKey:@"boolean"];
    [map setObject:[NSNumber numberWithInt:BJSchemaTypeInt] forKey:@"int"];
    [map setObject:[NSNumber numberWithInt:BJSchemaTypeLong] forKey:@"long"];
    [map setObject:[NSNumber numberWithInt:BJSchemaTypeFloat] forKey:@"float"];
    [map setObject:[NSNumber numberWithInt:BJSchemaTypeDouble] forKey:@"double"];
    [map setObject:[NSNumber numberWithInt:BJSchemaTypeBytes] forKey:@"bytes"];
    [map setObject:[NSNumber numberWithInt:BJSchemaTypeString] forKey:@"string"];
    
    typeMap = [NSDictionary dictionaryWithDictionary:map];
    return typeMap;
}

+ (id)sharedInstanceForType:(NSString *)type {
    return [BJPrimitiveSchema sharedInstanceForType:type properties:nil];
}

+ (id)sharedInstanceForType:(NSString *)type properties:(BJPropertyMap *)properties {
    char quote = '\"';
    if([type characterAtIndex:0] == quote && [type characterAtIndex:[type length] - 1] == quote) {
        type = [type substringWithRange:NSMakeRange(1, [type length] - 2)];
    }
    NSNumber *schemaType = [[BJPrimitiveSchema typeMap] objectForKey:type];
    return schemaType != nil ?[[[BJPrimitiveSchema alloc] initWithType:[schemaType intValue]
                                                            properties:properties] autorelease] : nil;
}

- (NSString *)jsonObjectWithSchemaNames:(BJSchemaNames *)names encSpace:(NSString *)encSpace {
    return [self name];
}

#pragma override NSObject methods

- (BOOL)isEqual:(id)object {
    if(object == self)
        return YES;
    if(![object isKindOfClass:[BJPrimitiveSchema class]])
        return NO;
    BJPrimitiveSchema *that = (BJPrimitiveSchema *)object;
    if(self.type != [that type]) {
        return NO;
    }
    return self.properties == nil ? [that properties] == nil : [[self properties] isEqualToDictionary:[that properties]];
}

- (NSUInteger)hash {
    return 13 * [self type] + [[self properties] hash];
}

@end
