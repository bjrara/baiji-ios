//
//  BJSchemaNames.m
//  BaijiCore
//
//  Created by user on 14-9-17.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJSchemaNames.h"
#import "BJNamedSchema.h"
#import "BJSchemaName.h"

@implementation BJSchemaNames

- (id)init {
    self = [super init];
    if(self) {
        _names = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (BOOL)contains:(BJSchemaName *)name {
    return [self.names objectForKey:name] != nil;
}

- (BOOL)addWithSchemaName:(BJSchemaName *)name namedSchema:(id)schema {
    if([self contains:name])
        return NO;
    [self.names setObject:schema forKey:name];
    return YES;
}

- (BOOL)addwithNamedSchema:(BJNamedSchema *)schema {
    return [self addWithSchemaName:[schema schemaName] namedSchema:schema];
}

- (BJNamedSchema *)schemaWithName:(NSString *)name space:(NSString *)space encSpace:(NSString *)encSpace {
    BJSchemaName *key = [[[BJSchemaName alloc] initWithName:name space:space encSpace:encSpace] autorelease];
    return [self.names objectForKey:key];
}

- (NSEnumerator *)keyEnumerator {
    return [self.names keyEnumerator];
}

- (void)dealloc {
    [_names release];
    [super dealloc];
}
@end
