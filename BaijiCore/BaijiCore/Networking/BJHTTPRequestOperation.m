//
//  BJHTTPRequestOperation.m
//  BaijiCore
//
//  Created by zmy周梦伊 on 10/16/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import "BJHTTPRequestOperation.h"
#import "BJJsonSerializer.h"
#import "BJResponseStatusType.h"
#import "BJHasResponseStatus.h"
#import "BJAckCodeType.h"
#import "JSONKit.h"
#import "BJError.h"
#import "BJErrorDataType.h"
#import "BJErrorClassificationCodeType.h"

static dispatch_queue_t http_request_operation_processing_queue() {
    static dispatch_queue_t bj_http_request_operation_processing_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bj_http_request_operation_processing_queue = dispatch_queue_create("com.ctriposs.baiji.networking.http-request.processing", DISPATCH_QUEUE_CONCURRENT);
    });
    
    return bj_http_request_operation_processing_queue;
}

static dispatch_group_t http_request_operation_completion_group() {
    static dispatch_group_t bj_http_request_operation_completion_group;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bj_http_request_operation_completion_group = dispatch_group_create();
    });
    
    return bj_http_request_operation_completion_group;
}

@interface AFURLConnectionOperation ()

@property (readwrite, nonatomic, strong) NSURLRequest *request;
@property (readwrite, nonatomic, strong) NSURLResponse *response;

@end

@interface BJHTTPRequestOperation ()

@property (readwrite, nonatomic, strong) Class responseClazz;
@property (readwrite, nonatomic, strong) NSError *serviceError;
@property (readwrite, nonatomic, strong) BJJsonSerializer *serializer;
@property (readwrite, nonatomic, strong) NSHTTPURLResponse *response;
@property (readwrite, nonatomic, strong) id responseObject;
@property (readwrite, nonatomic, strong) NSError *responseSerializationError;
@property (readwrite, nonatomic, strong) NSRecursiveLock *lock;

@end


@implementation BJHTTPRequestOperation

+ (instancetype)shardInstance {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _serializer = [[BJJsonSerializer alloc] init];
    }
    return self;
}

- (instancetype)initWithRequest:(NSURLRequest *)urlRequest {
    self = [super initWithRequest:urlRequest];
    if (self) {
        _serializer = [[BJJsonSerializer alloc] init];
    }
    return self;
}

- (NSMutableURLRequest *)requestWithURL:(NSString *)URL
                                 method:(NSString *)method
                                headers:(NSDictionary *)headers
                             requestObj:(id<BJMutableRecord>)requestObj {
    NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URL]];
    mutableRequest.HTTPMethod = method;
    return [self request:mutableRequest addingHeaders:headers serializingRequestObj:requestObj];
}

- (NSMutableURLRequest *)request:(NSMutableURLRequest *)request
                   addingHeaders:(NSDictionary *)headers
           serializingRequestObj:(id<BJMutableRecord>)requestObj {
    NSParameterAssert(request);
    NSParameterAssert(requestObj);
    
    [headers enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if(![request valueForHTTPHeaderField:key]) {
            [request setValue:obj forKeyPath:key];
        }
    }];
    if (![request valueForHTTPHeaderField:@"Content-Type"]) {
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    [request setHTTPBody:[self.serializer serialize:requestObj]];
    return request;
}

- (id)responseObject {
    NSParameterAssert(self.responseClazz);
    [self.lock lock];
    if (!_responseObject && [self isFinished] && ![self error]) {
        _responseObject = [self.serializer deserialize:self.responseClazz from:self.responseData];
        if ([_responseObject conformsToProtocol:@protocol(BJHasResponseStatus)]) {
            BJResponseStatusType *responseStatus = [_responseObject responseStatus];
            [self checkResponseStatus:responseStatus];
        } else {
            self.serviceError = [NSError errorWithDomain:BJServiceError
                                                    code:BJErrorInvalidResponseType
                                                userInfo:[NSDictionary dictionaryWithObject:@"Response class type doesn't conform to BJHasResponseStatus" forKey:@"errorInfo"]];
        }
    }
    [self.lock unlock];
    return _responseObject;
}

- (void)checkResponseStatus:(BJResponseStatusType *)reponseStatus {
    if ([reponseStatus.ack value] != BJAckCodeTypeFAILURE) {
        return;
    }
    if (reponseStatus.errors != nil && [reponseStatus.errors count] > 0) {
        BJErrorDataType *error = [reponseStatus.errors objectAtIndex:0];
        self.serviceError = [NSError errorWithDomain:BJServiceError
                                                code:[error.errorClassification value]
                                            userInfo:[NSDictionary dictionaryWithObject:error.message forKey:error.errorCode]];
    } else {
        self.serviceError = [NSError errorWithDomain:BJServiceError code:BJErrorNoErrorData userInfo:nil];
    }
}

- (NSError *)error {
    if (self.serviceError)
        return self.serviceError;
    return [super error];
}

- (BJHTTPRequestOperation *)POST:(NSString *)URL
                         headers:(NSDictionary *)headers
                      requestObj:(id<BJMutableRecord>)requestObj
                   responseClazz:(Class<BJMutableRecord>)responseClazz
                         success:(void (^)(BJHTTPRequestOperation *operation, id<BJMutableRecord> responseObject))success
                         failure:(void (^)(BJHTTPRequestOperation *operation, NSError *error))failure {
    self.responseClazz = responseClazz;
    NSMutableURLRequest *mutableRequest = [self requestWithURL:URL method:@"POST" headers:headers requestObj:requestObj];
    BJHTTPRequestOperation *operation = [[BJHTTPRequestOperation alloc] initWithRequest:mutableRequest];
    
    [operation setCompletionBlockWithSuccess:success failure:failure];
    operation.serializer = self.serializer;
    operation.completionGroup = self.completionGroup;
    operation.completionQueue = self.completionQueue;
    operation.responseClazz = self.responseClazz;
    
    return operation;
}

- (void)setCompletionBlockWithSuccess:(void (^)(BJHTTPRequestOperation *operation, id<BJMutableRecord> responseObject))success
                              failure:(void (^)(BJHTTPRequestOperation *operation, NSError *error))failure
{
    // completionBlock is manually nilled out in AFURLConnectionOperation to break the retain cycle.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
#pragma clang diagnostic ignored "-Wgnu"
    self.completionBlock = ^{
#if DEBUG
        NSLog(@"Status Code: %d", self.response.statusCode);
        [self.response.allHeaderFields enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSLog(@"%@ : %@", key, obj);
        }];
        NSLog(@"%@", [[self.responseData objectFromJSONData] JSONString]);
#endif
        if (self.completionGroup) {
            dispatch_group_enter(self.completionGroup);
        }
        
        dispatch_async(http_request_operation_processing_queue(), ^{
            if (self.error) {
                if (failure) {
                    dispatch_group_async(self.completionGroup ?: http_request_operation_completion_group(), self.completionQueue ?: dispatch_get_main_queue(), ^{
                        failure(self, self.error);
                    });
                }
            } else {
                id responseObject = self.responseObject;
                if (self.error) {
                    if (failure) {
                        dispatch_group_async(self.completionGroup ?: http_request_operation_completion_group(), self.completionQueue ?: dispatch_get_main_queue(), ^{
                            failure(self, self.error);
                        });
                    }
                } else {
                    if (success) {
                        dispatch_group_async(self.completionGroup ?: http_request_operation_completion_group(), self.completionQueue ?: dispatch_get_main_queue(), ^{
                            success(self, responseObject);
                        });
                    }
                }
            }
            
            if (self.completionGroup) {
                dispatch_group_leave(self.completionGroup);
            }
        });
    };
#pragma clang diagnostic pop
}

#pragma mark - AFURLRequestOperation

- (void)pause {
    [super pause];
    
    u_int64_t offset = 0;
    if ([self.outputStream propertyForKey:NSStreamFileCurrentOffsetKey]) {
        offset = [(NSNumber *)[self.outputStream propertyForKey:NSStreamFileCurrentOffsetKey] unsignedLongLongValue];
    } else {
        offset = [(NSData *)[self.outputStream propertyForKey:NSStreamDataWrittenToMemoryStreamKey] length];
    }
    
    NSMutableURLRequest *mutableURLRequest = [self.request mutableCopy];
    if ([self.response respondsToSelector:@selector(allHeaderFields)] && [[self.response allHeaderFields] valueForKey:@"ETag"]) {
        [mutableURLRequest setValue:[[self.response allHeaderFields] valueForKey:@"ETag"] forHTTPHeaderField:@"If-Range"];
    }
    [mutableURLRequest setValue:[NSString stringWithFormat:@"bytes=%llu-", offset] forHTTPHeaderField:@"Range"];
    self.request = mutableURLRequest;
}

#pragma mark - NSSecureCoding

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (!self) {
        return nil;
    }
    
    self.serializer = [decoder decodeObjectOfClass:[BJJsonSerializer class] forKey:NSStringFromSelector(@selector(serializer))];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
    
    [coder encodeObject:self.serializer forKey:NSStringFromSelector(@selector(serializer))];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    BJHTTPRequestOperation *operation = [super copyWithZone:zone];
    
    operation.serializer = [self.serializer copyWithZone:zone];
    operation.completionQueue = self.completionQueue;
    operation.completionGroup = self.completionGroup;
    
    return operation;
}

- (void)debugInfo {
    NSLog(@"%@ %@", [self.request HTTPMethod], [[self.request URL] relativePath]);
    NSLog(@"HOST: %@", [[self.request URL] host]);
    [[self.request allHTTPHeaderFields] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"%@: %@", key, obj);
    }];
    NSLog(@"%@", [[[self.request HTTPBody] objectFromJSONData] JSONString]);
}

@end