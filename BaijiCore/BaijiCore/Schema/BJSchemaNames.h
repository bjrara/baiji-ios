//
//  BJSchemaNames.h
//  BaijiCore
//
//  Created by user on 14-9-17.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BJSchemaName;
@class BJNamedSchema;

@interface BJSchemaNames : NSObject

@property (nonatomic, readonly) NSMutableDictionary *names;

- (id)init;
- (BOOL)contains:(BJSchemaName *)name;
- (BOOL)addWithSchemaName:(BJSchemaName *)name mamedSchema:(BJNamedSchema *)schema;
- (BOOL)addwithNamedSchema:(BJNamedSchema *)schema;
- (BJNamedSchema *)schemaWithName:(NSString *)name space:(NSString *)space encSpace:(NSString *)encSpace;
- (NSEnumerator *)keyEnumerator;

@end
