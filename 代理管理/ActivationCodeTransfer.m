//
//  ActivationCodeTransfer.m
//  BusinessPay
//
//  Created by zm on 4/5/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "ActivationCodeTransfer.h"

@implementation ActivationCodeTransfer


-(void)ActivationCodeTransferRequest{
    NSString * urlStr = [self appendPayURL:self.trancode];
    
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.currentAgentNumber forKey:@"AGENTID"];  //当前代理商编号
    [request addPostValue:self.LoginPhoneNum forKey:@"PHONENUMBER"];  //当前登录号码
    [request addPostValue:self.huoBoNumber forKey:@"ALLOTNUM"];  //划拨数量
    [request addPostValue:self.payPassWord forKey:@"ACTPW"];  //支付密码
    [request addPostValue:self.targetAgentNum forKey:@"TOAGENTID"];  //划拨目标代理商
    
    NSLog(@"self.trancode---%@",self.trancode);
    NSLog(@"self.currentAgentNumber---%@",self.currentAgentNumber);
    NSLog(@"self.LoginPhoneNum---%@",self.LoginPhoneNum);
    NSLog(@"self.huoBoNumber---%@",self.huoBoNumber);
    NSLog(@"self.payPassWord---%@",self.payPassWord);
     NSLog(@"self.targetAgentNum---%@",self.targetAgentNum);
    
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    
    NSError *error = [request error];
    
    if (!error) {
        [self decodeValidation:[request responseString]];
    } else {
        NSLog(@"error  = %@", [error description]);
        if ([self.delegate respondsToSelector:@selector(ActivationCodeTransferFildWithMessage:)]) {
            [self.delegate ActivationCodeTransferFildWithMessage:@"连接服务器失败"];
        }
    }
}


-(void)decodeValidation:(NSString *)content{
    
    NSString * string =  [[User shareUser] decrypt:content];
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    _responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    _responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    
    if ([_responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate respondsToSelector:@selector(ActivationCodeTransferSuccessWithMessage:)]) {
            
            [self.delegate ActivationCodeTransferSuccessWithMessage:_responseMessage];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(ActivationCodeTransferFildWithMessage:)]) {
            [self.delegate ActivationCodeTransferFildWithMessage:_responseMessage];
        }
    }
    
}


@end
