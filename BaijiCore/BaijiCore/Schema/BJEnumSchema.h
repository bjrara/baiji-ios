//
//  BJEnumSchema.h
//  BaijiCore
//
//  Created by user on 14-9-17.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJNamedSchema.h"

@interface BJEnumSchema : BJNamedSchema<NSFastEnumeration>

- (id)initWithSchemaName:(BJSchemaName *)schemaName
                     doc:(NSString *)doc
                 aliases:(NSArray *)aliases
                 symbols:(NSDictionary *)symbol
              properties:(BJPropertyMap *)properties;
@end
