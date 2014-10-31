//
//  BJPerfTestClient.m
//  BaijiCore
//
//  Created by zmy周梦伊 on 10/31/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import "BJPerfTestClient.h"
#import "BJGetItemsRequestType.h"
#import "BJGetItemsResponseType.h"
#import "BJServiceClient.h"
#import "BJItem.h"

@interface BJPerfTestClient()

@property (readwrite, atomic) int count;

@end

@implementation BJPerfTestClient

- (void)testMultiThreadClient {
    self.count = 0;
    [self prepare];
    for (int i = 0; i < 30; i++) {
        int rand = arc4random_uniform(30);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self fetchDataWithNumber:rand];
        });
    }
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];
}

- (void)fetchDataWithNumber:(int)number {
    BJGetItemsRequestType *requestType = [[BJGetItemsRequestType alloc] init];
    requestType.take = [NSNumber numberWithInt:number];
    requestType.validationString = @"123456";

    BJServiceClient *client = [BJServiceClient sharedInstance:@"http://localhost:8080/test-service"];
    [client invokeOperation:@"getItems" withRequest:requestType responseClazz:[BJGetItemsResponseType class] success:^(BJHTTPRequestOperation *operation, id<BJMutableRecord> responseObject) {
        BJGetItemsResponseType *responseType =(BJGetItemsResponseType *)responseObject;
        GHAssertTrue([[responseType items] count] == number, nil);
        [self didFetchData];
    } failure:^(BJHTTPRequestOperation *operation, NSError *error) {
        GHFail(nil);
    }];
}

- (void)didFetchData {
    self.count++;
    if (self.count == 30) {
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testMultiThreadClient)];
    }
}

@end
