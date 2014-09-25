//
//  BJSpecificJsonReader.h
//  BaijiCore
//
//  Created by user on 14-9-24.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJMutableRecord.h"

@class BJSchema;

typedef void  (^BJJsonWritingResolver)(id parsedValue);

@interface BJSpecificJsonWriter : NSObject

- (NSData *)writeObject:(id<BJMutableRecord>)object;

@end