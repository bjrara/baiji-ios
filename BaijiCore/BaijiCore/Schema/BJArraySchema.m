//
//  BJArraySchema.m
//  BaijiCore
//
//  Created by user on 14-9-19.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJArraySchema.h"
#import "BJError.h"
#import "BJSchema.h"
#import "BJPropertyMap.h"

@interface BJArraySchema()

@property (nonatomic, readwrite, retain) BJSchema *itemSchema;

@end

@implementation BJArraySchema

- (id)initWithItemSchema:(BJSchema *)itemSchema properties:(BJPropertyMap *)properties {
    self = [super initWithType:BJSchemaTypeArray properties:properties];
    if(self) {
        if(!itemSchema)
            [NSException exceptionWithName:BJArgumentException reason:@"ItemSchema cannot be null." userInfo:nil];
        self.itemSchema = itemSchema;
    }
    return self;
}

+ (BJArraySchema *)sharedInstanceForObject:(NSDictionary *)jsonObj
                                properties:(BJPropertyMap *)properties
                                     names:(BJSchemaNames *)names
                                  encSpace:(NSString *)encSpace {
    id jItems = [jsonObj objectForKey:@"items"];
    if(jItems == nil)
        [NSException exceptionWithName:BJCallException reason:@"Array does not have 'items'" userInfo:nil];
    BJSchema *itemSchema = [BJSchema parseJson:jItems names:names encSpace:encSpace];
    return [[[BJArraySchema alloc] initWithItemSchema:itemSchema properties:properties] autorelease];
}

- (NSDictionary *)jsonObjectWithSchemaNames:(BJSchemaNames *)names encSpace:(NSString *)encSpace {
    NSMutableDictionary *jObj = [super jsonObjectWithSchemaNames:names encSpace:encSpace];
    [jObj setObject:[self jsonFieldsWithSchemaNames:names encSpace:encSpace] forKey:@"items"];
    return jObj;
}

- (id)jsonFieldsWithSchemaNames:(BJSchemaNames *)names encSpace:(NSString *)encSpace {
    return [self.itemSchema jsonObjectWithSchemaNames:names encSpace:encSpace];
}

#pragma override NSObject methods

- (BOOL)isEqual:(id)object {
    if(object == self)
        return YES;
    if([object isKindOfClass:[BJArraySchema class]]) {
        BJArraySchema *that = (BJArraySchema *)object;
        if([self.itemSchema isEqual:[that itemSchema]]) {
            return [self.properties isEqualToDictionary:[that properties]];
        }
    }
    return NO;
}

- (NSUInteger)hash {
    return 29 * [self.itemSchema hash] + [self.properties hash];
}
@end
