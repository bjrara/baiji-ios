//
//  BJGenericBenchmarkRecord.m
//  BaijiCore
//
//  Created by zmy周梦伊 on 10/21/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import "BJGenericBenchmarkRecord.h"

@interface BJGenericBenchmarkRecord()

@property (atomic, assign) BOOL updatedToken;
@property (nonatomic) NSString *fieldType;

@end

@implementation BJGenericBenchmarkRecord

- (BJSchema *)schema {
    static BJSchema *__schema;
    if (!__schema) {
        self.updatedToken = NO;
        __schema = [[BJSchema parse:[NSString stringWithFormat:@"{\"type\":\"record\",\"name\":\"BJGenericBenchmarkRecord\",\"namespace\":\"com.ctriposs.baiji.generic\",\"fields\":[{\"name\":\"fieldValue\",\"type\":%@}]}", self.fieldType]] retain];
    }
    if (__schema && self.updatedToken) {
        [__schema release];
        __schema = nil;
    }
    return __schema;
}

- (void)setRecordType:(NSString *)recordType {
    self.fieldType = recordType;
    self.updatedToken = YES;
}

- (id)fieldAtIndex:(int)fieldPos {
    return self.fieldValue;
}

- (id)fieldForName:(NSString *)fieldName {
    return self.fieldValue;
}

- (void)setObject:(id)object atIndex:(int)fieldPos {
    self.fieldValue = object;
}

- (void)setObject:(id)object forName:(NSString *)fieldName {
    self.fieldValue = object;
}

@end