/**
 * Autogenerated by soa-sdk-toolkit
 *
 * DO NOT EDIT DIRECTLY
 */
#import "BJProductId.h"
#import "BJError.h"

@implementation BJProductId

- (BJSchema *)schema {
    static BJSchema *__schema = nil;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
        __schema = [[BJSchema parse:@"{\"type\":\"record\",\"name\":\"BJProductId\",\"namespace\":\"com.ctrip.soa.framework.soa.testservice.v1\",\"fields\":[{\"name\":\"value\",\"type\":[\"string\",\"null\"]},{\"name\":\"type\",\"type\":[\"string\",\"null\"]}]}"] retain];
    });
    return __schema;
}

- (id)initWithValue:(NSString *)value
               type:(NSString *)type {
    self = [super init];
    if (self) {
        self.value = value;
        self.type = type;
    }
    return self;
}

- (id)fieldAtIndex:(int)fieldPos {
    switch (fieldPos) {
        case 0: return self.value;
        case 1: return self.type;
        default:
            [NSException exceptionWithName:BJRuntimeException
                                    reason:[NSString stringWithFormat:@"Bad index %d in fieldAtIndex:", fieldPos]
                                  userInfo:nil];
    }
    return nil;
}

- (void)setObject:(id)object atIndex:(int)fieldPos {
    switch (fieldPos) {
        case 0: self.value = object; break;
        case 1: self.type = object; break;
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
    BJProductId *that = (BJProductId *)object;
    return
    [self.value isEqual:[that value]] &&
    [self.type isEqual:[that type]];
}

- (NSUInteger)hash {
    NSUInteger result = 1;
    
    result = 31 * result + (self.value == nil ? 0 : [self.value hash]);
    result = 31 * result + (self.type == nil ? 0 : [self.type hash]);
    
    return result;
}

- (void)dealloc {
    [self.value release];
    [self.type release];
    [super dealloc];
}

@end