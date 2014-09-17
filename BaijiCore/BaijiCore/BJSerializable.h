//
//  BJSerializable.h
//  BaijiCore
//
//  Created by user on 14-9-17.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BJSerializable <NSObject>

- (void)serialize:(id)obj to:(NSData *)source;

- (id)deserialize:(Class)clazzType from:(NSData *)source;

@end