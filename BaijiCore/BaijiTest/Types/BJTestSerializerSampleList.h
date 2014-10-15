//
//  BJTestSerializerSampleList.h
//  BaijiCore
//
//  Created by zmy周梦伊 on 10/15/14.
//  Copyright (c) 2014 ctriposs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJMutableSpecificRecord.h"

@interface BJTestSerializerSampleList : BJMutableSpecificRecord

@property (nonatomic, readwrite, retain) NSArray *samples;

- (id)initWithSamples:(NSArray *)samples;

@end
