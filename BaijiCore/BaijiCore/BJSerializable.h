//
//  BJSerializable.h
//  BaijiCore
//
//  Created by user on 14-9-17.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BJSerializable <NSObject>

- (NSData *)serialize:(id)obj;

- (id)deserialize:(Class)clazz from:(NSData *)source;

@end