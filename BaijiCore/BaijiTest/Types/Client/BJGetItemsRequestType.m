/**
 * Autogenerated by soa-sdk-toolkit
 *
 * DO NOT EDIT DIRECTLY
 */
#import "BJGetItemsRequestType.h"
#import "BJError.h"
#import "BJMobileRequestHead.h"

@implementation BJGetItemsRequestType

- (BJSchema *)schema {
    static BJSchema *__schema = nil;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
        __schema = [[BJSchema parse:@"{\"type\":\"record\",\"name\":\"BJGetItemsRequestType\",\"namespace\":\"com.ctrip.soa.framework.soa.testservice.v1\",\"fields\":[{\"name\":\"take\",\"type\":[\"int\",\"null\"]},{\"name\":\"sleep\",\"type\":[\"int\",\"null\"]},{\"name\":\"validationString\",\"type\":[\"string\",\"null\"]},{\"name\":\"generateRandomException\",\"type\":[\"boolean\",\"null\"]},{\"name\":\"returnWrappedErrorResponse\",\"type\":[\"boolean\",\"null\"]},{\"name\":\"head\",\"type\":{\"type\":\"record\",\"name\":\"BJMobileRequestHead\",\"namespace\":\"com.ctrip.soa.mobile.common.types.v1\",\"fields\":[{\"name\":\"syscode\",\"type\":[\"string\",\"null\"]},{\"name\":\"lang\",\"type\":[\"string\",\"null\"]},{\"name\":\"auth\",\"type\":[\"string\",\"null\"]},{\"name\":\"cid\",\"type\":[\"string\",\"null\"]},{\"name\":\"ctok\",\"type\":[\"string\",\"null\"]},{\"name\":\"cver\",\"type\":[\"string\",\"null\"]},{\"name\":\"sid\",\"type\":[\"string\",\"null\"]},{\"name\":\"extension\",\"type\":{\"type\":\"array\",\"items\":{\"type\":\"record\",\"name\":\"BJExtensionFieldType\",\"namespace\":\"com.ctrip.soa.mobile.common.types.v1\",\"fields\":[{\"name\":\"name\",\"type\":[\"string\",\"null\"]},{\"name\":\"value\",\"type\":[\"string\",\"null\"]}]}}}]}}]}"] retain];
    });
    return __schema;
}

- (id)initWithTake:(NSNumber *)take
             sleep:(NSNumber *)sleep
  validationString:(NSString *)validationString
generateRandomException:(NSNumber *)generateRandomException
returnWrappedErrorResponse:(NSNumber *)returnWrappedErrorResponse
              head:(BJMobileRequestHead *)head {
    self = [super init];
    if (self) {
        self.take = take;
        self.sleep = sleep;
        self.validationString = validationString;
        self.generateRandomException = generateRandomException;
        self.returnWrappedErrorResponse = returnWrappedErrorResponse;
        self.head = head;
    }
    return self;
}

- (id)fieldAtIndex:(int)fieldPos {
    switch (fieldPos) {
        case 0: return self.take;
        case 1: return self.sleep;
        case 2: return self.validationString;
        case 3: return self.generateRandomException;
        case 4: return self.returnWrappedErrorResponse;
        case 5: return self.head;
        default:
            [NSException exceptionWithName:BJRuntimeException
                                    reason:[NSString stringWithFormat:@"Bad index %d in fieldAtIndex:", fieldPos]
                                  userInfo:nil];
    }
    return nil;
}

- (void)setObject:(id)object atIndex:(int)fieldPos {
    switch (fieldPos) {
        case 0: self.take = object; break;
        case 1: self.sleep = object; break;
        case 2: self.validationString = object; break;
        case 3: self.generateRandomException = object; break;
        case 4: self.returnWrappedErrorResponse = object; break;
        case 5: self.head = object; break;
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
    BJGetItemsRequestType *that = (BJGetItemsRequestType *)object;
    return
    [self.take isEqual:[that take]] &&
    [self.sleep isEqual:[that sleep]] &&
    [self.validationString isEqual:[that validationString]] &&
    [self.generateRandomException isEqual:[that generateRandomException]] &&
    [self.returnWrappedErrorResponse isEqual:[that returnWrappedErrorResponse]] &&
    [self.head isEqual:[that head]];
}

- (NSUInteger)hash {
    NSUInteger result = 1;
    
    result = 31 * result + (self.take == nil ? 0 : [self.take hash]);
    result = 31 * result + (self.sleep == nil ? 0 : [self.sleep hash]);
    result = 31 * result + (self.validationString == nil ? 0 : [self.validationString hash]);
    result = 31 * result + (self.generateRandomException == nil ? 0 : [self.generateRandomException hash]);
    result = 31 * result + (self.returnWrappedErrorResponse == nil ? 0 : [self.returnWrappedErrorResponse hash]);
    result = 31 * result + (self.head == nil ? 0 : [self.head hash]);
    
    return result;
}

- (void)dealloc {
    [self.take release];
    [self.sleep release];
    [self.validationString release];
    [self.generateRandomException release];
    [self.returnWrappedErrorResponse release];
    [self.head release];
    [super dealloc];
}

@end