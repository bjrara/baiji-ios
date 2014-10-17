/**
 * Autogenerated by soa-sdk-toolkit
 *
 * DO NOT EDIT DIRECTLY
 */
#import <Foundation/Foundation.h>
#import "BJMutableSpecificRecord.h"

@interface BJSellerInfo : BJMutableSpecificRecord

@property (nonatomic, readwrite, retain) NSString *sellerUserName;
/** initValue: long */
@property (nonatomic, readwrite, retain) NSNumber *feedbackScore;
/** initValue: double */
@property (nonatomic, readwrite, retain) NSNumber *positiveFeedbackPercent;
@property (nonatomic, readwrite, retain) NSString *feedbackRatingStar;
/** initValue: bool */
@property (nonatomic, readwrite, retain) NSNumber *topRatedSeller;

- (id)initWithSellerUserName:(NSString *)sellerUserName
               feedbackScore:(NSNumber *)feedbackScore
     positiveFeedbackPercent:(NSNumber *)positiveFeedbackPercent
          feedbackRatingStar:(NSString *)feedbackRatingStar
              topRatedSeller:(NSNumber *)topRatedSeller;

@end