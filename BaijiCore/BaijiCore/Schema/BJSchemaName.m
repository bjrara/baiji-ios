//
//  BJSchemaName.m
//  BaijiCore
//
//  Created by user on 14-9-17.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJSchemaName.h"

@interface BJSchemaName()

@property (nonatomic,readwrite) NSString *name;
@property (nonatomic,readwrite) NSString *space;
@property (nonatomic,readwrite) NSString *encSpace;
@property (nonatomic,readwrite) NSString *fullName;

@end

@implementation BJSchemaName

- (id)initWithName:(NSString *)name
             space:(NSString *)space
          encSpace:(NSString *)encSpace {
    self = [super init];
    if(self){
        if(name == nil){
            _name = _space = nil;
            _encSpace = _encSpace;
            _fullName = nil;
        }
        NSArray *nsCompos = [name componentsSeparatedByString:@"."];
        if([nsCompos count] == 1){
            _name = name;
            _space = space;
            _encSpace = encSpace;
        }else{
            NSRange range = NSMakeRange(0, [nsCompos count] -2);
            _space = [[nsCompos subarrayWithRange:range] componentsJoinedByString:@"."];
            _name = [nsCompos objectAtIndex:[nsCompos count]-1];
            _encSpace = encSpace;
        }
        NSString *namespace = self.ns;
        _fullName = namespace != nil & [namespace length] != 0 ? [NSString stringWithFormat:@"%@.%@", namespace, self.name] : self.name;
    }
    return self;
}

- (NSString *)string {
    return self.fullName;
}

- (NSString *)ns {
    return self.space != nil && [self.space length] != 0 ? self.space : self.encSpace;
}

- (BOOL)isEqual:(id)object {
    if(object == self)
        return YES;
    if(![object isKindOfClass:[BJSchemaName class]])
        return NO;
    BJSchemaName *that = (BJSchemaName *)object;
    return [self.fullName isEqual: [that fullName]] && [self.fullName isEqual: [that fullName]];
}

- (NSUInteger)hash {
    return self.fullName == nil ? 0 : 29 * [self.fullName hash];
}

- (id)copyWithZone:(NSZone *)zone {
    BJSchemaName *copy = [[[self class] allocWithZone:zone] initWithName:self.name
                                                                   space:self.space
                                                                encSpace:self.encSpace];
    return copy;
}

@end
