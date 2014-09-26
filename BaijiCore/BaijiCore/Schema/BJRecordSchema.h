//
//  BJRecordSchema.h
//  BaijiCore
//
//  Created by user on 14-9-18.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJNamedSchema.h"

@class BJField;

@interface BJRecordSchema : BJNamedSchema

@property (nonatomic, readonly, retain) NSArray *fields;

- (id)initWithName:(BJSchemaName *)name
               doc:(NSString *)doc
           aliases:(NSArray *)aliases
        properties:(BJPropertyMap *)properties
            fields:(NSArray *)fields
           request:(BOOL)request;
- (NSUInteger)count;
- (BJField *)fieldForName:(NSString *)name;

@end
