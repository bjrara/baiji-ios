//
//  BJRecordSchema.h
//  BaijiCore
//
//  Created by user on 14-9-18.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJNamedSchema.h"

@interface BJRecordSchema : BJNamedSchema

@property (nonatomic, readonly) NSArray *fields;
@property (nonatomic, readonly) int count;

- (id)initWithName:(BJSchemaName *)name
               doc:(NSString *)doc
           aliases:(NSArray *)aliases
        properties:(BJPropertyMap *)properties
            fields:(NSArray *)fields
           request:(BOOL)request;
@end
