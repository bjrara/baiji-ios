//
//  BJJsonSerializer.m
//  BaijiCore
//
//  Created by user on 14-9-17.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJJsonSerializer.h"
#import "BJSpecificJsonParser.h"
#import "BJSpecificJsonWriter.h"

@implementation BJJsonSerializer

static NSMutableDictionary *_readerCache;
static NSMutableDictionary *_writerCache;

- (instancetype)init {
    self = [super init];
    if (self) {
        _readerCache = [[NSMutableDictionary alloc] init];
        _writerCache = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (NSData *)serialize:(id)obj {
    BJSpecificJsonWriter *writer = [self getWriter:[obj class]];
    return [writer writeObject:obj];
}

- (id)deserialize:(Class)clazz from:(NSData *)source {
    BJSpecificJsonParser *parser = [self getParser:clazz];
    return [parser readData:source];
}

- (BJSpecificJsonParser *)getParser:(Class)clazz {
    NSString *clazzName = NSStringFromClass(clazz);
    BJSpecificJsonParser *parser = [_readerCache objectForKey:clazzName];
    if (parser)
        return parser;
    parser = [[BJSpecificJsonParser alloc] initWithSchema:(BJRecordSchema *)[[clazz new] schema]];
    [_readerCache setObject:parser forKey:clazzName];
    return parser;
}

- (BJSpecificJsonWriter *)getWriter:(Class)clazz {
    NSString *clazzName = NSStringFromClass(clazz);
    BJSpecificJsonWriter *writer = [_writerCache objectForKey:clazzName];
    if (writer)
        return writer;
    writer = [[BJSpecificJsonWriter alloc] init];
    [_writerCache setObject:writer forKey:clazzName];
    return writer;
}

- (void)clearCache {
    [_readerCache release];
    [_writerCache release];
    _readerCache = nil;
    _writerCache = nil;
}

#pragma implementation of NSCopying

- (id)copyWithZone:(NSZone *)zone {
    BJJsonSerializer *serializer = [[[self class] allocWithZone:zone] init];
    return serializer;
}

@end