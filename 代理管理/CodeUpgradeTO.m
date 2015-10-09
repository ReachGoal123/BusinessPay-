//
//  CodeUpgradeTO.m
//  BusinessPay
//
//  Created by SHANGYINTONG on 15/5/11.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "CodeUpgradeTO.h"

@implementation CodeUpgradeTO

-(void)CodeUpgradeTORequset{

    NSString * urlStr = [self appendPosm7URL:self.trancode];
    
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.trancode forKey:@"TRANCODE"]; //交易码
    [request addPostValue:self.userCode forKey:@"ACTCODE"]; //激活码
    [request addPostValue:self.userTelephone forKey:@"PHONENUMBER"]; //手机号
    [request addPostValue:self.upgradeType forKey:@"FEERATBUYTYP"];  //升级类型
    [request addPostValue:@"" forKey:@"FEERATNO"];  //费率ID
    [request addPostValue:@"" forKey:@"FORMATCPW"];  //支付密码
    
    NSLog(@"self.self.CurrentLoginPhoneNum---%@",self.userTelephone);
    NSLog(@"userCode---%@",self.userCode);
    NSLog(@"self.self.trancode---%@",self.trancode);
    NSLog(@"userTelephone---%@",_userTelephone);
    NSLog(@"upgradeType---%@",_upgradeType);
    
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    
    NSError *error = [request error];
    
    if (!error) {
        [self decodeValidation:[request responseString]];
    } else {
        NSLog(@"error  = %@", [error description]);
        if ([self.delegate respondsToSelector:@selector(CodeUpgradeTOFildWithMessage:)]) {
            [self.delegate CodeUpgradeTOFildWithMessage:@"连接服务器失败"];
        }
    }
}

- (void)decodeValidation:(NSString *)content
{
    NSString * string =  [[User shareUser] decrypt:content];
    
    
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    _responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    _responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    
    NSLog(@"_responseCode---%@",_responseCode);
    NSLog(@"_responseMessage---%@",_responseMessage);
    
    if ([_responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate respondsToSelector:@selector(CodeUpgradeTOSuccessWithMessage:)]) {
            
            [self.delegate CodeUpgradeTOSuccessWithMessage:_responseMessage];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(CodeUpgradeTOFildWithMessage:)]) {
            [self.delegate CodeUpgradeTOFildWithMessage:_responseMessage];
        }
    }
}


@end
