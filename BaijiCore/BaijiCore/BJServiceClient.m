//
//  BJServiceClient.m
//  BaijiCore
//
//  Created by zmy周梦伊 on 10/16/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import "BJServiceClient.h"
#import "BJHTTPRequestOperation.h"

@interface BJServiceClient()

@property (nonatomic, readwrite, retain) NSURL *baseUri;
@property (nonatomic, strong) NSOperationQueue *operationQueue;

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
        [[BJServiceClient clientCache] setObject:self forKey:baseUri];
    }
    return self;
}

- (void)invokeOperation: (NSString *)operationName
            withRequest:(id<BJMutableRecord>)requestObject
          responseClazz:(Class<BJMutableRecord>)responseClazz
                success:(void (^)(BJHTTPRequestOperation *operation, id<BJMutableRecord> responseObject))success
                failure:(void (^)(BJHTTPRequestOperation *operation, NSError *error))failure {
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
