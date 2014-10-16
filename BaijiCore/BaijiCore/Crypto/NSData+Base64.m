//
//  NSData(Base64).m
//  BaijiCore
//
//  Created by user on 14-9-26.
//  Copyright (c) 2014年 ctriposs. All rights reserved.
//

#import "NSData+Base64.h"

@implementation NSData(Base64)

- (NSString *)base64EncodedString {
    NSUInteger length = [self length];
    NSMutableData *mutableData = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    
    uint8_t *input = (uint8_t *)[self bytes];
    uint8_t *output = (uint8_t *)[mutableData mutableBytes];
    
    for (NSUInteger i = 0; i < length; i += 3) {
        NSUInteger value = 0;
        for (NSUInteger j = i; j < (i + 3); j++) {
            value <<= 8;
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        static uint8_t const kBJBase64EncodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        
        NSUInteger idx = (i / 3) * 4;
        output[idx + 0] = kBJBase64EncodingTable[(value >> 18) & 0x3F];
        output[idx + 1] = kBJBase64EncodingTable[(value >> 12) & 0x3F];
        output[idx + 2] = (i + 1) < length ? kBJBase64EncodingTable[(value >> 6)  & 0x3F] : '=';
        output[idx + 3] = (i + 2) < length ? kBJBase64EncodingTable[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:mutableData encoding:NSASCIIStringEncoding];
}


+ (NSData *)dataWithBase64String:(NSString *)string {
    static uint8_t kBJBase64DecodingTable[256] = {
        65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 62, 65, 65, 65, 63,
        52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 65, 65, 65, 65, 65, 65,
        65,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
        15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 65, 65, 65, 65, 65,
        65, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
        41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65,
    };

    NSData *data = [string dataUsingEncoding:NSASCIIStringEncoding];
    int length = [data length];
    NSMutableData *mutableData = [NSMutableData dataWithLength:((length + 3) / 4) * 3];
    
    uint8_t *input = (uint8_t *)[data bytes];
    uint8_t *output = (uint8_t *)[mutableData mutableBytes];
    NSUInteger idx = 0;
    
    for (NSUInteger i = 0; i < length; ) {
        uint8_t value[4];
        NSUInteger j = 0;
        while (i < length) {
            unsigned char decode = kBJBase64DecodingTable[input[i++]];
			if (decode != 65) {
				value[j++] = decode;
			}
            if(j == 4)
                break;
        }
        if(j >= 2) output[idx + 0] = (value[0] << 2) | (value[1] >> 4);
		if(j >= 3) output[idx + 1] = (value[1] << 4) | (value[2] >> 2);
		if(j >= 4) output[idx + 2] = (value[2] << 6) | (value[3]);
		idx += j -1;
    }
    return [NSData dataWithBytes:output length:idx];
}

@end