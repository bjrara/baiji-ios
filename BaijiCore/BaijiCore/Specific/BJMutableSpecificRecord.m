//
//  BJMutableSpecificRecord.m
//  BaijiCore
//
//  Created by user on 14-9-25.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJMutableSpecificRecord.h"
#import "BJRecordSchema.h"
#import "BJField.h"

@interface BJMutableSpecificRecord()

@property (nonatomic, readwrite) BJSchema *schema;

@end

@implementation BJMutableSpecificRecord

- (id)initWithSchema:(BJSchema *)schema {
    self = [super init];
    if(self) {
        _schema = schema;
    }
    return self;
}

- (BJSchema *)schema {
    return self.schema;
}

- (id)fieldAtIndex:(int)fieldPos {
    return nil;
}

- (id)fieldWithName:(NSString *)fieldName {
    if(![self.schema isKindOfClass:[BJRecordSchema class]]) {
        return nil;
    }
    BJRecordSchema *rs = (BJRecordSchema *)self.schema;
    BJField *field = [rs fieldForName:fieldName];
    return field == nil ? [self fieldAtIndex:[field pos]] : nil;
}

- (void)setObject:(id)object atIndex:(int)fieldPos {

}

- (void)setObject:(id)object forName:(NSString *)fieldName {
    if(![self.schema isKindOfClass:[BJRecordSchema class]]) {
        return;
    }
    BJRecordSchema *rs = (BJRecordSchema *)self.schema;
    BJField *field = [rs fieldForName:fieldName];
    if(field != nil) {
        [self setObject:object atIndex:[field pos]];
    }
}

@end
