/**
 * Autogenerated by soa-sdk-toolkit
 *
 * DO NOT EDIT DIRECTLY
 */
#import "BJShippingInfo.h"
#import "BJError.h"
#import "BJAmount.h"

@implementation BJShippingInfo

+ (BJSchema *)schema {
    static BJSchema *__schema = nil;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
        __schema = [[BJSchema parse:@"{\"type\":\"record\",\"name\":\"BJShippingInfo\",\"namespace\":\"com.ctrip.soa.framework.soa.testservice.v1\",\"fields\":[{\"name\":\"shippingServiceCost\",\"type\":{\"type\":\"record\",\"name\":\"BJAmount\",\"namespace\":\"com.ctrip.soa.framework.soa.testservice.v1\",\"fields\":[{\"name\":\"value\",\"type\":[\"double\",\"null\"]},{\"name\":\"currencyId\",\"type\":[\"string\",\"null\"]}]}},{\"name\":\"shippingType\",\"type\":[\"string\",\"null\"]},{\"name\":\"shipToLocations\",\"type\":{\"type\":\"array\",\"items\":[\"string\",\"null\"]}},{\"name\":\"expeditedShipping\",\"type\":[\"boolean\",\"null\"]},{\"name\":\"oneDayShippingAvailable\",\"type\":[\"boolean\",\"null\"]},{\"name\":\"handlingTime\",\"type\":[\"int\",\"null\"]},{\"name\":\"intermediatedShipping\",\"type\":[\"boolean\",\"null\"]}]}"] retain];
    });
    return __schema;
}

- (id)initWithShippingServiceCost:(BJAmount *)shippingServiceCost
                     shippingType:(NSString *)shippingType
                  shipToLocations:(NSArray *)shipToLocations
                expeditedShipping:(NSNumber *)expeditedShipping
          oneDayShippingAvailable:(NSNumber *)oneDayShippingAvailable
                     handlingTime:(NSNumber *)handlingTime
            intermediatedShipping:(NSNumber *)intermediatedShipping {
    self = [super init];
    if (self) {
        _shippingServiceCost = shippingServiceCost;
        _shippingType = shippingType;
        _shipToLocations = shipToLocations;
        _expeditedShipping = expeditedShipping;
        _oneDayShippingAvailable = oneDayShippingAvailable;
        _handlingTime = handlingTime;
        _intermediatedShipping = intermediatedShipping;
    }
    return self;
}

- (id)fieldAtIndex:(int)fieldPos {
    switch (fieldPos) {
        case 0: return self.shippingServiceCost;
        case 1: return self.shippingType;
        case 2: return self.shipToLocations;
        case 3: return self.expeditedShipping;
        case 4: return self.oneDayShippingAvailable;
        case 5: return self.handlingTime;
        case 6: return self.intermediatedShipping;
        default:
            [NSException exceptionWithName:BJRuntimeException
                                    reason:[NSString stringWithFormat:@"Bad index %d in fieldAtIndex:", fieldPos]
                                  userInfo:nil];
    }
    return nil;
}

- (void)setObject:(id)object atIndex:(int)fieldPos {
    switch (fieldPos) {
        case 0: self.shippingServiceCost = object; break;
        case 1: self.shippingType = object; break;
        case 2: self.shipToLocations = object; break;
        case 3: self.expeditedShipping = object; break;
        case 4: self.oneDayShippingAvailable = object; break;
        case 5: self.handlingTime = object; break;
        case 6: self.intermediatedShipping = object; break;
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
    BJShippingInfo *that = (BJShippingInfo *)object;
    return
    [self.shippingServiceCost isEqual:[that shippingServiceCost]] &&
    [self.shippingType isEqual:[that shippingType]] &&
    [self.shipToLocations isEqual:[that shipToLocations]] &&
    [self.expeditedShipping isEqual:[that expeditedShipping]] &&
    [self.oneDayShippingAvailable isEqual:[that oneDayShippingAvailable]] &&
    [self.handlingTime isEqual:[that handlingTime]] &&
    [self.intermediatedShipping isEqual:[that intermediatedShipping]];
}

- (NSUInteger)hash {
    NSUInteger result = 1;
    
    result = 31 * result + (self.shippingServiceCost == nil ? 0 : [self.shippingServiceCost hash]);
    result = 31 * result + (self.shippingType == nil ? 0 : [self.shippingType hash]);
    result = 31 * result + (self.shipToLocations == nil ? 0 : [self.shipToLocations hash]);
    result = 31 * result + (self.expeditedShipping == nil ? 0 : [self.expeditedShipping hash]);
    result = 31 * result + (self.oneDayShippingAvailable == nil ? 0 : [self.oneDayShippingAvailable hash]);
    result = 31 * result + (self.handlingTime == nil ? 0 : [self.handlingTime hash]);
    result = 31 * result + (self.intermediatedShipping == nil ? 0 : [self.intermediatedShipping hash]);
    
    return result;
}

- (void)dealloc {
    [self.shippingServiceCost release];
    [self.shippingType release];
    [self.shipToLocations release];
    [self.expeditedShipping release];
    [self.oneDayShippingAvailable release];
    [self.handlingTime release];
    [self.intermediatedShipping release];
    [super dealloc];
}

@end
