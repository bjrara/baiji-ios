//
//  BJPropertyMap.h
//  BaijiCore
//
//  Created by user on 14-9-17.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BJPropertyMap : NSMutableDictionary<NSObject>

- (void)parse:(NSDictionary *)data;

@end
