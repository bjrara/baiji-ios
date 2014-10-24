//
//  BJJsonHelper.m
//  BaijiCore
//
//  Created by user on 14-9-17.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJJsonHelper.h"
#import "BJPropertyMap.h"
#import "BJError.h"

@implementation BJJsonHelper

+ (BJPropertyMap *)propertiesFromObject:(id)obj {
    BJPropertyMap *properties = [[BJPropertyMap alloc] init];
    [properties parse:obj];
    if([properties count] == 0) {
        [properties release];
        return nil;
    }
    return [properties autorelease];
}

+ (NSString *)requiredStringForObject:(NSDictionary *)obj field:(NSString *)field {
    NSString *value = [BJJsonHelper optionalStringForObject:obj field:field];
    if(value == nil || [value length] == 0)
        [NSException exceptionWithName:BJSchemaParseException
                                reason:[NSString stringWithFormat:@"No \"%@\" JSON field.", field]
                              userInfo:nil];
    return value;
}

+ (NSString *)optionalStringForObject:(NSDictionary *)obj field:(NSString *)field {
    if(obj == nil)
        [NSException exceptionWithName:BJArgumentException
                                reason:@"input object cannot be null."
                              userInfo:nil];
    [self validate:field];
    
    id child = [obj objectForKey:field];
    if(child == nil || child == [NSNull null])
        return nil;
    if(![child isKindOfClass:[NSString class]])
        [NSException exceptionWithName:BJSchemaParseException
                                reason:[NSString stringWithFormat:@"Field %@ is not a string", field]
                              userInfo:nil];
    return child;
    
}

+ (void) addToObjectIfNotNullOrEmpty:(NSDictionary *)jsonObj key:(NSString *)key value:(NSString *)value {
    if(value == nil || [value length] == 0)
        return;
    [jsonObj setValue:value forKey:key];
}

+ (void) validate:(NSString *)field {
    if(field == nil || [field length] == 0)
        [NSException exceptionWithName:BJArgumentException
                                reason:@"field cannot be null or empty."
                              userInfo:nil];
}

+ (BJJsonType)typeForObject:(id)jsonObj; {
    if([jsonObj isKindOfClass:[NSArray class]])
        return BJJsonTypeArray;
    if([jsonObj isKindOfClass:[NSString class]])
        return BJJsonTypeText;
    if([jsonObj isKindOfClass:[NSDictionary class]])
        return BJJsonTypeObject;
    return -1;
}

@end
