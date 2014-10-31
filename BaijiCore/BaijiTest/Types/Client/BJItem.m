/**
 * Autogenerated by soa-sdk-toolkit
 *
 * DO NOT EDIT DIRECTLY
 */
#import "BJItem.h"
#import "BJError.h"
#import "BJProductId.h"
#import "BJDiscountPriceInfo.h"
#import "BJStorefront.h"
#import "BJGalleryURL.h"
#import "BJSellingStatus.h"
#import "BJSellerInfo.h"
#import "BJDistance.h"
#import "BJCondition.h"
#import "BJShippingInfo.h"
#import "BJUnitPriceInfo.h"
#import "BJCategory.h"
#import "BJListingInfo.h"

@implementation BJItem

- (BJSchema *)schema {
    static BJSchema *__schema = nil;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
        __schema = [[BJSchema parse:@"{\"type\":\"record\",\"name\":\"BJItem\",\"namespace\":\"com.ctrip.soa.framework.soa.testservice.v1\",\"fields\":[{\"name\":\"itemId\",\"type\":[\"string\",\"null\"]},{\"name\":\"title\",\"type\":[\"string\",\"null\"]},{\"name\":\"globalId\",\"type\":[\"string\",\"null\"]},{\"name\":\"subtitle\",\"type\":[\"string\",\"null\"]},{\"name\":\"primaryCategory\",\"type\":{\"type\":\"record\",\"name\":\"BJCategory\",\"namespace\":\"com.ctrip.soa.framework.soa.testservice.v1\",\"fields\":[{\"name\":\"categoryId\",\"type\":[\"string\",\"null\"]},{\"name\":\"categoryName\",\"type\":[\"string\",\"null\"]}]}},{\"name\":\"secondaryCategory\",\"type\":\"BJCategory\"},{\"name\":\"galleryURL\",\"type\":[\"string\",\"null\"]},{\"name\":\"galleryInfoContainer\",\"type\":{\"type\":\"array\",\"items\":{\"type\":\"record\",\"name\":\"BJGalleryURL\",\"namespace\":\"com.ctrip.soa.framework.soa.testservice.v1\",\"fields\":[{\"name\":\"value\",\"type\":[\"string\",\"null\"]},{\"name\":\"gallerySize\",\"type\":[{\"type\":\"enum\",\"name\":\"BJGallerySizeEnum\",\"namespace\":\"com.ctrip.soa.framework.soa.testservice.v1\",\"symbols\":[\"SMALL\",\"MEDIUM\",\"LARGE\"]},\"null\"]}]}}},{\"name\":\"viewItemURL\",\"type\":[\"string\",\"null\"]},{\"name\":\"charityId\",\"type\":[\"string\",\"null\"]},{\"name\":\"productId\",\"type\":{\"type\":\"record\",\"name\":\"BJProductId\",\"namespace\":\"com.ctrip.soa.framework.soa.testservice.v1\",\"fields\":[{\"name\":\"value\",\"type\":[\"string\",\"null\"]},{\"name\":\"type\",\"type\":[\"string\",\"null\"]}]}},{\"name\":\"paymentMethod\",\"type\":{\"type\":\"array\",\"items\":[\"string\",\"null\"]}},{\"name\":\"autoPay\",\"type\":[\"boolean\",\"null\"]},{\"name\":\"postalCode\",\"type\":[\"string\",\"null\"]},{\"name\":\"location\",\"type\":[\"string\",\"null\"]},{\"name\":\"country\",\"type\":[\"string\",\"null\"]},{\"name\":\"storeInfo\",\"type\":{\"type\":\"record\",\"name\":\"BJStorefront\",\"namespace\":\"com.ctrip.soa.framework.soa.testservice.v1\",\"fields\":[{\"name\":\"storeName\",\"type\":[\"string\",\"null\"]},{\"name\":\"storeURL\",\"type\":[\"string\",\"null\"]}]}},{\"name\":\"sellerInfo\",\"type\":{\"type\":\"record\",\"name\":\"BJSellerInfo\",\"namespace\":\"com.ctrip.soa.framework.soa.testservice.v1\",\"fields\":[{\"name\":\"sellerUserName\",\"type\":[\"string\",\"null\"]},{\"name\":\"feedbackScore\",\"type\":[\"long\",\"null\"]},{\"name\":\"positiveFeedbackPercent\",\"type\":[\"double\",\"null\"]},{\"name\":\"feedbackRatingStar\",\"type\":[\"string\",\"null\"]},{\"name\":\"topRatedSeller\",\"type\":[\"boolean\",\"null\"]}]}},{\"name\":\"shippingInfo\",\"type\":{\"type\":\"record\",\"name\":\"BJShippingInfo\",\"namespace\":\"com.ctrip.soa.framework.soa.testservice.v1\",\"fields\":[{\"name\":\"shippingServiceCost\",\"type\":{\"type\":\"record\",\"name\":\"BJAmount\",\"namespace\":\"com.ctrip.soa.framework.soa.testservice.v1\",\"fields\":[{\"name\":\"value\",\"type\":[\"double\",\"null\"]},{\"name\":\"currencyId\",\"type\":[\"string\",\"null\"]}]}},{\"name\":\"shippingType\",\"type\":[\"string\",\"null\"]},{\"name\":\"shipToLocations\",\"type\":{\"type\":\"array\",\"items\":[\"string\",\"null\"]}},{\"name\":\"expeditedShipping\",\"type\":[\"boolean\",\"null\"]},{\"name\":\"oneDayShippingAvailable\",\"type\":[\"boolean\",\"null\"]},{\"name\":\"handlingTime\",\"type\":[\"int\",\"null\"]},{\"name\":\"intermediatedShipping\",\"type\":[\"boolean\",\"null\"]}]}},{\"name\":\"sellingStatus\",\"type\":{\"type\":\"record\",\"name\":\"BJSellingStatus\",\"namespace\":\"com.ctrip.soa.framework.soa.testservice.v1\",\"fields\":[{\"name\":\"currentPrice\",\"type\":\"BJAmount\"},{\"name\":\"convertedCurrentPrice\",\"type\":\"BJAmount\"},{\"name\":\"bidCount\",\"type\":[\"int\",\"null\"]},{\"name\":\"sellingState\",\"type\":[\"string\",\"null\"]},{\"name\":\"timeLeft\",\"type\":[\"string\",\"null\"]}]}},{\"name\":\"listingInfo\",\"type\":{\"type\":\"record\",\"name\":\"BJListingInfo\",\"namespace\":\"com.ctrip.soa.framework.soa.testservice.v1\",\"fields\":[{\"name\":\"bestOfferEnabled\",\"type\":[\"boolean\",\"null\"]},{\"name\":\"buyItNowAvailable\",\"type\":[\"boolean\",\"null\"]},{\"name\":\"buyItNowPrice\",\"type\":\"BJAmount\"},{\"name\":\"convertedBuyItNowPrice\",\"type\":\"BJAmount\"},{\"name\":\"startTime\",\"type\":[\"datetime\",\"null\"]},{\"name\":\"endTime\",\"type\":[\"datetime\",\"null\"]},{\"name\":\"listingType\",\"type\":[\"string\",\"null\"]},{\"name\":\"gift\",\"type\":[\"boolean\",\"null\"]}]}},{\"name\":\"returnsAccepted\",\"type\":[\"boolean\",\"null\"]},{\"name\":\"galleryPlusPictureURL\",\"type\":{\"type\":\"array\",\"items\":[\"string\",\"null\"]}},{\"name\":\"compatibility\",\"type\":[\"string\",\"null\"]},{\"name\":\"distance\",\"type\":{\"type\":\"record\",\"name\":\"BJDistance\",\"namespace\":\"com.ctrip.soa.framework.soa.testservice.v1\",\"fields\":[{\"name\":\"value\",\"type\":[\"double\",\"null\"]},{\"name\":\"unit\",\"type\":[\"string\",\"null\"]}]}},{\"name\":\"condition\",\"type\":{\"type\":\"record\",\"name\":\"BJCondition\",\"namespace\":\"com.ctrip.soa.framework.soa.testservice.v1\",\"fields\":[{\"name\":\"conditionId\",\"type\":[\"int\",\"null\"]},{\"name\":\"conditionDisplayName\",\"type\":[\"string\",\"null\"]}]}},{\"name\":\"isMultiVariationListing\",\"type\":[\"boolean\",\"null\"]},{\"name\":\"discountPriceInfo\",\"type\":{\"type\":\"record\",\"name\":\"BJDiscountPriceInfo\",\"namespace\":\"com.ctrip.soa.framework.soa.testservice.v1\",\"fields\":[{\"name\":\"originalRetailPrice\",\"type\":\"BJAmount\"},{\"name\":\"minimunAdvertisedPriceExposure\",\"type\":[{\"type\":\"enum\",\"name\":\"BJMapExposureEnum\",\"namespace\":\"com.ctrip.soa.framework.soa.testservice.v1\",\"symbols\":[\"PRE_CHECKOUT\",\"DURING_CHECKOUT\"]},\"null\"]},{\"name\":\"pricingTreatment\",\"type\":[{\"type\":\"enum\",\"name\":\"BJPriceTreatmentEnum\",\"namespace\":\"com.ctrip.soa.framework.soa.testservice.v1\",\"symbols\":[\"STP\",\"MAP\"]},\"null\"]},{\"name\":\"soldOnEbay\",\"type\":[\"boolean\",\"null\"]},{\"name\":\"soldOffEbay\",\"type\":[\"boolean\",\"null\"]}]}},{\"name\":\"pictureURLSuperSize\",\"type\":[\"string\",\"null\"]},{\"name\":\"pictureURLLarge\",\"type\":[\"string\",\"null\"]},{\"name\":\"unitPrice\",\"type\":{\"type\":\"record\",\"name\":\"BJUnitPriceInfo\",\"namespace\":\"com.ctrip.soa.framework.soa.testservice.v1\",\"fields\":[{\"name\":\"type\",\"type\":[\"string\",\"null\"]},{\"name\":\"quantity\",\"type\":[\"double\",\"null\"]}]}},{\"name\":\"topRatedListing\",\"type\":[\"boolean\",\"null\"]}]}"] retain];
    });
    return __schema;
}

- (id)initWithItemId:(NSString *)itemId
               title:(NSString *)title
            globalId:(NSString *)globalId
            subtitle:(NSString *)subtitle
     primaryCategory:(BJCategory *)primaryCategory
   secondaryCategory:(BJCategory *)secondaryCategory
          galleryURL:(NSString *)galleryURL
galleryInfoContainer:(NSArray *)galleryInfoContainer
         viewItemURL:(NSString *)viewItemURL
           charityId:(NSString *)charityId
           productId:(BJProductId *)productId
       paymentMethod:(NSArray *)paymentMethod
             autoPay:(NSNumber *)autoPay
          postalCode:(NSString *)postalCode
            location:(NSString *)location
             country:(NSString *)country
           storeInfo:(BJStorefront *)storeInfo
          sellerInfo:(BJSellerInfo *)sellerInfo
        shippingInfo:(BJShippingInfo *)shippingInfo
       sellingStatus:(BJSellingStatus *)sellingStatus
         listingInfo:(BJListingInfo *)listingInfo
     returnsAccepted:(NSNumber *)returnsAccepted
galleryPlusPictureURL:(NSArray *)galleryPlusPictureURL
       compatibility:(NSString *)compatibility
            distance:(BJDistance *)distance
           condition:(BJCondition *)condition
isMultiVariationListing:(NSNumber *)isMultiVariationListing
   discountPriceInfo:(BJDiscountPriceInfo *)discountPriceInfo
 pictureURLSuperSize:(NSString *)pictureURLSuperSize
     pictureURLLarge:(NSString *)pictureURLLarge
           unitPrice:(BJUnitPriceInfo *)unitPrice
     topRatedListing:(NSNumber *)topRatedListing {
    self = [super init];
    if (self) {
        self.itemId = itemId;
        self.title = title;
        self.globalId = globalId;
        self.subtitle = subtitle;
        self.primaryCategory = primaryCategory;
        self.secondaryCategory = secondaryCategory;
        self.galleryURL = galleryURL;
        self.galleryInfoContainer = galleryInfoContainer;
        self.viewItemURL = viewItemURL;
        self.charityId = charityId;
        self.productId = productId;
        self.paymentMethod = paymentMethod;
        self.autoPay = autoPay;
        self.postalCode = postalCode;
        self.location = location;
        self.country = country;
        self.storeInfo = storeInfo;
        self.sellerInfo = sellerInfo;
        self.shippingInfo = shippingInfo;
        self.sellingStatus = sellingStatus;
        self.listingInfo = listingInfo;
        self.returnsAccepted = returnsAccepted;
        self.galleryPlusPictureURL = galleryPlusPictureURL;
        self.compatibility = compatibility;
        self.distance = distance;
        self.condition = condition;
        self.isMultiVariationListing = isMultiVariationListing;
        self.discountPriceInfo = discountPriceInfo;
        self.pictureURLSuperSize = pictureURLSuperSize;
        self.pictureURLLarge = pictureURLLarge;
        self.unitPrice = unitPrice;
        self.topRatedListing = topRatedListing;
    }
    return self;
}

- (id)fieldAtIndex:(int)fieldPos {
    switch (fieldPos) {
        case 0: return self.itemId;
        case 1: return self.title;
        case 2: return self.globalId;
        case 3: return self.subtitle;
        case 4: return self.primaryCategory;
        case 5: return self.secondaryCategory;
        case 6: return self.galleryURL;
        case 7: return self.galleryInfoContainer;
        case 8: return self.viewItemURL;
        case 9: return self.charityId;
        case 10: return self.productId;
        case 11: return self.paymentMethod;
        case 12: return self.autoPay;
        case 13: return self.postalCode;
        case 14: return self.location;
        case 15: return self.country;
        case 16: return self.storeInfo;
        case 17: return self.sellerInfo;
        case 18: return self.shippingInfo;
        case 19: return self.sellingStatus;
        case 20: return self.listingInfo;
        case 21: return self.returnsAccepted;
        case 22: return self.galleryPlusPictureURL;
        case 23: return self.compatibility;
        case 24: return self.distance;
        case 25: return self.condition;
        case 26: return self.isMultiVariationListing;
        case 27: return self.discountPriceInfo;
        case 28: return self.pictureURLSuperSize;
        case 29: return self.pictureURLLarge;
        case 30: return self.unitPrice;
        case 31: return self.topRatedListing;
        default:
            [NSException exceptionWithName:BJRuntimeException
                                    reason:[NSString stringWithFormat:@"Bad index %d in fieldAtIndex:", fieldPos]
                                  userInfo:nil];
    }
    return nil;
}

- (void)setObject:(id)object atIndex:(int)fieldPos {
    switch (fieldPos) {
        case 0: self.itemId = object; break;
        case 1: self.title = object; break;
        case 2: self.globalId = object; break;
        case 3: self.subtitle = object; break;
        case 4: self.primaryCategory = object; break;
        case 5: self.secondaryCategory = object; break;
        case 6: self.galleryURL = object; break;
        case 7: self.galleryInfoContainer = object; break;
        case 8: self.viewItemURL = object; break;
        case 9: self.charityId = object; break;
        case 10: self.productId = object; break;
        case 11: self.paymentMethod = object; break;
        case 12: self.autoPay = object; break;
        case 13: self.postalCode = object; break;
        case 14: self.location = object; break;
        case 15: self.country = object; break;
        case 16: self.storeInfo = object; break;
        case 17: self.sellerInfo = object; break;
        case 18: self.shippingInfo = object; break;
        case 19: self.sellingStatus = object; break;
        case 20: self.listingInfo = object; break;
        case 21: self.returnsAccepted = object; break;
        case 22: self.galleryPlusPictureURL = object; break;
        case 23: self.compatibility = object; break;
        case 24: self.distance = object; break;
        case 25: self.condition = object; break;
        case 26: self.isMultiVariationListing = object; break;
        case 27: self.discountPriceInfo = object; break;
        case 28: self.pictureURLSuperSize = object; break;
        case 29: self.pictureURLLarge = object; break;
        case 30: self.unitPrice = object; break;
        case 31: self.topRatedListing = object; break;
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
    BJItem *that = (BJItem *)object;
    return
    [self.itemId isEqual:[that itemId]] &&
    [self.title isEqual:[that title]] &&
    [self.globalId isEqual:[that globalId]] &&
    [self.subtitle isEqual:[that subtitle]] &&
    [self.primaryCategory isEqual:[that primaryCategory]] &&
    [self.secondaryCategory isEqual:[that secondaryCategory]] &&
    [self.galleryURL isEqual:[that galleryURL]] &&
    [self.galleryInfoContainer isEqual:[that galleryInfoContainer]] &&
    [self.viewItemURL isEqual:[that viewItemURL]] &&
    [self.charityId isEqual:[that charityId]] &&
    [self.productId isEqual:[that productId]] &&
    [self.paymentMethod isEqual:[that paymentMethod]] &&
    [self.autoPay isEqual:[that autoPay]] &&
    [self.postalCode isEqual:[that postalCode]] &&
    [self.location isEqual:[that location]] &&
    [self.country isEqual:[that country]] &&
    [self.storeInfo isEqual:[that storeInfo]] &&
    [self.sellerInfo isEqual:[that sellerInfo]] &&
    [self.shippingInfo isEqual:[that shippingInfo]] &&
    [self.sellingStatus isEqual:[that sellingStatus]] &&
    [self.listingInfo isEqual:[that listingInfo]] &&
    [self.returnsAccepted isEqual:[that returnsAccepted]] &&
    [self.galleryPlusPictureURL isEqual:[that galleryPlusPictureURL]] &&
    [self.compatibility isEqual:[that compatibility]] &&
    [self.distance isEqual:[that distance]] &&
    [self.condition isEqual:[that condition]] &&
    [self.isMultiVariationListing isEqual:[that isMultiVariationListing]] &&
    [self.discountPriceInfo isEqual:[that discountPriceInfo]] &&
    [self.pictureURLSuperSize isEqual:[that pictureURLSuperSize]] &&
    [self.pictureURLLarge isEqual:[that pictureURLLarge]] &&
    [self.unitPrice isEqual:[that unitPrice]] &&
    [self.topRatedListing isEqual:[that topRatedListing]];
}

- (NSUInteger)hash {
    NSUInteger result = 1;
    
    result = 31 * result + (self.itemId == nil ? 0 : [self.itemId hash]);
    result = 31 * result + (self.title == nil ? 0 : [self.title hash]);
    result = 31 * result + (self.globalId == nil ? 0 : [self.globalId hash]);
    result = 31 * result + (self.subtitle == nil ? 0 : [self.subtitle hash]);
    result = 31 * result + (self.primaryCategory == nil ? 0 : [self.primaryCategory hash]);
    result = 31 * result + (self.secondaryCategory == nil ? 0 : [self.secondaryCategory hash]);
    result = 31 * result + (self.galleryURL == nil ? 0 : [self.galleryURL hash]);
    result = 31 * result + (self.galleryInfoContainer == nil ? 0 : [self.galleryInfoContainer hash]);
    result = 31 * result + (self.viewItemURL == nil ? 0 : [self.viewItemURL hash]);
    result = 31 * result + (self.charityId == nil ? 0 : [self.charityId hash]);
    result = 31 * result + (self.productId == nil ? 0 : [self.productId hash]);
    result = 31 * result + (self.paymentMethod == nil ? 0 : [self.paymentMethod hash]);
    result = 31 * result + (self.autoPay == nil ? 0 : [self.autoPay hash]);
    result = 31 * result + (self.postalCode == nil ? 0 : [self.postalCode hash]);
    result = 31 * result + (self.location == nil ? 0 : [self.location hash]);
    result = 31 * result + (self.country == nil ? 0 : [self.country hash]);
    result = 31 * result + (self.storeInfo == nil ? 0 : [self.storeInfo hash]);
    result = 31 * result + (self.sellerInfo == nil ? 0 : [self.sellerInfo hash]);
    result = 31 * result + (self.shippingInfo == nil ? 0 : [self.shippingInfo hash]);
    result = 31 * result + (self.sellingStatus == nil ? 0 : [self.sellingStatus hash]);
    result = 31 * result + (self.listingInfo == nil ? 0 : [self.listingInfo hash]);
    result = 31 * result + (self.returnsAccepted == nil ? 0 : [self.returnsAccepted hash]);
    result = 31 * result + (self.galleryPlusPictureURL == nil ? 0 : [self.galleryPlusPictureURL hash]);
    result = 31 * result + (self.compatibility == nil ? 0 : [self.compatibility hash]);
    result = 31 * result + (self.distance == nil ? 0 : [self.distance hash]);
    result = 31 * result + (self.condition == nil ? 0 : [self.condition hash]);
    result = 31 * result + (self.isMultiVariationListing == nil ? 0 : [self.isMultiVariationListing hash]);
    result = 31 * result + (self.discountPriceInfo == nil ? 0 : [self.discountPriceInfo hash]);
    result = 31 * result + (self.pictureURLSuperSize == nil ? 0 : [self.pictureURLSuperSize hash]);
    result = 31 * result + (self.pictureURLLarge == nil ? 0 : [self.pictureURLLarge hash]);
    result = 31 * result + (self.unitPrice == nil ? 0 : [self.unitPrice hash]);
    result = 31 * result + (self.topRatedListing == nil ? 0 : [self.topRatedListing hash]);
    
    return result;
}

- (void)dealloc {
    [self.itemId release];
    [self.title release];
    [self.globalId release];
    [self.subtitle release];
    [self.primaryCategory release];
    [self.secondaryCategory release];
    [self.galleryURL release];
    [self.galleryInfoContainer release];
    [self.viewItemURL release];
    [self.charityId release];
    [self.productId release];
    [self.paymentMethod release];
    [self.autoPay release];
    [self.postalCode release];
    [self.location release];
    [self.country release];
    [self.storeInfo release];
    [self.sellerInfo release];
    [self.shippingInfo release];
    [self.sellingStatus release];
    [self.listingInfo release];
    [self.returnsAccepted release];
    [self.galleryPlusPictureURL release];
    [self.compatibility release];
    [self.distance release];
    [self.condition release];
    [self.isMultiVariationListing release];
    [self.discountPriceInfo release];
    [self.pictureURLSuperSize release];
    [self.pictureURLLarge release];
    [self.unitPrice release];
    [self.topRatedListing release];
    [super dealloc];
}

@end