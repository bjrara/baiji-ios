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

@implementation BJMutableSpecificRecord

+ (BJSchema *)schema {
    return [BJMutableSpecificRecord schema];
}

- (id)fieldAtIndex:(int)fieldPos {
    return nil;
}

- (id)fieldWithName:(NSString *)fieldName {
    if(![[BJMutableSpecificRecord schema] isKindOfClass:[BJRecordSchema class]]) {
        return nil;
    }
    BJRecordSchema *rs = (BJRecordSchema *)[BJMutableSpecificRecord schema];
    BJField *field = [rs fieldForName:fieldName];
    return field == nil ? [self fieldAtIndex:[field pos]] : nil;
}

- (void)setObject:(id)object atIndex:(int)fieldPos {

}

- (void)setObject:(id)object forName:(NSString *)fieldName {
    if(![[[self class] schema] isKindOfClass:[BJRecordSchema class]]) {
        return;
    }
    BJRecordSchema *rs = (BJRecordSchema *)[[self class] schema];
    BJField *field = [rs fieldForName:fieldName];
    if(field != nil) {
        [self setObject:object atIndex:[field pos]];
    }
}

@end
