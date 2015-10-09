//
//  AgentInformationQuery.m
//  BusinessPay
//
//  Created by zm on 5/5/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "AgentInformationQuery.h"

@implementation AgentInformationQuery

-(void)AgentInformationQueryRequest{
    
    
    NSString * urlStr = [self appendPayURL:self.trancode];
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.agentNumber forKey:@"AGENTID"];
    [request addPostValue:self.LoginPhoneNum forKey:@"PHONENUMBER"];
    
    NSLog(@"self.CurrentLoginPhoneNum---%@",self.LoginPhoneNum);
    NSLog(@"self.agentNumber---%@",self.agentNumber);
    NSLog(@"self.trancode---%@",self.trancode);

    NSLog(@"urlStr---%@",urlStr);
    
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    
    NSError *error = [request error];
    
    if (!error) {
        [self decodeInformationQuery:[request responseString]];
    } else {
        NSLog(@"error  = %@", [error description]);
        if ([self.delegate respondsToSelector:@selector(AgentInformationQueryFildWithMessage:)]) {
            [self.delegate AgentInformationQueryFildWithMessage:@"连接服务器失败"];
        }
    }

}

- (void)decodeInformationQuery:(NSString *)content
{
    NSString * string =  [[User shareUser] decrypt:content];
    
    
    NSLog(@"dailishangchaxun  XML  === %@",string);
    NSError * error ;
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    _responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    _responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    self.user.numberHasUsed =  [[[rootElement elementsForName:@"USEDACTCOD"] firstObject] stringValue]; //已使用数量
    self.user.currentYield =  [[[rootElement elementsForName:@"LEFTSHRAMT"] firstObject] stringValue]; //当前收益
    self.user.totalYield =  [[[rootElement elementsForName:@"TOTSHRAMT"] firstObject] stringValue];  //累计收益
    self.user.minimumRate =  [[[rootElement elementsForName:@"MINFEERATE"] firstObject] stringValue];  //最小费率
    self.user.maxRate =  [[[rootElement elementsForName:@"MAXFEERATE"] firstObject] stringValue]; //最大费率
 
    
    NSString *str = [[[rootElement elementsForName:@"NOCARAGTTYP"] firstObject] stringValue]; //等级
    if ([str isEqualToString:@"1"]) {
         self.user.nocaragTeyp = @"普通";
    }else if([str isEqualToString:@"2"]){
         self.user.nocaragTeyp = @"男爵";
    }else if([str isEqualToString:@"3"]){
        self.user.nocaragTeyp = @"伯爵";
    }else if([str isEqualToString:@"4"]){
        self.user.nocaragTeyp = @"公爵";
    }

   self.user.agentName =  [[[rootElement elementsForName:@"AGTNAM"] firstObject] stringValue]; //商户名
    
    NSLog(@"_responseCode---%@",_responseCode);
    NSLog(@"_responseMessage---%@",_responseMessage);
    
    if ([_responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate respondsToSelector:@selector(AgentInformationQuerySuccessWithMessage:)]) {
            
            [self.delegate AgentInformationQuerySuccessWithMessage:_responseMessage];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(AgentInformationQueryFildWithMessage:)]) {
            [self.delegate AgentInformationQueryFildWithMessage:_responseMessage];
        }
    }
}



@end
