//
//  XOR.m
//  Test5.1
//
//  Created by Tears on 14-4-2.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "XOR.h"

@implementation XOR

+ (NSString *) XOREncrypt:(NSString *) data
{
    NSString * result = @"" ;
    NSString * key =  kXORKey;
    int j = 0 ;
    for (int i = 0; i < data.length; i ++)
    {
        if (j == key.length)
        {
            j = 0 ;
        }
        
        //  截取字符串中的 字符 ( 't' )
        unichar dataChar = [data characterAtIndex:i] ;
        unichar keyChar = [key characterAtIndex:j] ;
        
        //  将 keyChar 和 dataChar 进行运算 (转换成2进制 进行 0001 0101 和 0101 0010  不同取1 ,相同取0)
        unichar tempChar = dataChar ^ keyChar ;
        
//        NSLog(@"%C", dataChar) ;
//        NSLog(@"%C", keyChar) ;
//        NSLog(@"%d", dataChar) ;
//        NSLog(@"%d", keyChar) ;
//        NSLog(@"==%d==", tempChar) ;
        
        // 转换成16进制的字符串
        NSString * tempStr = [self ToHex:tempChar] ;
        
        tempStr = [tempStr stringByPaddingToLength:2 withString:@"0" startingAtIndex:0] ;
        
        result = [result stringByAppendingString:tempStr] ;
        
        j ++ ;
    }
    return [result lowercaseString];
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
