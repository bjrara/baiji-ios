//
//  BJPropertyMap.m
//  BaijiCore
//
//  Created by user on 14-9-17.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJPropertyMap.h"
#import "BJError.h"

@implementation BJPropertyMap {
    NSMutableDictionary *_proxy;
}

- (id)init {
    self = [super init];
    if(self) {
        _proxy = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (id) forwardingTargetForSelector:(SEL)aSelector
{
    return _proxy;
}

+ (NSSet *)reservedProperties {
    static NSSet *reservedProperties;
    reservedProperties = [NSSet setWithObjects:@"type",
                          @"namespace",
                          @"fields",
                          @"items",
                          @"size",
                          @"symbols",
                          @"values",
                          @"aliases",
                          @"order",
                          @"doc",
                          @"default", nil];
    return reservedProperties;
}

- (void)parse:(id)data {
    if(data == nil || ![data isKindOfClass:[NSDictionary class]])
        return;
    NSSet *reservedProps = [BJPropertyMap reservedProperties];
    NSDictionary *props = data;
    [props enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if([reservedProps containsObject:key])
            return;
        if(![self containsKey:key])
            [self setObject:obj forKey:key];
    }];
}

- (BOOL)containsKey:(id)key {
    return [_proxy objectForKey:key] != nil;
}

- (void)addToObject:(NSMutableDictionary *)jsonObj {
    [_proxy enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [jsonObj setObject:obj forKey:key];
    }];
}

#pragma implementation of NSDictionary

- (NSUInteger)count {
    return [_proxy count];
}

- (id)objectForKey:(id)aKey {
    return [_proxy objectForKey:aKey];
}

- (NSEnumerator *)keyEnumerator {
    return [_proxy keyEnumerator];
}

#pragma implementation of NSMutableDictionary

- (void)removeObjectForKey:(id)aKey {
    [_proxy removeObjectForKey:aKey];
}

- (void)setObject:(id)anObject forKey:(id <NSCopying>)aKey {
    if([[BJPropertyMap reservedProperties] containsObject:aKey]) {
        [NSException exceptionWithName:BJException
                                reason:[NSString stringWithFormat:@"Can't set reserved properties: %@", aKey]
                              userInfo:nil];
    }
    
    NSString *oldValue = [self objectForKey:aKey];
    if(oldValue == nil)
        return [_proxy setObject:anObject forKey:aKey];
    else if(![oldValue isEqualToString:anObject])
        [NSException exceptionWithName:BJException
                                reason:[NSString stringWithFormat:@"Property cannot be overwritten: %@", anObject]
                              userInfo:nil];
}

#pragma override NSObject methods

- (BOOL)isEqual:(id)object {
    if(self == object)
        return YES;
    if(![object isKindOfClass:[BJPropertyMap class]])
        return NO;
    
    id that = (BJPropertyMap *)object;
    if([self count] != [that count])
        return NO;
    
    __block BOOL isEqual;
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if(![that containsKey:key]){
            isEqual = NO;
            *stop = YES;
        }
        if(![obj isEqualToString:[that objectForKey:key]]) {
            isEqual = NO;
            *stop = YES;
        }
    }];
    return isEqual;
}

- (NSUInteger)hash {
    __block int hash = [self count];
    __block int index = 1;
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        hash += (([key hash] + [obj hash]) * index++);
    }];
    return hash;
}

- (void)dealloc {
    [_proxy release];
    [super dealloc];
}

@end
