//
//  BJPingTestClient.m
//  BaijiCore
//
//  Created by zmy周梦伊 on 10/17/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import "BJPingTestClient.h"
#import "BJGetItemsRequestType.h"
#import "BJGetItemsResponseType.h"
#import "BJServiceClient.h"
#import "BJItem.h"

#import "AFHTTPRequestOperationManager.h"

@implementation BJPingTestClient

- (void)testPing {
    BJGetItemsRequestType *requestType = [[BJGetItemsRequestType alloc] init];
    requestType.take = [NSNumber numberWithInt:5];
    requestType.validationString = @"123456";
    
    __block BJGetItemsResponseType *responseType;
    
    BJServiceClient *client = [BJServiceClient sharedInstance:@"http://fxsoa4j.qa.nt.ctripcorp.com:8080"];
    [client invokeOperation:@"test-service/getItems" withRequest:requestType responseClazz:[BJGetItemsResponseType class] success:^(BJHTTPRequestOperation *operation, id<BJMutableRecord> responseObject) {
        responseType = responseObject;
        for (BJItem *item in [responseType items]) {
            NSLog(@"%@: %@", [item itemId], [item title]);
        }
    } failure:^(BJHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error description]);
    }];
}

@end
