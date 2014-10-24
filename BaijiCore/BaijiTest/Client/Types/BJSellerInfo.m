/**
 * Autogenerated by soa-sdk-toolkit
 *
 * DO NOT EDIT DIRECTLY
 */
#import "BJSellerInfo.h"
#import "BJError.h"

@implementation BJSellerInfo

- (BJSchema *)schema {
    static BJSchema *__schema = nil;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
        __schema = [[BJSchema parse:@"{\"type\":\"record\",\"name\":\"BJSellerInfo\",\"namespace\":\"com.ctrip.soa.framework.soa.testservice.v1\",\"fields\":[{\"name\":\"sellerUserName\",\"type\":[\"string\",\"null\"]},{\"name\":\"feedbackScore\",\"type\":[\"long\",\"null\"]},{\"name\":\"positiveFeedbackPercent\",\"type\":[\"double\",\"null\"]},{\"name\":\"feedbackRatingStar\",\"type\":[\"string\",\"null\"]},{\"name\":\"topRatedSeller\",\"type\":[\"boolean\",\"null\"]}]}"] retain];
    });
    return __schema;
}

- (id)initWithSellerUserName:(NSString *)sellerUserName
               feedbackScore:(NSNumber *)feedbackScore
     positiveFeedbackPercent:(NSNumber *)positiveFeedbackPercent
          feedbackRatingStar:(NSString *)feedbackRatingStar
              topRatedSeller:(NSNumber *)topRatedSeller {
    self = [super init];
    if (self) {
        self.sellerUserName = sellerUserName;
        self.feedbackScore = feedbackScore;
        self.positiveFeedbackPercent = positiveFeedbackPercent;
        self.feedbackRatingStar = feedbackRatingStar;
        self.topRatedSeller = topRatedSeller;
    }
    return self;
}

- (id)fieldAtIndex:(int)fieldPos {
    switch (fieldPos) {
        case 0: return self.sellerUserName;
        case 1: return self.feedbackScore;
        case 2: return self.positiveFeedbackPercent;
        case 3: return self.feedbackRatingStar;
        case 4: return self.topRatedSeller;
        default:
            [NSException exceptionWithName:BJRuntimeException
                                    reason:[NSString stringWithFormat:@"Bad index %d in fieldAtIndex:", fieldPos]
                                  userInfo:nil];
    }
    return nil;
}

- (void)setObject:(id)object atIndex:(int)fieldPos {
    switch (fieldPos) {
        case 0: self.sellerUserName = object; break;
        case 1: self.feedbackScore = object; break;
        case 2: self.positiveFeedbackPercent = object; break;
        case 3: self.feedbackRatingStar = object; break;
        case 4: self.topRatedSeller = object; break;
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
    BJSellerInfo *that = (BJSellerInfo *)object;
    return
    [self.sellerUserName isEqual:[that sellerUserName]] &&
    [self.feedbackScore isEqual:[that feedbackScore]] &&
    [self.positiveFeedbackPercent isEqual:[that positiveFeedbackPercent]] &&
    [self.feedbackRatingStar isEqual:[that feedbackRatingStar]] &&
    [self.topRatedSeller isEqual:[that topRatedSeller]];
}

- (NSUInteger)hash {
    NSUInteger result = 1;
    
    result = 31 * result + (self.sellerUserName == nil ? 0 : [self.sellerUserName hash]);
    result = 31 * result + (self.feedbackScore == nil ? 0 : [self.feedbackScore hash]);
    result = 31 * result + (self.positiveFeedbackPercent == nil ? 0 : [self.positiveFeedbackPercent hash]);
    result = 31 * result + (self.feedbackRatingStar == nil ? 0 : [self.feedbackRatingStar hash]);
    result = 31 * result + (self.topRatedSeller == nil ? 0 : [self.topRatedSeller hash]);
    
    return result;
}

- (void)dealloc {
    [self.sellerUserName release];
    [self.feedbackScore release];
    [self.positiveFeedbackPercent release];
    [self.feedbackRatingStar release];
    [self.topRatedSeller release];
    [super dealloc];
}

@end
