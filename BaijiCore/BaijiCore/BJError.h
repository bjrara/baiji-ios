//
//  BJError.h
//  BaijiCore
//
//  Created by user on 14-9-17.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    BJErrorInvalidResponseType,
    BJErrorNoErrorData
};

@interface BJError : NSObject

extern NSString *const BJException;
extern NSString *const BJRuntimeException;
extern NSString *const BJArgumentException;
extern NSString *const BJSchemaParseException;
extern NSString *const BJCallException;
extern NSString *const BJServiceError;
extern NSString *const BJNetworkError;

@end