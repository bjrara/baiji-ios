/**
 * Autogenerated by soa-sdk-toolkit
 *
 * DO NOT EDIT DIRECTLY
 */
#import <Foundation/Foundation.h>
#import "BJMutableSpecificRecord.h"


@interface BJCommonRequestType : BJMutableSpecificRecord

@property (nonatomic, readwrite, retain) NSString *version;
/** valueType: NSString */
@property (nonatomic, readwrite, retain) NSArray *outputSelector;

- (id)initWithVersion:(NSString *)version
       outputSelector:(NSArray *)outputSelector;

@end