//
//  BJSchema.m
//  BaijiCore
//
//  Created by user on 14-9-17.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJSchema.h"
#import "BJError.h"

@interface BJSchema()

@property (nonatomic, readwrite) BJSchemaType type;
@property (nonatomic, readwrite) BJPropertyMap *properties;

@end

@implementation BJSchema

NSString *const BJSchemaTypeNames[] = {
    [BJSchemaTypeRecord] = @"record",
    [BJSchemaTypeEnum] = @"enum",
    [BJSchemaTypeArray] = @"array",
    [BJSchemaTypeMap] = @"map",
    [BJSchemaTypeUnion] = @"union",
    [BJSchemaTypeString] = @"string",
    [BJSchemaTypeBytes] = @"bytes",
    [BJSchemaTypeInt] = @"int",
    [BJSchemaTypeLong] = @"long",
    [BJSchemaTypeFloat] = @"float",
    [BJSchemaTypeDouble] = @"double",
    [BJSchemaTypeBoolean] = @"boolean",
    [BJSchemaTypeNull] = @"null"
};

+ (BJSchema *)parse:(NSString *)json {
    if(json == nil || [json length] == 0)
        [NSException exceptionWithName:BJArgumentException
                                reason:@"input json cannot be null"
                              userInfo:nil];
    
    
}

+ (BJSchema)parse:(NSString *)json withSchemaName:(BJSchemaName *)names encSpace:(NSString *)encSpace {
    
}

- (NSString *)propertyForKey:(NSString *)key {
    if(self.properties == nil)
        return nil;
    return [self.properties objectForKey:key];
}
@end
