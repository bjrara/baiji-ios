//
//  BJGenericBenchmarkRecord.m
//  BaijiCore
//
//  Created by zmy周梦伊 on 10/21/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import "BJGenericBenchmarkRecord.h"

@implementation BJGenericBenchmarkRecord

static NSString *_recordType;
static NSUInteger _onceToken;
static BJSchema *_schema;

+ (BJSchema *)schema {
    if (_schema == nil) {
        _schema = [[BJSchema parse:[NSString stringWithFormat:@"{\"type\":\"record\",\"name\":\"GenericBenchmarkRecord\",\"namespace\":\"com.ctriposs.baiji.generic\",\"fields\":[{\"name\":\"fieldValue\",\"type\": %@}]}", _recordType]] retain];
    }
    return _schema;
}

+ (void)setRecordType:(NSString *)recordType {
    _recordType = recordType;
}

+ (void)clear {
    if (_schema) {
        [_schema release];
        _schema = nil;
    }
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