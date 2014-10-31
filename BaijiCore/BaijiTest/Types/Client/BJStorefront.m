/**
 * Autogenerated by soa-sdk-toolkit
 *
 * DO NOT EDIT DIRECTLY
 */
#import "BJStorefront.h"
#import "BJError.h"

@implementation BJStorefront

- (BJSchema *)schema {
    static BJSchema *__schema = nil;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
        __schema = [[BJSchema parse:@"{\"type\":\"record\",\"name\":\"BJStorefront\",\"namespace\":\"com.ctrip.soa.framework.soa.testservice.v1\",\"fields\":[{\"name\":\"storeName\",\"type\":[\"string\",\"null\"]},{\"name\":\"storeURL\",\"type\":[\"string\",\"null\"]}]}"] retain];
    });
    return __schema;
}

- (id)initWithStoreName:(NSString *)storeName
               storeURL:(NSString *)storeURL {
    self = [super init];
    if (self) {
        self.storeName = storeName;
        self.storeURL = storeURL;
    }
    return self;
}

- (id)fieldAtIndex:(int)fieldPos {
    switch (fieldPos) {
        case 0: return self.storeName;
        case 1: return self.storeURL;
        default:
            [NSException exceptionWithName:BJRuntimeException
                                    reason:[NSString stringWithFormat:@"Bad index %d in fieldAtIndex:", fieldPos]
                                  userInfo:nil];
    }
    return nil;
}

- (void)setObject:(id)object atIndex:(int)fieldPos {
    switch (fieldPos) {
        case 0: self.storeName = object; break;
        case 1: self.storeURL = object; break;
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
    BJStorefront *that = (BJStorefront *)object;
    return
    [self.storeName isEqual:[that storeName]] &&
    [self.storeURL isEqual:[that storeURL]];
}

- (NSUInteger)hash {
    NSUInteger result = 1;
    
    result = 31 * result + (self.storeName == nil ? 0 : [self.storeName hash]);
    result = 31 * result + (self.storeURL == nil ? 0 : [self.storeURL hash]);
    
    return result;
}

- (void)dealloc {
    [self.storeName release];
    [self.storeURL release];
    [super dealloc];
}

@end