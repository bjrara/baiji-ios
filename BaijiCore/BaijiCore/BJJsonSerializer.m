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

@property (atomic, readonly) NSMutableDictionary *readerCache;
@property (atomic, readonly) NSMutableDictionary *writerCache;

@end

@implementation BJJsonSerializer

- (NSData *)serialize:(id)obj {
    BJSpecificJsonWriter *writer = [[BJSpecificJsonWriter alloc] init];
    return [writer writeObject:obj];
}

- (id)deserialize:(Class)clazz from:(NSData *)source {
    BJSpecificJsonParser *parser = [[BJSpecificJsonParser alloc] init];
    return [parser readData:source clazz:clazz];
}

@end