//
//  BJEnumSchema.h
//  BaijiCore
//
//  Created by user on 14-9-17.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJNamedSchema.h"

@interface BJEnumSchema : BJNamedSchema

@property (nonatomic, readonly) NSArray *symbols;

- (id)initWithSchemaName:(BJSchemaName *)schemaName
                     doc:(NSString *)doc
                 aliases:(NSArray *)aliases
                 symbols:(NSDictionary *)symbols
              properties:(BJPropertyMap *)properties;
- (NSUInteger)size;
- (int)oridinalForSymbol:(NSString *)symbol;
- (NSString *)symbolForValue:(int)value;
- (BOOL)containsSymbol:(NSString *)symbol;

@end
