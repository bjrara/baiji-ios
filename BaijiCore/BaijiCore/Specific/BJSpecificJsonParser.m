//
//  BJSpecificJsonParser.m
//  BaijiCore
//
//  Created by user on 14-9-25.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJSpecificJsonParser.h"
#import "BJSchemas.h"
#import "BJError.h"
#import "BJSpecificEnum.h"
#import "JSONKit.h"
#import "NSData+Base64.h"

@implementation BJSpecificJsonParser

- (id<BJMutableRecord>)readData:(NSData *)data clazz:(Class<BJMutableRecord>)clazz {
    NSDictionary *reuse = [data objectFromJSONData];
    //TODO remove log
    NSLog(@"%@", [reuse description]);
    return [self readRecord:reuse schema:(BJRecordSchema *)[clazz schema]];
}

- (id<BJMutableRecord>)readRecord:(NSDictionary *)reuse schema:(BJRecordSchema *)recordSchema {
    Class clazz = NSClassFromString([recordSchema name]);
    if(![clazz conformsToProtocol:@protocol(BJMutableRecord)])
        [NSException exceptionWithName:BJRuntimeException reason:@"class is not a BJMutableRecord." userInfo:nil];
    id<BJMutableRecord> parsedRecord = [clazz new];
    NSArray *fields = [recordSchema fields];
    for (BJField *field in fields) {
        if([reuse objectForKey:[field name]]) {
            [self readValue:[reuse objectForKey:[field name]] schema:[field schema] success:^(id parsedValue) {
                [parsedRecord setObject:parsedValue forName:[field name]];
            }];
        }
    }
    return parsedRecord;
}

- (void)readValue:(id)datum schema:(BJSchema *)schema success:(BJJsonReadingResolver)success {
    switch ([schema type]) {
        case BJSchemaTypeNull:
            [NSException exceptionWithName:BJRuntimeException reason:@"null schema reads is are not supported" userInfo:nil];
        case BJSchemaTypeInt:
        case BJSchemaTypeDouble:
        case BJSchemaTypeLong:
        case BJSchemaTypeFloat:
            success([self readNumber:datum]);
            break;
        case BJSchemaTypeBoolean:
            success([self readBoolean:datum]);
            break;
        case BJSchemaTypeString:
            success([self readString:datum]);
            break;
        case BJSchemaTypeBytes:
            success([self readBytes:datum]);
            break;
        case BJSchemaTypeDateTime:
            success([self readDate:datum]);
            break;
        case BJSchemaTypeRecord:
            success([self readRecord:datum schema:(BJRecordSchema *)schema]);
            break;
        case BJSchemaTypeMap:
            success([self readMap:datum schema:(BJMapSchema *)schema]);
            break;
        case BJSchemaTypeEnum:
            success([self readEnum:datum schema:(BJEnumSchema *)schema]);
            break;
        case BJSchemaTypeUnion:
            success([self readUnion:datum schema:(BJUnionSchema *)schema]);
            break;
        case BJSchemaTypeArray:
            success([self readArray:datum schema:(BJArraySchema *)schema]);
            break;
        default:
            [NSException exceptionWithName:BJRuntimeException
                                    reason:[NSString stringWithFormat:@"Unknown schema type: %@", [schema name]]
                                  userInfo:nil];
            break;
    }
}

- (NSNumber *)readNumber:(id)number {
    return number;
}

- (NSNumber *)readBoolean:(NSString *)value {
    return [NSNumber numberWithBool:[@"true" isEqualToString:value]];
}

- (NSDate *)readDate:(NSNumber *)interval {
    return [NSDate dateWithTimeIntervalSince1970:[interval longValue]];
}

- (NSString *)readString:(NSString *)string {
    return string;
}

- (NSData *)readBytes:(NSString *)bytes {
    return [NSData dataWithBase64String:bytes];
}

- (NSDictionary *)readMap:(NSDictionary *)map schema:(BJMapSchema *)mapSchema {
    BJSchema *valueSchema = [mapSchema valueSchema];
    __block NSMutableDictionary *parsedMap = [[NSMutableDictionary alloc] init];
    [map enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [self readValue:obj schema:valueSchema success:^(id parsedValue) {
            [parsedMap setObject:parsedValue forKey:key];
        }];
    }];
    return parsedMap;
}

- (BJSpecificEnum *)readEnum:(NSString *)name schema:(BJEnumSchema *)enumSchema {
    Class clazz = NSClassFromString([enumSchema fullname]);
    if(![clazz isSubclassOfClass:[BJSpecificEnum class]])
        [NSException exceptionWithName:BJRuntimeException reason:@"enum is not a BJSpecificEnum." userInfo:nil];
    BJSpecificEnum *enumeration = [clazz new];
    [enumeration setValue:[clazz ordinalForName:name]];
    return enumeration;
}

- (id)readUnion:(id)datum schema:(BJUnionSchema *)unionSchema {
    int count = [unionSchema count];
    __block id parsedUnionValue;
    for (int i = 0; i < count; i++) {
        BJSchema *schema = [unionSchema schemaAtIndex:i];
        if([schema type] == BJSchemaTypeNull)
            continue;
        [self readValue:datum schema:schema success:^(id parsedValue) {
            parsedUnionValue = parsedValue;
        }];
    }
    return parsedUnionValue;
}

- (NSArray *)readArray:(NSArray *)array schema:(BJArraySchema *)arraySchema {
    BJSchema *itemSchema = [arraySchema itemSchema];
    NSMutableArray *parsedArray = [[NSMutableArray alloc] init];
    for (id item in array) {
        [self readValue:item schema:itemSchema success:^(id parsedValue) {
            [parsedArray addObject:parsedValue];
        }];
    }
    return parsedArray;
}

@end