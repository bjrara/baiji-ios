//
//  BJBenchmarkSerializer.h
//  BaijiCore
//
//  Created by zmy周梦伊 on 10/21/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJJsonSerializer.h"
@class BJGenericBenchmarkRecord;

typedef void (^BJBenchmark)(id object, NSString *type);

@protocol BJSerializerBenchmarkDelegate <NSObject>

- (void)serializer:(NSString *)serializer
         didFinish:(NSString *)type
           writing:(float)writingResult
           reading:(float)readingResult
            length:(int)length;

@end

@protocol BJBenchmarkCandidateDelegate <NSObject>

- (NSString *)name;

- (void)write:(NSString *)type record:(BJGenericBenchmarkRecord *)record source:(NSOutputStream *)writingSource;

- (void)read:(NSString *)type stream:(NSData *)stream;

@end

@interface BJSerializerBenchmark : NSObject

@property (nonatomic, strong) id<BJSerializerBenchmarkDelegate> masterDelegate;
@property (nonatomic, strong) id<BJBenchmarkCandidateDelegate> serializerDelegate;

- (void)batch;

@end

@interface BJJsonSerializerBenchmark : NSObject<BJBenchmarkCandidateDelegate>

@end

@interface BJAppleJsonSerializerBenchmark : NSObject<BJBenchmarkCandidateDelegate>

@end

@interface BJSBJsonSerializerBenchmark : NSObject<BJBenchmarkCandidateDelegate>

@end