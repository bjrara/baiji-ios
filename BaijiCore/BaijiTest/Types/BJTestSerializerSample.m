//
//  BJTestSerializerSample.m
//  BaijiCore
//
//  Created by user on 14-9-25.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJTestSerializerSample.h"
#import "BJSchema.h"
#import "BJEnum1ValuesSpecific.h"
#import "BJError.h"

@implementation BJTestSerializerSample

+ (BJSchema *)schema {
    static BJSchema *__schema = nil;
    static dispatch_once_t onceCreated;
    dispatch_once(&onceCreated, ^{
        __schema = [BJSchema parse:@"{\"type\":\"record\",\"name\":\"BJTestSerializerSample\",\"namespace\":\"com.ctriposs.baiji.specific\",\"doc\":null,\"fields\":[{\"name\":\"int1\",\"type\":\"int\"},{\"name\":\"tinyint1\",\"type\":\"int\"},{\"name\":\"smallint1\",\"type\":\"int\"},{\"name\":\"bigint1\",\"type\":\"long\"},{\"name\":\"boolean1\",\"type\":\"boolean\"},{\"name\":\"double1\",\"type\":\"double\"},{\"name\":\"string1\",\"type\":[\"string\",\"null\"]},{\"name\":\"list1\",\"type\":[{\"type\":\"array\",\"items\":\"string\"},\"null\"]},{\"name\":\"map1\",\"type\":[{\"type\":\"map\",\"values\":\"int\"},\"null\"]},{\"name\":\"enum1\",\"type\":[{\"type\":\"enum\",\"name\":\"BJEnum1Values\",\"namespace\":\"com.ctriposs.baiji.specific\",\"doc\":null,\"symbols\":[\"BLUE\",\"RED\",\"GREEN\"]},\"null\"]},{\"name\":\"nullableint\",\"type\":[\"int\",\"null\"]},{\"name\":\"bytes1\",\"type\":[\"bytes\",\"null\"]},{\"name\":\"date1\",\"type\":\"datetime\"}]}"];
    });
    return __schema;
}

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
             date1:(NSDate *)date1 {
    self = [super init];
    if (self) {
        _int1 = int1;
        _tinyint1 = tinyint1;
        _smallint1 = smallint1;
        _bigint1 = bigint1;
        _boolean1 = boolean1;
        _double1 = double1;
        _string1 = string1;
        _list1 = list1;
        _map1 = map1;
        _enum1 = enum1;
        _nullableint = nullableint;
        _bytes1 = bytes1;
        _date1 = date1;
    }
    return self;
}

- (id)fieldAtIndex:(int)fieldPos {
    switch (fieldPos) {
        case 0: return self.int1;
        case 1: return self.tinyint1;
        case 2: return self.smallint1;
        case 3: return self.bigint1;
        case 4: return self.boolean1;
        case 5: return self.double1;
        case 6: return self.string1;
        case 7: return self.list1;
        case 8: return self.map1;
        case 9: return self.enum1;
        case 10: return self.nullableint;
        case 11: return self.bytes1;
        case 12: return self.date1;
        default:
            [NSException exceptionWithName:BJRuntimeException
                                    reason:[NSString stringWithFormat:@"Bad index %d in fieldAtIndex:", fieldPos]
                                  userInfo:nil];
    }
    return nil;
}

- (void)setObject:(id)object atIndex:(int)fieldPos {
    switch (fieldPos) {
        case 0: self.int1 = object; break;
        case 1: self.tinyint1 = object; break;
        case 2: self.smallint1 = object; break;
        case 3: self.bigint1 = object; break;
        case 4: self.boolean1 = object; break;
        case 5: self.double1 = object; break;
        case 6: self.string1 = object; break;
        case 7: self.list1 = object; break;
        case 8: self.map1 = object; break;
        case 9: self.enum1 = object; break;
        case 10: self.nullableint = object; break;
        case 11: self.bytes1 = object; break;
        case 12: self.date1 = object; break;
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
    BJTestSerializerSample *that = (BJTestSerializerSample *)object;
    return
    [self.int1 isEqualToNumber:[that int1]] &&
    [self.tinyint1 isEqualToNumber:[that tinyint1]] &&
    [self.smallint1 isEqualToNumber:[that smallint1]] &&
    [self.bigint1 isEqualToNumber:[that bigint1]] &&
    [self.boolean1 isEqualToNumber:[that boolean1]] &&
    [self.double1 isEqualToNumber:[that double1]] &&
    [self.string1 isEqualToString:[that string1]] &&
    [self.list1 isEqual:[that list1]] &&
    [self.map1 isEqual:[that map1]] &&
    [self.enum1 isEqual:[that enum1]] &&
    [self.nullableint isEqual:[that nullableint]] &&
    [self.bytes1 isEqual:[that bytes1]] &&
    [self.date1 isEqual:[that date1]];
}

- (NSUInteger)hash {
    NSUInteger result = 1;
    
    result = 31 * result + (self.int1 == nil ? 0 : [self.int1 hash]);
    result = 31 * result + (self.tinyint1 == nil ? 0 : [self.tinyint1 hash]);
    result = 31 * result + (self.smallint1 == nil ? 0 : [self.smallint1 hash]);
    result = 31 * result + (self.bigint1 == nil ? 0 : [self.bigint1 hash]);
    result = 31 * result + (self.boolean1 == nil ? 0 : [self.boolean1 hash]);
    result = 31 * result + (self.double1 == nil ? 0 : [self.double1 hash]);
    result = 31 * result + (self.string1 == nil ? 0 : [self.string1 hash]);
    result = 31 * result + (self.list1 == nil ? 0 : [self.list1 hash]);
    result = 31 * result + (self.map1 == nil ? 0 : [self.map1 hash]);
    result = 31 * result + (self.enum1 == nil ? 0 : [self.enum1 hash]);
    result = 31 * result + (self.nullableint == nil ? 0 : [self.nullableint hash]);
    result = 31 * result + (self.bytes1 == nil ? 0 : [self.bytes1 hash]);
    result = 31 * result + (self.date1 == nil ? 0 : [self.date1 hash]);
    
    return result;
}

@end