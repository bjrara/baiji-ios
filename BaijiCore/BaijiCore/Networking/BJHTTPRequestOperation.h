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
@class AFNetworkReachabilityManager;

@interface BJHTTPRequestOperation : AFURLConnectionOperation

typedef void (^BJOperationSuccess)(BJHTTPRequestOperation *operation, id<BJMutableRecord> responseObject);
typedef void (^BJOperationFailure)(BJHTTPRequestOperation *operation, NSError *error);

@property (readwrite, nonatomic, strong) AFNetworkReachabilityManager *reachabilityManager;

+ (instancetype)shardInstance;

- (BJHTTPRequestOperation *)POST:(NSString *)URL
                         headers:(NSDictionary *)headers
                      requestObj:(id<BJMutableRecord>)requestObj
                   responseClazz:(Class<BJMutableRecord>)responseClazz
                         success:(BJOperationSuccess)success
                         failure:(BJOperationFailure)failure;
- (void)debugInfo;

@end