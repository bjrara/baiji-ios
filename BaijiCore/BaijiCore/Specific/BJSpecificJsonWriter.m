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
#import "JSONKit.h"

@implementation BJSpecificJsonWriter

- (NSData *)writeObject:(id<BJMutableRecord>)object {
    NSDictionary *parsedObject = [self writeRecord:object schema:(BJRecordSchema *)[[object class] schema]];
    return [parsedObject JSONData];
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
    return parsedRecord;
}

- (void)writeValue:(id)datum schema:(BJSchema *)schema success:(BJJsonWritingResolver)success {
    switch ([schema type]) {
        case BJSchemaTypeInt:
        case BJSchemaTypeLong:
        case BJSchemaTypeDouble:
        case BJSchemaTypeFloat:
        case BJSchemaTypeBoolean:
            success([self writeNumber:datum]);
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
            success([NSDate dateWithTimeIntervalSince1970:[[self writeNumber:datum] doubleValue]]);
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

- (NSData *)writeBytes:(NSData *)bytes {
    return bytes;
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
    return parsedArray;
}

- (NSDictionary *)writeMap:(NSDictionary *)map schema:(BJMapSchema *)mapSchema {
    BJSchema *valueSchema = [mapSchema valueSchema];
    NSMutableDictionary *parsedMap = [[NSMutableDictionary alloc] init];
    [map enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [self writeValue:obj schema:valueSchema success:^(id parsedValue) {
            [parsedMap setObject:parsedValue forKey:key];
        }];
    }];
    return parsedMap;
}

- (id)writeUnion:(id)datum schema:(BJUnionSchema *)unionSchema {
    int count = [unionSchema count];
    __block id parsedUnionValue;
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