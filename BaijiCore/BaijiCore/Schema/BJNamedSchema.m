//
//  BJNamedSchema.m
//  BaijiCore
//
//  Created by user on 14-9-17.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJNamedSchema.h"
#import "BJSchemaName.h"
#import "BJSchemaNames.h"
#import "BJError.h"
#import "BJJsonHelper.h"

@interface BJNamedSchema()

@property (nonatomic, readwrite) BJSchemaName *schemaName;
@property (nonatomic, readwrite) NSString *doc;
@property (nonatomic, readwrite) NSArray *aliases;

@end

@implementation BJNamedSchema

+ (BJNamedSchema *)sharedInstanceForObject:(NSDictionary *)obj
                                properties:(BJPropertyMap *)properties
                                     names:(BJSchemaNames *)names
                                  encSpace:(NSString *)encSpace {
    NSString *type = [BJJsonHelper requiredStringForObject:obj field:@"type"];
    if([@"enum" isEqualToString:type])
        return nil;
    else if([@"record" isEqualToString:type])
        return nil;
    else
        return [names schemaWithName:type space:nil encSpace:encSpace];
}

- (id)initWithType:(BJSchemaType)type
        schemaName:(BJSchemaName *)schemaName
               doc:(NSString *)doc
           aliases:(NSArray *)aliases
        properties:(BJPropertyMap *)properties
             names:(BJSchemaNames *)names {
    self = [super initWithType:type properties:properties];
    if(self) {
        _schemaName = schemaName;
        _doc = doc;
        _aliases = aliases;
        if([schemaName name] != nil && [names addWithSchemaName:schemaName mamedSchema:self]){
            [NSException exceptionWithName:BJRuntimeException
                                    reason:[NSString stringWithFormat:@"Duplicated schema name %@", [schemaName string]]
                                  userInfo:nil];
        }
    }
    return self;
}

- (NSString *)name {
    return [self.schemaName name];
}

- (NSString *)ns {
    return [self.schemaName ns];
}

- (NSString *)fullname {
    return [self.schemaName fullName];
}

- (BOOL)inAliasesForName:(BJSchemaName *)schemaName {
    
}

@end
