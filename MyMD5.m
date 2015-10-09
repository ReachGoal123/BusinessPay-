//
//  MyMD5.m
//  GoodLectures
//
//  Created by yangshangqing on 11-10-11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MyMD5.h"
#import "CommonCrypto/CommonDigest.h"

@implementation MyMD5

+ (NSString *) md5Base64: (NSString *) inPutText
{
    NSString *testString = inPutText;
    
    // 进行UTF8 编码 (转换成2进制 --> 转换成16 进制)
    NSData *testData = [testString dataUsingEncoding: NSUTF8StringEncoding];
    
    // 单个字符 ( 'x' )
    Byte *testByte = (Byte *)[testData bytes];
    
//    for(int i=0;i<[testData length];i++)
//        printf("testByte = %d\n",testByte[i]);
        
    // [testData length]  32 字节
//    NSLog(@"%d", [testData length]) ;
    
    // 对 testByte 进行 MD5 加密
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(testByte, (CC_LONG)[testData length], result);
    
    // 转换成16进制 Data
    NSData * data = [NSData dataWithBytes:result length:16]  ;
    
    // 转换成Base64
    return [self base64Data:data];
}

+ (NSString *)base64Data:(NSData *)str
{
    NSData *theData = str ;
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}


+(NSString *) md5Crypte
{
    const NSString * passWord = kMD5PassWord;
    const char *cStr = [passWord UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] uppercaseString];
}

+ (NSString *) md5UTF8: (NSString *) inPutText
{
    NSString *testString = inPutText;
    NSData *testData = [testString dataUsingEncoding: NSUTF8StringEncoding];
    Byte *testByte = (Byte *)[testData bytes];
    
//    for(int i=0;i<[testData length];i++)
        //        printf("testByte = %d\n",testByte[i]);
        
//        NSLog(@"%d", [testData length]) ;
    
   unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(testByte, [testData length], result);
    
    NSData * tempData = [NSData dataWithBytes:result length:16]  ;
    
    NSString * resultStr = @"" ;
    Byte * tempBytes = (Byte * )[tempData bytes] ;
    for (int i = 0; i < [tempData length]; i ++) {
        
        // 转换成16 进制字符串
        NSString * tempStr  = [self ToHex:tempBytes[i]];
//        NSLog(@"%@",tempStr);
        tempStr = [tempStr stringByPaddingToLength:2 withString:@"0" startingAtIndex:0] ;

        resultStr = [resultStr stringByAppendingString:tempStr] ;
    }
    
//    NSLog(@"%@", resultStr) ;
    
    return resultStr;
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


+(NSString*)fileMD5:(NSString*)inPutText
{
    CC_MD5_CTX md5;
    
    CC_MD5_Init(&md5);
    
    BOOL done = NO;
    while(!done)
    {
        NSData* fileData = [inPutText dataUsingEncoding: NSUTF8StringEncoding];
        CC_MD5_Update(&md5, [fileData bytes], [fileData length]);
        if( [fileData length] == 0 ) done = YES;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString* s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0], digest[1],
                   digest[2], digest[3],
                   digest[4], digest[5],
                   digest[6], digest[7],
                   digest[8], digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    return s;
}

@end
