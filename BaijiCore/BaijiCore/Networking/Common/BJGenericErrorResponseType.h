/**
 * Autogenerated by soa-sdk-toolkit
 *
 * DO NOT EDIT DIRECTLY
 */
#import <Foundation/Foundation.h>
#import "BJMutableSpecificRecord.h"
@class BJResponseStatusType;

@interface BJGenericErrorResponseType : BJMutableSpecificRecord

@property (nonatomic, readwrite, retain) BJResponseStatusType *responseStatus;

- (id)initWithResponseStatus:(BJResponseStatusType *)responseStatus;

@end