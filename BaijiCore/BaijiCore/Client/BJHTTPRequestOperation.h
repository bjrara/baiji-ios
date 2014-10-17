//
//  BJHTTPRequestOperation.h
//  BaijiCore
//
//  Created by zmy周梦伊 on 10/16/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFURLConnectionOperation.h"
#import "BJMutableRecord.h"

@interface BJHTTPRequestOperation : AFURLConnectionOperation

+ (instancetype)shardInstance;

- (BJHTTPRequestOperation *)POST:(NSString *)URL
                         headers:(NSDictionary *)headers
                      requestObj:(id<BJMutableRecord>)requestObj
                   responseClazz:(Class<BJMutableRecord>)responseClazz
                         success:(void (^)(BJHTTPRequestOperation *operation, id<BJMutableRecord> responseObject))success
                         failure:(void (^)(BJHTTPRequestOperation *operation, NSError *error))failure;

@end