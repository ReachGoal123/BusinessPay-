//
//  AESCrypt.m
//  Gurpartap Singh
//
//  Created by Gurpartap Singh on 06/05/12.
//  Copyright (c) 2012 Gurpartap Singh
// 
// 	MIT License
// 
// 	Permission is hereby granted, free of charge, to any person obtaining
// 	a copy of this software and associated documentation files (the
// 	"Software"), to deal in the Software without restriction, including
// 	without limitation the rights to use, copy, modify, merge, publish,
// 	distribute, sublicense, and/or sell copies of the Software, and to
// 	permit persons to whom the Software is furnished to do so, subject to
// 	the following conditions:
// 
// 	The above copyright notice and this permission notice shall be
// 	included in all copies or substantial portions of the Software.
// 
// 	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// 	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// 	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// 	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// 	LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// 	OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// 	WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "AESCrypt.h"
#import "NSData+CommonCrypto.h"
#import "NSData+OADataHelpers.h"

@implementation AESCrypt

#define gIv             @"0102030405060708"

// 加密方法
+ (NSString*)encrypt:(NSString*)plainText andKey:(NSString *)key {
    
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    
    size_t plainTextBufferSize = [data length];
    
    const void *vplainText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    
    uint8_t *bufferPtr = NULL;
    
    size_t bufferPtrSize = 0;
    
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSizeAES128) & ~(kCCBlockSizeAES128 - 1);
    
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [key UTF8String];
    
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithmAES128,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySizeAES128,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
   // NSString * resultStr = @"" ;
    NSLog(@"%d", [myData length]) ;
    
    NSString * testString =  [myData hexRepresentationWithSpaces_AS:NO];
    
    return [testString lowercaseString] ;
//    printf("%s\n", [myData hexadecimalString]);
    
//    Byte *bytes = (Byte *)[myData bytes];
//
//    for(int i=0;i<[myData length];i++)
//    {
//        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff]; //16进制数
//        if([newHexStr length]==1)
//            resultStr = [NSString stringWithFormat:@"%@0%@",resultStr,newHexStr];
//        else
//            resultStr = [NSString stringWithFormat:@"%@%@",resultStr,newHexStr];
//    }
//    
//    return [resultStr lowercaseString] ;
    
}

// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText andKey:(NSString *)key{
    
    // 转换为字符数组
    NSMutableData *encryptData = [[NSMutableData alloc] init];
    NSString * encryptTextUP = [encryptText uppercaseString];
    for (int i = 0; i < encryptText.length/2; i++) {
        int pos = i * 2;
        NSRange range1 =  NSMakeRange(pos, 1);
        NSRange range2 =  NSMakeRange(pos+1, 1);
        int temp1 = [self StringToInt:[encryptTextUP substringWithRange:range1]];
        int temp2 = [self StringToInt:[encryptTextUP substringWithRange:range2]];
        int testdata =  temp1 * 16 + temp2;
        NSData * data= [NSData dataWithBytes: &testdata length: 1];
        [encryptData appendData:data];
    }
    
    size_t plainTextBufferSize = [encryptData length];
    
    const void *vplainText = [encryptData bytes];
    
    CCCryptorStatus ccStatus;
    
    uint8_t *bufferPtr = NULL;
    
    size_t bufferPtrSize = 0;
    
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCAlgorithm3DES) & ~(kCCAlgorithm3DES - 1);
    
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [key UTF8String];
    
    const void *vinitVec = (const void *) [gIv UTF8String];
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithmAES128,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySizeAES128,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];

    NSString *result = [[NSString alloc] initWithData:myData encoding:NSUTF8StringEncoding] ;
    return result;
}

+ (int) StringToInt:(NSString *)stringValue
{
    if ([stringValue isEqual:@"A"])
    {
        return 10 ;
    }
    else if ([stringValue isEqual:@"B"])
    {
        return 11 ;
    }
    else if ([stringValue isEqual:@"C"])
    {
        return 12 ;
    }
    else if ([stringValue isEqual:@"D"])
    {
        return 13 ;
    }
    else if ([stringValue isEqual:@"E"])
    {
        return 14 ;
    }
    else if ([stringValue isEqual:@"F"])
    {
        return 15 ;
    }
    else
    {
        return [stringValue intValue] ;
    }
}

+ (NSString *)ToHex:(int)tmpid
{
    NSString *endtmp=@"";
    NSString *nLetterValue;
    NSString *nStrat;
    int ttmpig=tmpid%16;
    int tmp=tmpid/16;
    switch (ttmpig)
    {
        case 10:
            nLetterValue =@"A";break;
        case 11:
            nLetterValue =@"B";break;
        case 12:
            nLetterValue =@"C";break;
        case 13:
            nLetterValue =@"D";break;
        case 14:
            nLetterValue =@"E";break;
        case 15:
            nLetterValue =@"F";break;
        default:nLetterValue=[[NSString alloc]initWithFormat:@"%i",ttmpig];
            
    }
    switch (tmp)
    {
        case 10:
            nStrat =@"A";break;
        case 11:
            nStrat =@"B";break;
        case 12:
            nStrat =@"C";break;
        case 13:
            nStrat =@"D";break;
        case 14:
            nStrat =@"E";break;
        case 15:
            nStrat =@"F";break;
        default:nStrat=[[NSString alloc]initWithFormat:@"%i",tmp];
            
    }
    endtmp=[[NSString alloc]initWithFormat:@"%@%@",nStrat,nLetterValue];
    NSString *str=@"";
    if([endtmp length]<4)
    {
        for (int x=[endtmp length]; x<2; x++) {
            str=[str stringByAppendingString:@"0"];
        }
        endtmp=[[NSString alloc]initWithFormat:@"%@%@",str,endtmp];
    }
    return endtmp;
}


@end
