/**
 * Autogenerated by soa-sdk-toolkit
 *
 * DO NOT EDIT DIRECTLY
 */
#import "BJEnum1Values.h"

NSString *const BJEnum1ValuesNames[] = {
    [BJEnum1ValuesBLUE] = @"BLUE",
    [BJEnum1ValuesRED] = @"RED",
    [BJEnum1ValuesGREEN] = @"GREEN",
};

@implementation BJEnum1Values

- (NSString *)name {
    return BJEnum1ValuesNames[self.value];
}

+ (NSUInteger)ordinalForName:(NSString *)name {
    if([BJEnum1ValuesNames[BJEnum1ValuesBLUE] isEqual:name])
        return BJEnum1ValuesBLUE;
    if([BJEnum1ValuesNames[BJEnum1ValuesRED] isEqual:name])
        return BJEnum1ValuesRED;
    if([BJEnum1ValuesNames[BJEnum1ValuesGREEN] isEqual:name])
        return BJEnum1ValuesGREEN;
    return -1;
}

#pragma override NSObject methods

- (BOOL)isEqual:(id)object {
    if (object == nil)
        return NO;
    if (![object isKindOfClass:[BJEnum1Values class]])
        return NO;
    BJEnum1Values *that = (BJEnum1Values *)object;
    if (self.value == [that value])
        return YES;
    return NO;
}

@end