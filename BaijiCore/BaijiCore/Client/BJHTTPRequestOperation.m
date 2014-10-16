//
//  BJHTTPRequestOperation.m
//  BaijiCore
//
//  Created by zmy周梦伊 on 10/16/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import "BJHTTPRequestOperation.h"
#import "BJJsonSerializer.h"
#import "BJMutableRecord.h"

@interface BJHTTPRequestOperation ()

@property (atomic, readonly, retain) BJJsonSerializer *serializer;

@end


@implementation BJHTTPRequestOperation

- (instancetype)initWithRequest:(NSURLRequest *)urlRequest {
    self = [super initWithRequest:urlRequest];
    if (self) {
        _serializer = [[BJJsonSerializer alloc] init];
    }
    return self;
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
}

- (id)responseObject {
    
}

@end
