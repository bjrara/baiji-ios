//
//  BJSpecificJsonParser.h
//  BaijiCore
//
//  Created by user on 14-9-25.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJMutableRecord.h"

typedef void  (^BJJsonReadingResolver)(id parsedValue);

@interface BJSpecificJsonParser : NSObject

- (id<BJMutableRecord>)readData:(NSData *)data clazz:(Class<BJMutableRecord>)clazz;

@end
