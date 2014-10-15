//
//  BJTestSerializerSampleList.m
//  BaijiCore
//
//  Created by zmy周梦伊 on 10/15/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import "BJTestSerializerSampleList.h"
#import "BJTestSerializerSample.h"
#import "BJSchema.h"
#import "BJEnum1ValuesSpecific.h"
#import "BJError.h"

@implementation BJTestSerializerSampleList

+ (BJSchema *)schema {
    static BJSchema *__schema = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __schema = [[BJSchema parse:@"{\"type\":\"record\",\"name\":\"BJTestSerializerSampleList\",\"namespace\":\"com.ctriposs.baiji.specific\",\"doc\":null,\"fields\":[{\"name\":\"samples\",\"type\":[{\"type\":\"array\",\"items\":{\"type\":\"record\",\"name\":\"BJTestSerializerSample\",\"namespace\":\"com.ctriposs.baiji.specific\",\"doc\":null,\"fields\":[{\"name\":\"int1\",\"type\":\"int\"},{\"name\":\"tinyint1\",\"type\":\"int\"},{\"name\":\"smallint1\",\"type\":\"int\"},{\"name\":\"bigint1\",\"type\":\"long\"},{\"name\":\"boolean1\",\"type\":\"boolean\"},{\"name\":\"double1\",\"type\":\"double\"},{\"name\":\"string1\",\"type\":[\"string\",\"null\"]},{\"name\":\"list1\",\"type\":[{\"type\":\"array\",\"items\":\"string\"},\"null\"]},{\"name\":\"map1\",\"type\":[{\"type\":\"map\",\"values\":\"int\"},\"null\"]},{\"name\":\"enum1\",\"type\":[{\"type\":\"enum\",\"name\":\"BJEnum1ValuesSpecific\",\"namespace\":\"com.ctriposs.baiji.specific\",\"doc\":null,\"symbols\":[\"BLUE\",\"RED\",\"GREEN\"]},\"null\"]},{\"name\":\"nullableint\",\"type\":[\"int\",\"null\"]},{\"name\":\"bytes1\",\"type\":[\"bytes\",\"null\"]},{\"name\":\"date1\",\"type\":\"datetime\"}]}}]}]}"] retain];
    });
    return __schema;
}

- (id)initWithSamples:(NSArray *)samples {
    self = [super init];
    if(self) {
        self.samples = samples;
    }
    return self;
}

- (id)fieldAtIndex:(int)fieldPos {
    switch (fieldPos) {
        case 0: return self.samples;
        default:
            [NSException exceptionWithName:BJRuntimeException
                                    reason:[NSString stringWithFormat:@"Bad index %d in fieldAtIndex:", fieldPos]
                                  userInfo:nil];
    }
    return nil;
}

- (void)setObject:(id)object atIndex:(int)fieldPos {
    switch (fieldPos) {
        case 0: self.samples = object; break;
        default:
            [NSException exceptionWithName:BJRuntimeException
                                    reason:[NSString stringWithFormat:@"Bad index %d in fieldAtIndex:", fieldPos]
                                  userInfo:nil];
    }
}

#pragma override NSObject methods

- (BOOL)isEqual:(id)object {
    if (object == nil)
        return NO;
    if ([self class] != [object class])
        return NO;
    BJTestSerializerSampleList *that = (BJTestSerializerSampleList *)object;
    return
    [self.samples isEqualToArray:[that samples]];
}

- (NSUInteger)hash {
    NSUInteger result = 1;
    
    result = 31 * result + (self.samples == nil ? 0 : [self.samples hash]);
    
    return result;
}

- (void)dealloc {
    [self.samples release];
    [super dealloc];
}

@end
