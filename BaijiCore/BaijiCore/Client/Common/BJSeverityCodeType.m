/**
 * Autogenerated by soa-sdk-toolkit
 *
 * DO NOT EDIT DIRECTLY
 */
#import "BJSeverityCodeType.h"

NSString *const BJSeverityCodeTypeNames[] = {
    [BJSeverityCodeTypeERROR] = @"ERROR",
    [BJSeverityCodeTypeWARNING] = @"WARNING",
};

@implementation BJSeverityCodeType

- (NSString *)name {
    return BJSeverityCodeTypeNames[self.value];
}

+ (NSUInteger)ordinalForName:(NSString *)name {
    if([BJSeverityCodeTypeNames[BJSeverityCodeTypeERROR] isEqual:name])
        return BJSeverityCodeTypeERROR;
    if([BJSeverityCodeTypeNames[BJSeverityCodeTypeWARNING] isEqual:name])
        return BJSeverityCodeTypeWARNING;
    return -1;
}

#pragma override NSObject methods

- (BOOL)isEqual:(id)object {
    if (object == nil)
        return NO;
    if (![object isKindOfClass:[BJSeverityCodeType class]])
        return NO;
    BJSeverityCodeType *that = (BJSeverityCodeType *)object;
    if (self.value == [that value])
        return YES;
    return NO;
}

@end