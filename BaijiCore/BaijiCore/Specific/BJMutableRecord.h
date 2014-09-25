//
//  BJSpecificRecordSerializable.h
//  BaijiCore
//
//  Created by user on 14-9-24.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJSchema.h"

@protocol BJMutableRecord <NSObject>

+ (BJSchema *)schema;

- (id)fieldAtIndex:(int)fieldPos;

- (id)fieldWithName:(NSString *)fieldName;

- (void)setObject:(id)object atIndex:(int)fieldPos;

- (void)setObject:(id)object forName:(NSString *)fieldName;

@end