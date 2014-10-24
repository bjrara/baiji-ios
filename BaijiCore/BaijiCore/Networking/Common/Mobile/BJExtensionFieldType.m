/**
 * Autogenerated by soa-sdk-toolkit
 *
 * DO NOT EDIT DIRECTLY
 */
#import "BJExtensionFieldType.h"
#import "BJError.h"

@implementation BJExtensionFieldType

- (BJSchema *)schema {
    static BJSchema *__schema = nil;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
        __schema = [[BJSchema parse:@"{\"type\":\"record\",\"name\":\"BJExtensionFieldType\",\"namespace\":\"com.ctrip.soa.mobile.common.types.v1\",\"fields\":[{\"name\":\"name\",\"type\":[\"string\",\"null\"]},{\"name\":\"value\",\"type\":[\"string\",\"null\"]}]}"] retain];
    });
    return __schema;
}

- (id)initWithName:(NSString *)name
             value:(NSString *)value {
    self = [super init];
    if (self) {
        self.name = name;
        self.value = value;
    }
    return self;
}

- (id)fieldAtIndex:(int)fieldPos {
    switch (fieldPos) {
        case 0: return self.name;
        case 1: return self.value;
        default:
            [NSException exceptionWithName:BJRuntimeException
                                    reason:[NSString stringWithFormat:@"Bad index %d in fieldAtIndex:", fieldPos]
                                  userInfo:nil];
    }
    return nil;
}

- (void)setObject:(id)object atIndex:(int)fieldPos {
    switch (fieldPos) {
        case 0: self.name = object; break;
        case 1: self.value = object; break;
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
    BJExtensionFieldType *that = (BJExtensionFieldType *)object;
    return
    [self.name isEqual:[that name]] &&
    [self.value isEqual:[that value]];
}

- (NSUInteger)hash {
    NSUInteger result = 1;
    
    result = 31 * result + (self.name == nil ? 0 : [self.name hash]);
    result = 31 * result + (self.value == nil ? 0 : [self.value hash]);
    
    return result;
}

- (void)dealloc {
    [self.name release];
    [self.value release];
    [super dealloc];
}

@end
