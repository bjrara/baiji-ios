//
//  BJBenchmarkSerializer.h
//  BaijiCore
//
//  Created by zmy周梦伊 on 10/21/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJJsonSerializer.h"

typedef void (^BJBenchmark)(id object, NSString *type);

@protocol BJSerializerBenchmarkDelegate <NSObject>

- (void)serializer:(NSString *)serializer didFinish:(NSString *)type writing:(float)writingResult reading:(float)readingResult;

@end

@protocol BJBenchmarkCandidateDelegate <NSObject>

@property (nonatomic, strong) id<BJSerializerBenchmarkDelegate> masterDelegate;

- (void)benchmark:(NSString *)type fieldValue:(id)object;

@end

@interface BJSerializerBenchmark : NSObject

@property (nonatomic, strong) id<BJBenchmarkCandidateDelegate> serializerDelegate;

- (void)batch;

@end

@interface BJJsonSerializerBenchmark : NSObject<BJBenchmarkCandidateDelegate>

@end

@interface BJAppleJsonSerializerBenchmark : NSObject<BJBenchmarkCandidateDelegate>

@end

@interface BJSBJsonSerializerBenchmark : NSObject<BJBenchmarkCandidateDelegate>

@end