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

@interface BJPingTestClient()

@property (nonatomic, assign) NSArray *items;

@end

@implementation BJPingTestClient

- (void)testPing {
    BJGetItemsRequestType *requestType = [[BJGetItemsRequestType alloc] init];
    requestType.take = [NSNumber numberWithInt:5];
    requestType.validationString = @"123456";
    
    BJServiceClient *client = [BJServiceClient sharedInstance:@"http://fxsoa4j.qa.nt.ctripcorp.com:8080"];
    [client invokeOperation:@"test-service/getItems" withRequest:requestType responseClazz:[BJGetItemsResponseType class] success:^(BJHTTPRequestOperation *operation, id<BJMutableRecord> responseObject) {
        BJGetItemsResponseType *responseType = (BJGetItemsResponseType *)responseObject;
        GHAssertTrue([[responseType items] count] == 5, nil);
        for (BJItem *item in [responseType items]) {
            NSLog(@"%@: %@", [item itemId], [item title]);
        }
    } failure:^(BJHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error description]);
    }];
}

@end
