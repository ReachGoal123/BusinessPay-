//
//  OrderPayDO.m
//  BusinessPay
//
//  Created by Tears on 14-4-17.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "OrderPayDO.h"

@implementation OrderPayDO

- (void)submitOrderRequest
{
//    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                 self.phoneNumber,@"PHONENUMBER",
//                                 self.orderAmount,@"ORDAMT",
//                                 self.commodityName,@"PRDNAME",
//                                 self.commodityPrice,@"PRDUNITPRICE",
//                                 self.quantity,@"BUYCOUNT",
//                                 self.billingCycle,@"STLTYPE",
//                                 self.termno,@"TERMINALNUMBER",
//                                 nil];
    //NSString * requestStr = [[User shareUser] encrypt:dic];
    NSString * urlStr = [self appendPayURL:self.trancode];
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.phoneNumber forKey:@"PHONENUMBER"];
    [request addPostValue:self.menchantNO forKey:@"PRDORDNO"];
    [request addPostValue:self.urlType forKey:@"URLTYPE"];
//    [request addPostValue:self.orderAmount forKey:@"ORDAMT"];
//    [request addPostValue:self.commodityName forKey:@"PRDNAME"];
//    [request addPostValue:self.commodityPrice forKey:@"PRDUNITPRICE"];
//    [request addPostValue:self.quantity forKey:@"BUYCOUNT"];
//    [request addPostValue:self.billingCycle forKey:@"STLTYPE"];
//    [request addPostValue:self.termno forKey:@"TERMINALNUMBER"];
    
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    //NSLog(@"Url=%@",url);
    NSError *error = [request error];
    
    if (!error) {
        [self decodeRealNameVerification:[request responseString]];
    } else {
        NSLog(@"error  = %@", [error description]);
        if ([self.delegate respondsToSelector:@selector(orderPayFailWithMessage:)]) {
            [self.delegate orderPayFailWithMessage:@"连接服务器失败"];
        }
    }
}

-(NSString *)filterHTML:(NSString *)string
{
    NSScanner * scanner = [NSScanner scannerWithString:string];
    NSString * text = nil;
    NSString * text2= nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:&text];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text2];
        //替换字符
        string = [string stringByReplacingOccurrencesOfString:@"&" withString:@"#"];
        
    }
    // NSString * regEx = @"<([^>]*)>";
    // html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return string;
    NSLog(@"%@",string);
}

-(NSString *) filterLink:(NSString *)string
{
    NSString * text = nil;
    NSString * text2= nil;
    NSScanner *scanner=[NSScanner scannerWithString:string];
    while ([scanner isAtEnd]==NO) {
        [scanner scanUpToString:@"h" intoString:&text];
        //找到标签的结束位置
        [scanner scanUpToString:@"D" intoString:&text2];
        
        string=[string stringByReplacingOccurrencesOfString:@"#" withString:@"&"];
    }
    return  string;
}


- (void)decodeRealNameVerification:(NSString *)content
{
    /*
    <?xml version="1.0" encoding="UTF-8"?><EPOSPROTOCOL><PHONENUMBER>13147047062</PHONENUMBER><RSPCOD>000000</RSPCOD><RSPMSG>交易成功</RSPMSG><TN>201404171125260084592</TN><PACKAGEMAC>348124EF5E17EBD066FE2D6342ACBD5E</PACKAGEMAC></EPOSPROTOCOL>
    */
    
    NSString * string =  [[User shareUser] decrypt:content];
    NSLog(@"  XML  === %@",string);
    
    NSString *newString=[self filterHTML:string];
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:newString options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    
    NSString *reurl=[[[rootElement elementsForName:@"REURL"] firstObject] stringValue];
    
    self.reURL=[self filterLink:reurl];
    
    NSString * responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
//    NSString * transactionFlowCode =  [[[rootElement elementsForName:@"TN"] firstObject] stringValue];
    if ([responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate respondsToSelector:@selector(orderPayScuessWithReurl:andMessage:)]) {
            [self.delegate orderPayScuessWithReurl:self.reURL andMessage:responseMessage];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(orderPayFailWithMessage:)]) {
            [self.delegate orderPayFailWithMessage:responseMessage];
        }
    
    }
}


@end
