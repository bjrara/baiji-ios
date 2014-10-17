/**
 * Autogenerated by soa-sdk-toolkit
 *
 * DO NOT EDIT DIRECTLY
 */
#import "BJGalleryURL.h"
#import "BJError.h"
#import "BJGallerySizeEnum.h"

@implementation BJGalleryURL

+ (BJSchema *)schema {
    static BJSchema *__schema = nil;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
        __schema = [[BJSchema parse:@"{\"type\":\"record\",\"name\":\"BJGalleryURL\",\"namespace\":\"com.ctrip.soa.framework.soa.testservice.v1\",\"fields\":[{\"name\":\"value\",\"type\":[\"string\",\"null\"]},{\"name\":\"gallerySize\",\"type\":[{\"type\":\"enum\",\"name\":\"BJGallerySizeEnum\",\"namespace\":\"com.ctrip.soa.framework.soa.testservice.v1\",\"symbols\":[\"SMALL\",\"MEDIUM\",\"LARGE\"]},\"null\"]}]}"] retain];
    });
    return __schema;
}

- (id)initWithValue:(NSString *)value
        gallerySize:(BJGallerySizeEnum *)gallerySize {
    self = [super init];
    if (self) {
        _value = value;
        _gallerySize = gallerySize;
    }
    return self;
}

- (id)fieldAtIndex:(int)fieldPos {
    switch (fieldPos) {
        case 0: return self.value;
        case 1: return self.gallerySize;
        default:
            [NSException exceptionWithName:BJRuntimeException
                                    reason:[NSString stringWithFormat:@"Bad index %d in fieldAtIndex:", fieldPos]
                                  userInfo:nil];
    }
    return nil;
}

- (void)setObject:(id)object atIndex:(int)fieldPos {
    switch (fieldPos) {
        case 0: self.value = object; break;
        case 1: self.gallerySize = object; break;
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
    BJGalleryURL *that = (BJGalleryURL *)object;
    return
    [self.value isEqual:[that value]] &&
    [self.gallerySize isEqual:[that gallerySize]];
}

- (NSUInteger)hash {
    NSUInteger result = 1;
    
    result = 31 * result + (self.value == nil ? 0 : [self.value hash]);
    result = 31 * result + (self.gallerySize == nil ? 0 : [self.gallerySize hash]);
    
    return result;
}

- (void)dealloc {
    [self.value release];
    [self.gallerySize release];
    [super dealloc];
}

@end