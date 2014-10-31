//
//  BJServiceClient.m
//  BaijiCore
//
//  Created by zmy周梦伊 on 10/16/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import "BJServiceClient.h"
#import "BJHTTPRequestOperation.h"
#import "BJError.h"
#import "AFNetworkReachabilityManager.h"

@interface BJServiceClient()

@property (readwrite, nonatomic, retain) NSURL *baseUri;
@property (readwrite, nonatomic, retain) NSOperationQueue *operationQueue;

@end

@implementation BJServiceClient

+ (NSMutableDictionary *)clientCache {
    static NSMutableDictionary *__clientCache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __clientCache = [[NSMutableDictionary alloc] init];
    });
    return __clientCache;
}

+ (instancetype)sharedInstance:(NSString *)baseUri {
    if (![baseUri hasSuffix:@"/"]) {
        baseUri = [NSString stringWithFormat:@"%@/", baseUri];
    }
    BJServiceClient *client = [[BJServiceClient clientCache] objectForKey:baseUri];
    if (!client) {
        return [[BJServiceClient alloc] initWithBaseUri:baseUri];
    }
    return client;
}

- (instancetype)initWithBaseUri:(NSString *)baseUri {
    self = [super init];
    if (self) {
        self.debug = NO;
        self.baseUri = [NSURL URLWithString:baseUri];
        self.operationQueue = [[NSOperationQueue alloc] init];
        self.reachabilityManager = [AFNetworkReachabilityManager sharedManager];
        [[BJServiceClient clientCache] setObject:self forKey:baseUri];
    }
    return self;
}

- (void)invokeOperation: (NSString *)operationName
            withRequest:(id<BJMutableRecord>)requestObject
          responseClazz:(Class<BJMutableRecord>)responseClazz
                success:(void (^)(BJHTTPRequestOperation *operation, id<BJMutableRecord> responseObject))success
                failure:(void (^)(BJHTTPRequestOperation *operation, NSError *error))failure {
    if (self.reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        failure(nil, [NSError errorWithDomain:BJNetworkError code:0 userInfo:[NSDictionary dictionaryWithObject:@"Network not reachable." forKey:@"Status"]]);
        return;
    }
    BJHTTPRequestOperation *operation = [BJHTTPRequestOperation shardInstance];
    operation.debug = self.debug;
    operation = [operation POST:[[NSURL URLWithString:operationName relativeToURL:self.baseUri] absoluteString] headers:nil requestObj:requestObject responseClazz:responseClazz success:success failure:failure];
#if DEBUG
    if (self.debug) {
        [operation debugInfo];
    }
#endif
    [self.operationQueue addOperation:operation];
}

- (void)dealloc {
    [self.baseUri release];
    [super dealloc];
}

@end
