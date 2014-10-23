//
//  BJJsonSerializer.h
//  BaijiCore
//
//  Created by user on 14-9-17.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJSerializable.h"

@interface BJJsonSerializer : NSObject<BJSerializable, NSCopying>

- (void)clearCache;

@end
