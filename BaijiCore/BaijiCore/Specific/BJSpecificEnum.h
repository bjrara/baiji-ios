//
//  BJEnum.h
//  BaijiCore
//
//  Created by user on 14-9-25.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BJSpecificEnum : NSObject

@property (nonatomic, readwrite) NSUInteger value;

- (NSString *)name;
- (NSUInteger)ordinalForName:(NSString *)name;

@end
