//
//  BJSpecificJsonParser.h
//  BaijiCore
//
//  Created by user on 14-9-25.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJMutableRecord.h"
@class BJRecordSchema;

typedef void  (^BJJsonReadingResolver)(id parsedValue);

@interface BJSpecificJsonParser : NSObject

- (instancetype)initWithSchema:(BJRecordSchema *)schema;

- (id<BJMutableRecord>)readData:(NSData *)data;

@end
