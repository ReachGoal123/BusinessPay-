//
//  ActivationCodeManagement.m
//  BusinessPay
//
//  Created by zm on 4/5/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "ActivationCodeManagement.h"

@implementation ActivationCodeManagement

-(void)ActivationCodeManagementRequest{
    NSString * urlStr = [self appendPayURL:self.trancode];
    
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.currentAgentNumber forKey:@"AGENTID"];  //当前代理商编号
    [request addPostValue:self.LoginPhoneNum forKey:@"PHONENUMBER"];  //当前登录号码
    
        NSLog(@"self.self.CurrentLoginPhoneNum---%@",self.LoginPhoneNum);
        NSLog(@"self.self.VerifiedNum---%@",self.currentAgentNumber);
        NSLog(@"self.self.trancode---%@",self.trancode);
        NSLog(@"urlStr---%@",urlStr);
    
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    
    NSError *error = [request error];
    
    if (!error) {
        [self decodeValidation:[request responseString]];
    } else {
        NSLog(@"error  = %@", [error description]);
        if ([self.delegate respondsToSelector:@selector(ActivationCodeFildWithMessage:)]) {
            [self.delegate ActivationCodeFildWithMessage:@"连接服务器失败"];
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
    self.user.yihuabo = [[[rootElement elementsForName:@"ALLOTNUM"] firstObject] stringValue];
    self.user.yijihuo  =  [[[rootElement elementsForName:@"ACTIVENUM"] firstObject] stringValue];
    self.user.yishengcheng  =  [[[rootElement elementsForName:@"MAKENUM"] firstObject] stringValue];
    self.user.weishengcheng  =  [[[rootElement elementsForName:@"UNMAKENUM"] firstObject] stringValue];
    _yihuabo  =  [[[rootElement elementsForName:@"ALLOTNUM"] firstObject] stringValue];
    
    NSLog(@"_responseCode---%@",_responseCode);
    NSLog(@"_responseMessage---%@",_responseMessage);
    
    NSLog(@"yihuaboshuliang---%@",_yihuabo);
    
     NSLog(@"self.user.yihuabo---%@",self.user.yihuabo);
    
    if ([_responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate respondsToSelector:@selector(ActivationCodeSuccessWithMessage:)]) {
            
            [self.delegate ActivationCodeSuccessWithMessage:_responseMessage];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(ActivationCodeFildWithMessage:)]) {
            [self.delegate ActivationCodeFildWithMessage:_responseMessage];
        }
    }
    

}


@end
