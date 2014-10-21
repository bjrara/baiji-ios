//
//  BJHasResponseStatus.h
//  BaijiCore
//
//  Created by zmy周梦伊 on 10/21/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BJResponseStatusType;

@protocol BJHasResponseStatus <NSObject>

@property (nonatomic, readwrite, retain) BJResponseStatusType *responseStatus;

@end