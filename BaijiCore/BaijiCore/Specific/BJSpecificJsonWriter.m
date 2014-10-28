//
//  BJSpecificJsonReader.m
//  BaijiCore
//
//  Created by user on 14-9-24.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "BJSpecificJsonWriter.h"
#import "BJSpecificEnum.h"
#import "BJSchemas.h"
#import "BJError.h"
#import "NSData+Base64.h"

@implementation BJSpecificJsonWriter

- (NSData *)writeObject:(id<BJMutableRecord>)object {
    NSDictionary *parsedObject = [self writeRecord:object schema:(BJRecordSchema *)[object schema]];
    return [NSJSONSerialization dataWithJSONObject:parsedObject options:0 error:nil];
}

- (NSDictionary *)writeRecord:(id)datum schema:(BJRecordSchema *)recordSchema {
    NSArray *fields = [recordSchema fields];
    NSMutableDictionary *parsedRecord = [[NSMutableDictionary alloc] init];
    for (BJField *field in fields) {
        id value = [((id<BJMutableRecord>)datum) fieldAtIndex:[field pos]];
        if(value == nil)
            continue;
        [self writeValue:value schema:[field schema] success:^(id parsedValue) {
            [parsedRecord setValue:parsedValue forKey:[field name]];
        }];
    }
    return [parsedRecord autorelease];
}

- (void)writeValue:(id)datum schema:(BJSchema *)schema success:(BJJsonWritingResolver)success {
    switch ([schema type]) {
        case BJSchemaTypeInt:
        case BJSchemaTypeLong:
        case BJSchemaTypeDouble:
            success([self writeNumber:datum]);
            break;
        case BJSchemaTypeFloat:
            success([self writeFloat:datum]);
            break;
        case BJSchemaTypeBoolean:
            success([self writeBoolean:datum]);
            break;
        case BJSchemaTypeString:
            success([self writeString:datum]);
            break;
        case BJSchemaTypeBytes:
            success([self writeBytes:datum]);
            break;
        case BJSchemaTypeNull:
            [NSException exceptionWithName:BJRuntimeException reason:@"null schema writes is are not supported" userInfo:nil];
            break;
        case BJSchemaTypeDateTime:
            success([self writeNumber:[NSNumber numberWithInt:[((NSDate *)datum) timeIntervalSince1970]]]);
            break;
        case BJSchemaTypeRecord:
            success([self writeRecord:datum schema:(BJRecordSchema *)schema]);
            break;
        case BJSchemaTypeEnum:
            success([self writeEnum:datum]);
            break;
        case BJSchemaTypeArray:
            success([self writeArray:datum schema:(BJArraySchema *)schema]);
            break;
        case BJSchemaTypeMap:
            success([self writeMap:datum schema:(BJMapSchema *)schema]);
            break;
        case BJSchemaTypeUnion:
            success([self writeUnion:datum schema:(BJUnionSchema *)schema]);
            break;
        default:
            [NSException exceptionWithName:BJRuntimeException
                                    reason:[NSString stringWithFormat:@"Unknown schema type: %@", [schema name]]
                                  userInfo:nil];
            break;
    }
}

- (NSNumber *)writeNumber:(id)number {
    return number;
}

- (NSDecimalNumber *)writeFloat:(NSNumber *)number {
    return [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f", [number floatValue]]];
}

- (NSNumber *)writeDate:(NSDate *)date{
    return [NSNumber numberWithLong:[date timeIntervalSince1970]];
}

- (NSString *)writeBoolean:(id)number {
    if([number intValue] != 0)
        return @"true";
    else
        return @"false";
}

- (NSString *)writeBytes:(NSData *)bytes {
    /**
     JSONKit does not support bytes serilization.
     Either dynamically catch object classes that JSONKit does not automatically serialize and transform them in to a type that it does, or turn the NSData in to a Base64 encoded NSString. The later is the most common approach by far.
     */
    return [bytes base64EncodedString];
}

- (NSString *)writeString:(NSString *)string {
    return string;
}

//TODO check correctness
- (NSString *)writeEnum:(BJSpecificEnum *)enumeration {
    return [enumeration name];
}

- (NSArray *)writeArray:(NSArray *)array schema:(BJArraySchema *)arraySchema {
    BJSchema *itemSchema = [arraySchema itemSchema];
    NSMutableArray *parsedArray = [[NSMutableArray alloc] init];
    for (id item in array) {
        [self writeValue:item schema:itemSchema success:^(id parsedValue) {
            [parsedArray addObject:parsedValue];
        }];
    }
    return [parsedArray autorelease];
}

- (NSDictionary *)writeMap:(NSDictionary *)map schema:(BJMapSchema *)mapSchema {
    BJSchema *valueSchema = [mapSchema valueSchema];
    NSMutableDictionary *parsedMap = [[NSMutableDictionary alloc] init];
    [map enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [self writeValue:obj schema:valueSchema success:^(id parsedValue) {
            [parsedMap setObject:parsedValue forKey:key];
        }];
    }];
    return [parsedMap autorelease];
}

- (id)writeUnion:(id)datum schema:(BJUnionSchema *)unionSchema {
    int count = [unionSchema count];
    __block id parsedUnionValue = nil;
    for (int i = 0; i < count; i++) {
        if([[unionSchema schemaAtIndex:i] type] == BJSchemaTypeNull)
            continue;
        [self writeValue:datum schema:[unionSchema schemaAtIndex:i] success:^(id parsedValue) {
            parsedUnionValue = parsedValue;
        }];
    }
    return parsedUnionValue;
}

@end