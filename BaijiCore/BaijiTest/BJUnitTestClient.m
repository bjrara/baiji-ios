//
//  BJPingTestClient.m
//  BaijiCore
//
//  Created by zmy周梦伊 on 10/17/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import "BJUnitTestClient.h"
#import "BJGetItemsRequestType.h"
#import "BJGetItemsResponseType.h"
#import "BJServiceClient.h"
#import "BJItem.h"

@interface BJUnitTestClient()

@property (nonatomic, assign) NSArray *items;

@end

@implementation BJUnitTestClient

- (void)testPing {
    BJGetItemsRequestType *requestType = [[BJGetItemsRequestType alloc] init];
    requestType.take = [NSNumber numberWithInt:5];
    requestType.validationString = @"123456";
    
    [self prepare];
    BJServiceClient *client = [BJServiceClient sharedInstance:@"http://localhost:8080/test-service"];
    [client invokeOperation:@"getItems" withRequest:requestType responseClazz:[BJGetItemsResponseType class] success:^(BJHTTPRequestOperation *operation, id<BJMutableRecord> responseObject) {
        BJGetItemsResponseType *responseType =(BJGetItemsResponseType *)responseObject;
        GHAssertTrue([[responseType items] count] == 5, nil);
        for (BJItem *item in [responseType items]) {
            GHTestLog(@"%@: %@", [item itemId], [item title]);
        }
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testPing)];
    } failure:^(BJHTTPRequestOperation *operation, NSError *error) {
        [self notify:kGHUnitWaitStatusFailure forSelector:@selector(testPing)];
    }];
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:1.0];
}

- (void)testServiceError {
    BJGetItemsRequestType *requestType = [[BJGetItemsRequestType alloc] init];
    requestType.take = [NSNumber numberWithInt:5];
    requestType.validationString = @"123456";
    requestType.returnWrappedErrorResponse  = [NSNumber numberWithBool:YES];
    
    [self prepare];
    BJServiceClient *client = [BJServiceClient sharedInstance:@"http://localhost:8080/test-service"];
    [client invokeOperation:@"getItems" withRequest:requestType responseClazz:[BJGetItemsResponseType class] success:^(BJHTTPRequestOperation *operation, id<BJMutableRecord> responseObject) {
    } failure:^(BJHTTPRequestOperation *operation, NSError *error) {
        GHAssertEqualStrings(error.domain, @"BaijiServiceError", nil);
        GHTestLog(@"%@", [error.userInfo description]);
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testServiceError)];
    }];
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:1.0];
}

- (void)testUnknownHostError {
    [self prepare];
    BJGetItemsRequestType *requestType = [[BJGetItemsRequestType alloc] init];
        BJServiceClient *client = [BJServiceClient sharedInstance:@"http://localhost:8080/"];
    [client invokeOperation:@"getItems" withRequest:requestType responseClazz:[BJGetItemsResponseType class] success:^(BJHTTPRequestOperation *operation, id<BJMutableRecord> responseObject) {
    } failure:^(BJHTTPRequestOperation *operation, NSError *error) {
        GHAssertEqualStrings(error.domain, @"NSURLErrorDomain", nil);
        GHTestLog(@"%@", [error.userInfo description]);
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testUnknownHostError)];
        }];
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

@end
