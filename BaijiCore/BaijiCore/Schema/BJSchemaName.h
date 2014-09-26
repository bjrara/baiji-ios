//
//  BJSchemaName.h
//  BaijiCore
//
//  Created by user on 14-9-17.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BJSchemaNames;

@interface BJSchemaName : NSObject<NSCopying>

@property (nonatomic, readonly, retain) NSString *name;
@property (nonatomic, readonly, retain) NSString *space;
@property (nonatomic, readonly, retain) NSString *encSpace;
@property (nonatomic, readonly, retain) NSString *fullName;

- (id)initWithName:(NSString *)name space:(NSString *)space encSpace:(NSString *)encSpace;
- (NSString *)string;
- (NSString *)ns;
- (void)addToObject:(NSDictionary *)obj names:(BJSchemaNames *)names;

@end