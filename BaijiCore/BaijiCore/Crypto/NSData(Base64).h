//
//  NSData(Base64).h
//  BaijiCore
//
//  Created by user on 14-9-26.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData(Base64)

/**
 This method is extracted from AFNetworking for the purpose of encoding bytes using JSONKit.
 It can be replaced by native method:
    `- (NSString *)base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)options` ,
 if Apple SDK version >= iOS7.
 */
- (NSString *)base64EncodedString __deprecated;

/**
 This method serves for decoding bytes using JSONKit.
 It can be replaced by native method:
    `- (NSData *)base64EncodedDataWithOptions:NSDataBase64EncodingOptions`
 if Apple SDK version >= iOS7.
 */
+ (NSData *)dataWithBase64String:(NSString *)string __deprecated;
@end
