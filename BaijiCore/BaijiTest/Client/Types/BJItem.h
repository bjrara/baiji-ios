/**
 * Autogenerated by soa-sdk-toolkit
 *
 * DO NOT EDIT DIRECTLY
 */
#import <Foundation/Foundation.h>
#import "BJMutableSpecificRecord.h"
@class BJProductId;
@class BJDiscountPriceInfo;
@class BJStorefront;
@class BJGalleryURL;
@class BJSellingStatus;
@class BJSellerInfo;
@class BJDistance;
@class BJCondition;
@class BJShippingInfo;
@class BJUnitPriceInfo;
@class BJCategory;
@class BJListingInfo;

@interface BJItem : BJMutableSpecificRecord

@property (nonatomic, readwrite, retain) NSString *itemId;
@property (nonatomic, readwrite, retain) NSString *title;
@property (nonatomic, readwrite, retain) NSString *globalId;
@property (nonatomic, readwrite, retain) NSString *subtitle;
@property (nonatomic, readwrite, retain) BJCategory *primaryCategory;
@property (nonatomic, readwrite, retain) BJCategory *secondaryCategory;
@property (nonatomic, readwrite, retain) NSString *galleryURL;
@property (nonatomic, readwrite, retain) NSArray *galleryInfoContainer;
@property (nonatomic, readwrite, retain) NSString *viewItemURL;
@property (nonatomic, readwrite, retain) NSString *charityId;
@property (nonatomic, readwrite, retain) BJProductId *productId;
@property (nonatomic, readwrite, retain) NSArray *paymentMethod;
/** initValue: bool */
@property (nonatomic, readwrite, retain) NSNumber *autoPay;
@property (nonatomic, readwrite, retain) NSString *postalCode;
@property (nonatomic, readwrite, retain) NSString *location;
@property (nonatomic, readwrite, retain) NSString *country;
@property (nonatomic, readwrite, retain) BJStorefront *storeInfo;
@property (nonatomic, readwrite, retain) BJSellerInfo *sellerInfo;
@property (nonatomic, readwrite, retain) BJShippingInfo *shippingInfo;
@property (nonatomic, readwrite, retain) BJSellingStatus *sellingStatus;
@property (nonatomic, readwrite, retain) BJListingInfo *listingInfo;
/** initValue: bool */
@property (nonatomic, readwrite, retain) NSNumber *returnsAccepted;
@property (nonatomic, readwrite, retain) NSArray *galleryPlusPictureURL;
@property (nonatomic, readwrite, retain) NSString *compatibility;
@property (nonatomic, readwrite, retain) BJDistance *distance;
@property (nonatomic, readwrite, retain) BJCondition *condition;
/** initValue: bool */
@property (nonatomic, readwrite, retain) NSNumber *isMultiVariationListing;
@property (nonatomic, readwrite, retain) BJDiscountPriceInfo *discountPriceInfo;
@property (nonatomic, readwrite, retain) NSString *pictureURLSuperSize;
@property (nonatomic, readwrite, retain) NSString *pictureURLLarge;
@property (nonatomic, readwrite, retain) BJUnitPriceInfo *unitPrice;
/** initValue: bool */
@property (nonatomic, readwrite, retain) NSNumber *topRatedListing;

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
     topRatedListing:(NSNumber *)topRatedListing;

@end