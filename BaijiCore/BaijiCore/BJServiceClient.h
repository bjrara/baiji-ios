//
//  BJServiceClient.h
//  BaijiCore
//
//  Created by zmy周梦伊 on 10/16/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJMutableRecord.h"

@class BJHTTPRequestOperation;

typedef enum {
    BJConnectionDirect,
    BJConnectionIndirect,
} BJConnectionMode;

@interface BJServiceClient : NSObject

/**
 Get a BJServiceClient instance in direct connection mode. It is supposed to be used only for local testing, but not in Test, UAT or production environments.
 
 @param baseUri The target service URL
 */
+ (instancetype)sharedInstance:(NSString *)baseUri;

/**
 Invoke an operation with request object and process the response according to the given response type.
 
 @param operationName The operation name to be invoked.
 @param requestObject The request object whose class must conform to `BJMutableRecord` protocol
 @param responseClazz The response class conforming to `BJMutableRecord` protocol
 @param success A block object to be executed when the request operation finishes successfully. This block has no return value and takes two arguments: the created request operation and the object created from the response data of request.
 @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes two arguments: the created request operation and the `NSError` object describing the network or parsing error that occurred.
 */
- (void)invokeOperation: (NSString *)operationName
            withRequest:(id<BJMutableRecord>)requestObject
          responseClazz:(Class<BJMutableRecord>)responseClazz
                success:(void (^)(BJHTTPRequestOperation *operation, id<BJMutableRecord> responseObject))success
                failure:(void (^)(BJHTTPRequestOperation *operation, NSError *error))failure;

@end
