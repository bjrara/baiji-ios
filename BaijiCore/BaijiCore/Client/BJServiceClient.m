//
//  BJServiceClient.m
//  BaijiCore
//
//  Created by zmy周梦伊 on 10/16/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import "BJServiceClient.h"

@interface BJServiceClient()

@property (nonatomic, readwrite) BJConnectionMode connectionMode;

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

+ ( instancetype)sharedInstance:(NSString *)baseUri {
    BJServiceClient *client = [[BJServiceClient clientCache] objectForKey:baseUri];
    if (!client) {
        return [[BJServiceClient alloc] initWithBaseUri:baseUri];
    }
    return client;
}

+ (instancetype)sharedInstanceForService:(NSString *)serviceName
                               namespace:(NSString *)space
                                  subEnv:(NSString *)subEnv {
    BJServiceClient *client = [[BJServiceClient clientCache] objectForKey:[NSString stringWithFormat:@"%@{%@}", serviceName, space]];
    if (!client)
        return [[BJServiceClient alloc] initWithService:serviceName namespace:space subEnv:subEnv];
    return client;
}

- (instancetype)initWithBaseUri:(NSString *)baseUri {
    self = [super init];
    if (self) {
        self.connectionMode = BJConnectionDirect;
        [[BJServiceClient clientCache] setObject:self forKey:baseUri];
    }
    return self;
}

- (instancetype)initWithService:(NSString *)serviceName
                      namespace:(NSString *)space
                         subEnv:(NSString *)subEnv {
    self = [super init];
    if (self) {
        self.connectionMode = BJConnectionIndirect;
        [[BJServiceClient clientCache] setObject:self forKey:[NSString stringWithFormat:@"%@{%@}", serviceName, space]];
    }
    return self;
}

- (void)invokeOperation: (NSString *)operationName
            withRequest:(id<BJMutableRecord>)requestObject
          responseClass:(Class<BJMutableRecord>)responseClazz
                success:(void (^)(BJHTTPRequestOperation *operation, id<BJMutableRecord> responseObject))success
                failure:(void (^)(BJHTTPRequestOperation *operation, NSError *error))failure {
    
}
@end
