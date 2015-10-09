//
//  OrderCreateDO.m
//  BusinessPay
//
//  Created by SHANGYITONG on 14-12-12.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "OrderCreateDO.h"

@implementation OrderCreateDO

-(void)submitOrderCreateRequest
{
    NSString *urlStr=[self appendPayURL:self.trancode];
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request addPostValue:self.phoneNumber forKey:@"PHONENUMBER"];
    [request addPostValue:self.commodityPrice forKey:@"ORDAMT"];
    [request addPostValue:self.payType forKey:@"PAYTYPE"];
    [request addPostValue:self.commddityName forKey:@"MERORDERNAME"];
    [request addPostValue:self.termno forKey:@"TERMINALNUMBER"];
    [request addPostValue:self.UrlType forKey:@"URLTYPE"];
    [request addPostValue:self.merType forKey:@"MERTYPE"];
    [request addPostValue:@"1.0" forKey:@"VERSION"];
    
    [request setValidatesSecureCertificate:NO];
    [request startSynchronous];
    
    NSLog(@"URL=%@",url);
    
    NSError *error=[request error];
    if(!error)
    {
        [self decodeRealNameVerification:[request responseString]];
    } else {
        NSLog(@"error  = %@", [error description]);
        if ([self.delegate respondsToSelector:@selector(orderCreateFailWithMessage:)]) {
            [self.delegate orderCreateFailWithMessage:@"连接服务器失败"];
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
    NSLog(@"  XML create === %@",string);
    NSError * error ;
    NSString *newString=[self filterHTML:string];
    NSLog(@"%@",newString);
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:newString options:0 error:&error];
    //NSLog(@"%@",document);
    GDataXMLElement *rootElement = [document rootElement];
    //NSLog(@"rootment=%@",rootElement);
    
    //返回码
    NSString * responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
   // NSLog(@"返回码：%@",responseCode);
    //返回信息
    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
   // NSLog(@"返回信息：%@",responseMessage);
    
    
    //订单号
    self.merchantNO=[[[rootElement elementsForName:@"MERORDERID"] firstObject]stringValue];
    
    //NSLog(@"订单号：%@",self.merchantNO);
    //订单时间
    self.merchantDate=[[[rootElement elementsForName:@"MERORDERDATE"] firstObject]stringValue];
   // NSLog(@"订单时间：%@",self.merchantDate);
    //返回url；
    NSString *reurl=[[[rootElement elementsForName:@"REURL"] firstObject]stringValue];
    self.reUrl=[self filterLink:reurl];
    
    NSLog(@"reurl:%@",self.reUrl);
    
    if ([responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate respondsToSelector:@selector(orderCreateSuccessWithMessage:andMerchantId:andMerchantDate:)]) {
            [self.delegate orderCreateSuccessWithMessage:responseMessage andMerchantId:self.merchantNO andMerchantDate:self.merchantDate];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(orderCreateFailWithMessage:)]) {
            [self.delegate orderCreateFailWithMessage:responseMessage];
        }
        
    }
}




@end
