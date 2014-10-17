/**
 * Autogenerated by soa-sdk-toolkit
 *
 * DO NOT EDIT DIRECTLY
 */
#import <Foundation/Foundation.h>
#import "BJMutableSpecificRecord.h"
@class BJAmount;

@interface BJShippingInfo : BJMutableSpecificRecord

@property (nonatomic, readwrite, retain) BJAmount *shippingServiceCost;
@property (nonatomic, readwrite, retain) NSString *shippingType;
@property (nonatomic, readwrite, retain) NSArray *shipToLocations;
/** initValue: bool */
@property (nonatomic, readwrite, retain) NSNumber *expeditedShipping;
/** initValue: bool */
@property (nonatomic, readwrite, retain) NSNumber *oneDayShippingAvailable;
/** initValue: int */
@property (nonatomic, readwrite, retain) NSNumber *handlingTime;
/** initValue: bool */
@property (nonatomic, readwrite, retain) NSNumber *intermediatedShipping;

- (id)initWithShippingServiceCost:(BJAmount *)shippingServiceCost
                     shippingType:(NSString *)shippingType
                  shipToLocations:(NSArray *)shipToLocations
                expeditedShipping:(NSNumber *)expeditedShipping
          oneDayShippingAvailable:(NSNumber *)oneDayShippingAvailable
                     handlingTime:(NSNumber *)handlingTime
            intermediatedShipping:(NSNumber *)intermediatedShipping;

@end