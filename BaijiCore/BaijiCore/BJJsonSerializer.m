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

@interface BJJsonSerializer()

@property (nonatomic, retain) NSLock *readLock;
@property (nonatomic, retain) NSLock *writeLock;

@end

@implementation BJJsonSerializer

static dispatch_once_t onceToken;
static NSMutableDictionary *_readerCache;
static NSMutableDictionary *_writerCache;

- (instancetype)init {
    self = [super init];
    if (self) {
        _readLock = [[NSLock alloc] init];
        _writeLock = [[NSLock alloc] init];

        dispatch_once(&onceToken, ^{
            _readerCache = [[NSMutableDictionary alloc] init];
            _writerCache = [[NSMutableDictionary alloc] init];
        });
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
    [self.readLock lock];
    parser = [_readerCache objectForKey:clazzName];
    if (parser) {
        [self.readLock unlock];
        return parser;
    } else {
        parser = [[BJSpecificJsonParser alloc] initWithSchema:(BJRecordSchema *)[[clazz new] schema]];
        [_readerCache setObject:parser forKey:clazzName];
        [self.readLock unlock];
    }
    return parser;
}

- (BJSpecificJsonWriter *)getWriter:(Class)clazz {
    NSString *clazzName = NSStringFromClass(clazz);
    BJSpecificJsonWriter *writer = [_writerCache objectForKey:clazzName];
    if (writer)
        return writer;
    [self.writeLock lock];
    writer = [_writerCache objectForKey:clazzName];
    if (writer) {
        [self.writeLock unlock];
        return writer;
    } else {
        writer = [[BJSpecificJsonWriter alloc] init];
        [_writerCache setObject:writer forKey:clazzName];
        [self.writeLock unlock];
    }
    return writer;
}

- (void)clearCache {
    [self.readLock release];
    [self.writeLock release];
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

