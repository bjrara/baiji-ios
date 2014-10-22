/**
 * Autogenerated by soa-sdk-toolkit
 *
 * DO NOT EDIT DIRECTLY
 */
#import "BJTestSerializerSample.h"
#import "BJError.h"
#import "BJTestSerializerSample.h"
#import "BJEnum1Values.h"
#import "BJRecord2Container.h"
#import "BJRecord.h"

@implementation BJTestSerializerSample

+ (BJSchema *)schema {
    static BJSchema *__schema = nil;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
        __schema = [[BJSchema parse:@"{\"type\":\"record\",\"name\":\"BJTestSerializerSample\",\"namespace\":\"com.ctrip.soa.framework.soa.crosstest.v1\",\"fields\":[{\"name\":\"bigint1\",\"type\":[\"long\",\"null\"]},{\"name\":\"boolean1\",\"type\":[\"boolean\",\"null\"]},{\"name\":\"bytes1\",\"type\":[\"bytes\",\"null\"]},{\"name\":\"container1\",\"type\":{\"type\":\"record\",\"name\":\"BJRecord2Container\",\"namespace\":\"com.ctrip.soa.framework.soa.crosstest.v1\",\"fields\":[{\"name\":\"record2List\",\"type\":{\"type\":\"array\",\"items\":{\"type\":\"record\",\"name\":\"BJRecord2\",\"namespace\":\"com.ctrip.soa.framework.soa.crosstest.v1\",\"fields\":[{\"name\":\"bigint2\",\"type\":[\"long\",\"null\"]},{\"name\":\"byteslist\",\"type\":{\"type\":\"array\",\"items\":[\"bytes\",\"null\"]}},{\"name\":\"enum2\",\"type\":[{\"type\":\"enum\",\"name\":\"BJEnum2Values\",\"namespace\":\"com.ctrip.soa.framework.soa.crosstest.v1\",\"symbols\":[\"CAR\",\"BIKE\",\"PLANE\"]},\"null\"]},{\"name\":\"filling\",\"type\":{\"type\":\"record\",\"name\":\"BJModelFilling\",\"namespace\":\"com.ctrip.soa.framework.soa.crosstest.v1\",\"fields\":[{\"name\":\"boolfilling\",\"type\":[\"boolean\",\"null\"]},{\"name\":\"enumfilling\",\"type\":[{\"type\":\"enum\",\"name\":\"BJEnum1Values\",\"namespace\":\"com.ctrip.soa.framework.soa.crosstest.v1\",\"symbols\":[\"BLUE\",\"RED\",\"GREEN\"]},\"null\"]},{\"name\":\"intfilling\",\"type\":[\"int\",\"null\"]},{\"name\":\"modelfilling\",\"type\":{\"type\":\"record\",\"name\":\"BJModelFilling2\",\"namespace\":\"com.ctrip.soa.framework.soa.crosstest.v1\",\"fields\":[{\"name\":\"enumfilling\",\"type\":[\"BJEnum2Values\",\"null\"]},{\"name\":\"listfilling\",\"type\":{\"type\":\"array\",\"items\":[\"string\",\"null\"]}},{\"name\":\"longfilling\",\"type\":[\"long\",\"null\"]},{\"name\":\"stringfilling\",\"type\":[\"string\",\"null\"]}]}},{\"name\":\"stringfilling1\",\"type\":[\"string\",\"null\"]},{\"name\":\"stringfilling2\",\"type\":[\"string\",\"null\"]},{\"name\":\"stringfilling3\",\"type\":[\"string\",\"null\"]},{\"name\":\"stringfilling4\",\"type\":[\"string\",\"null\"]}]}},{\"name\":\"list2\",\"type\":{\"type\":\"array\",\"items\":[\"int\",\"null\"]}},{\"name\":\"nullablebigint\",\"type\":[\"long\",\"null\"]},{\"name\":\"map2\",\"type\":[{\"type\":\"map\",\"values\":{\"type\":\"record\",\"name\":\"BJRecord\",\"namespace\":\"com.ctrip.soa.framework.soa.crosstest.v1\",\"fields\":[{\"name\":\"sBoolean\",\"type\":[\"boolean\",\"null\"]},{\"name\":\"sInt\",\"type\":[\"int\",\"null\"]},{\"name\":\"sString\",\"type\":[\"string\",\"null\"]}]}},\"null\"]}]}}}]}},{\"name\":\"date1\",\"type\":[\"datetime\",\"null\"]},{\"name\":\"double1\",\"type\":[\"double\",\"null\"]},{\"name\":\"enum1\",\"type\":[\"BJEnum1Values\",\"null\"]},{\"name\":\"innerSample\",\"type\":\"BJTestSerializerSample\"},{\"name\":\"int1\",\"type\":[\"int\",\"null\"]},{\"name\":\"list1\",\"type\":{\"type\":\"array\",\"items\":[\"string\",\"null\"]}},{\"name\":\"nullableint\",\"type\":[\"int\",\"null\"]},{\"name\":\"record\",\"type\":{\"type\":\"record\",\"name\":\"BJRecord\",\"namespace\":\"com.ctrip.soa.framework.soa.crosstest.v1\",\"fields\":[{\"name\":\"sBoolean\",\"type\":[\"boolean\",\"null\"]},{\"name\":\"sInt\",\"type\":[\"int\",\"null\"]},{\"name\":\"sString\",\"type\":[\"string\",\"null\"]}]}},{\"name\":\"smallint1\",\"type\":[\"int\",\"null\"]},{\"name\":\"string1\",\"type\":[\"string\",\"null\"]},{\"name\":\"tinyint1\",\"type\":[\"int\",\"null\"]},{\"name\":\"map1\",\"type\":[{\"type\":\"map\",\"values\":\"int\"},\"null\"]}]}"] retain];
    });
    return __schema;
}

- (id)initWithBigint1:(NSNumber *)bigint1
             boolean1:(NSNumber *)boolean1
               bytes1:(NSData *)bytes1
           container1:(BJRecord2Container *)container1
                date1:(NSDate *)date1
              double1:(NSNumber *)double1
                enum1:(BJEnum1Values *)enum1
          innerSample:(BJTestSerializerSample *)innerSample
                 int1:(NSNumber *)int1
                list1:(NSArray *)list1
          nullableint:(NSNumber *)nullableint
               record:(BJRecord *)record
            smallint1:(NSNumber *)smallint1
              string1:(NSString *)string1
             tinyint1:(NSNumber *)tinyint1
                 map1:(NSDictionary *)map1{
    self = [super init];
    if (self) {
        self.bigint1 = bigint1;
        self.boolean1 = boolean1;
        self.bytes1 = bytes1;
        self.container1 = container1;
        self.date1 = date1;
        self.double1 = double1;
        self.enum1 = enum1;
        self.innerSample = innerSample;
        self.int1 = int1;
        self.list1 = list1;
        self.nullableint = nullableint;
        self.record = record;
        self.smallint1 = smallint1;
        self.string1 = string1;
        self.tinyint1 = tinyint1;
        self.map1 = map1;
    }
    return self;
}

- (id)fieldAtIndex:(int)fieldPos {
    switch (fieldPos) {
        case 0: return self.bigint1; break;
        case 1: return self.boolean1; break;
        case 2: return self.bytes1; break;
        case 3: return self.container1; break;
        case 4: return self.date1; break;
        case 5: return self.double1; break;
        case 6: return self.enum1; break;
        case 7: return self.innerSample; break;
        case 8: return self.int1; break;
        case 9: return self.list1; break;
        case 10: return self.nullableint; break;
        case 11: return self.record; break;
        case 12: return self.smallint1; break;
        case 13: return self.string1; break;
        case 14: return self.tinyint1; break;
        case 15: return self.map1; break;
        default:
            [NSException exceptionWithName:BJRuntimeException
                                    reason:[NSString stringWithFormat:@"Bad index %d in fieldAtIndex:", fieldPos]
                                  userInfo:nil];
    }
    return nil;
}

- (void)setObject:(id)object atIndex:(int)fieldPos {
    switch (fieldPos) {
        case 0: self.bigint1 = object; break;
        case 1: self.boolean1 = object; break;
        case 2: self.bytes1 = object; break;
        case 3: self.container1 = object; break;
        case 4: self.date1 = object; break;
        case 5: self.double1 = object; break;
        case 6: self.enum1 = object; break;
        case 7: self.innerSample = object; break;
        case 8: self.int1 = object; break;
        case 9: self.list1 = object; break;
        case 10: self.nullableint = object; break;
        case 11: self.record = object; break;
        case 12: self.smallint1 = object; break;
        case 13: self.string1 = object; break;
        case 14: self.tinyint1 = object; break;
        case 15: self.map1 = object; break;
        default:
            [NSException exceptionWithName:BJRuntimeException
                                    reason:[NSString stringWithFormat:@"Bad index %d in setObject:atIndex:", fieldPos]
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
    [self.bigint1 isEqual:[that bigint1]] &&
    [self.boolean1 isEqual:[that boolean1]] &&
    [self.bytes1 isEqual:[that bytes1]] &&
    [self.container1 isEqual:[that container1]] &&
    [self.date1 isEqual:[that date1]] &&
    [self.double1 isEqual:[that double1]] &&
    [self.enum1 isEqual:[that enum1]] &&
    [self.innerSample isEqual:[that innerSample]] &&
    [self.int1 isEqual:[that int1]] &&
    [self.list1 isEqual:[that list1]] &&
    [self.nullableint isEqual:[that nullableint]] &&
    [self.record isEqual:[that record]] &&
    [self.smallint1 isEqual:[that smallint1]] &&
    [self.string1 isEqual:[that string1]] &&
    [self.tinyint1 isEqual:[that tinyint1]] &&
    [self.map1 isEqual:[that map1]];
}

- (NSUInteger)hash {
    NSUInteger result = 1;
    
    result = 31 * result + (self.bigint1 == nil ? 0 : [self.bigint1 hash]);
    result = 31 * result + (self.boolean1 == nil ? 0 : [self.boolean1 hash]);
    result = 31 * result + (self.bytes1 == nil ? 0 : [self.bytes1 hash]);
    result = 31 * result + (self.container1 == nil ? 0 : [self.container1 hash]);
    result = 31 * result + (self.date1 == nil ? 0 : [self.date1 hash]);
    result = 31 * result + (self.double1 == nil ? 0 : [self.double1 hash]);
    result = 31 * result + (self.enum1 == nil ? 0 : [self.enum1 hash]);
    result = 31 * result + (self.innerSample == nil ? 0 : [self.innerSample hash]);
    result = 31 * result + (self.int1 == nil ? 0 : [self.int1 hash]);
    result = 31 * result + (self.list1 == nil ? 0 : [self.list1 hash]);
    result = 31 * result + (self.nullableint == nil ? 0 : [self.nullableint hash]);
    result = 31 * result + (self.record == nil ? 0 : [self.record hash]);
    result = 31 * result + (self.smallint1 == nil ? 0 : [self.smallint1 hash]);
    result = 31 * result + (self.string1 == nil ? 0 : [self.string1 hash]);
    result = 31 * result + (self.tinyint1 == nil ? 0 : [self.tinyint1 hash]);
    result = 31 * result + (self.map1 == nil ? 0 : [self.map1 hash]);
    
    return result;
}

- (void)dealloc {
    [self.bigint1 release];
    [self.boolean1 release];
    [self.bytes1 release];
    [self.container1 release];
    [self.date1 release];
    [self.double1 release];
    [self.enum1 release];
    [self.innerSample release];
    [self.int1 release];
    [self.list1 release];
    [self.nullableint release];
    [self.record release];
    [self.smallint1 release];
    [self.string1 release];
    [self.tinyint1 release];
    [self.map1 release];
    [super dealloc];
}

@end