//
//  BJSchemaTestFullName.m
//  BaijiCore
//
//  Created by user on 14-9-23.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJSchemaTestFullName.h"
#import "BJSchemaName.h"

@implementation BJSchemaTestFullName

- (void)testFullName {
    [self runTestWithName:@"a" ns:@"o.a.h" referringFullName:@"o.a.h.a"];
}

- (void)runTestWithName:(NSString *)name ns:(NSString *)ns referringFullName:(NSString *)fullName {
    BJSchemaName *schemaName = [[BJSchemaName alloc] initWithName:name space:ns encSpace:nil];
    GHAssertEqualStrings(fullName, [schemaName fullName], nil);
    [schemaName release];
}

@end
