//
//  BJTestSerializerSample.h
//  BaijiCore
//
//  Created by user on 14-9-25.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJMutableSpecificRecord.h"

@class BJEnum1ValuesSpecific;

@interface BJTestSerializerSample : BJMutableSpecificRecord

@property (nonatomic, readwrite, assign) NSNumber *int1;
@property (nonatomic, readwrite, assign) NSNumber *tinyint1;
@property (nonatomic, readwrite, assign) NSNumber *smallint1;
@property (nonatomic, readwrite, assign) NSNumber *bigint1;
@property (nonatomic, readwrite, assign) NSNumber *boolean1;
@property (nonatomic, readwrite, assign) NSNumber *double1;
@property (nonatomic, readwrite, assign) NSString *string1;
@property (nonatomic, readwrite, assign) NSArray *list1;
@property (nonatomic, readwrite, assign) NSDictionary *map1;
@property (nonatomic, readwrite, assign) BJEnum1ValuesSpecific *enum1;
@property (nonatomic, readwrite, assign) NSNumber *nullableint;
@property (nonatomic, readwrite, assign) NSData *bytes1;
@property (nonatomic, readwrite, assign) NSDate *date1;

- (id)initWithInt1:(NSNumber *)int1
          tinyInt1:(NSNumber *)tinyint1
         smallInt1:(NSNumber *)smallint1
           bigInt1:(NSNumber *)bigint1
          boolean1:(NSNumber *)boolean1
           double1:(NSNumber *)double1
           string1:(NSString *)string1
             list1:(NSArray *)list1
              map1:(NSDictionary *)map1
             enum1:(BJEnum1ValuesSpecific *)enum1
       nullableint:(NSNumber *)nullableint
            bytes1:(NSData *)bytes1
             date1:(NSDate *)date1;

@end