//
//  BJGenericBenchmarkRecord.h
//  BaijiCore
//
//  Created by zmy周梦伊 on 10/21/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJMutableSpecificRecord.h"

@interface BJGenericBenchmarkRecord : BJMutableSpecificRecord

@property (nonatomic, readwrite, strong) id fieldValue;

+ (void)setRecordType:(NSString *)recordType;
+ (void)clear;

@end
