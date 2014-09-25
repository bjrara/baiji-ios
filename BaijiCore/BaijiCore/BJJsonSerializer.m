//
//  BJJsonSerializer.m
//  BaijiCore
//
//  Created by user on 14-9-17.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJJsonSerializer.h"

@interface BJJsonSerializer()

@property (atomic, readonly) NSMutableDictionary *readerCache;
@property (atomic, readonly) NSMutableDictionary *writerCache;

@end

@implementation BJJsonSerializer

- (void)serialize:(id)obj to:(NSData *)source {
    
}

- (id)deserialize:(Class)clazzType from:(NSData *)source {
    return nil;
}

@end