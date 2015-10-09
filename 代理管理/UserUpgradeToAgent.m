//
//  UserUpgradeToAgent.m
//  BusinessPay
//
//  Created by zm on 4/5/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "UserUpgradeToAgent.h"

@implementation UserUpgradeToAgent

-(void)sureUpgradeRequest{
    
    NSString * urlStr = [self appendPayURL:self.trancode];
    
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.toVerifiedNum forKey:@"AGTPHONENUM"];
    [request addPostValue:self.LoginPhoneNum forKey:@"PHONENUMBER"];
    [request addPostValue:self.fateNum forKey:@"FEERATE"];
    
    NSLog(@"self.self.CurrentLoginPhoneNum---%@",self.LoginPhoneNum);
    NSLog(@"self.self.VerifiedNum---%@",self.toVerifiedNum);
    NSLog(@"self.self.trancode---%@",self.trancode);
    NSLog(@"fateNum---%@",_fateNum);
    NSLog(@"urlStr---%@",urlStr);
    
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    
    NSError *error = [request error];
    
    if (!error) {
        [self decodeValidation:[request responseString]];
    } else {
        NSLog(@"error  = %@", [error description]);
        if ([self.delegate respondsToSelector:@selector(UserToAgentFildWithMessage:)]) {
            [self.delegate UserToAgentFildWithMessage:@"连接服务器失败"];
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
        if ([self.delegate respondsToSelector:@selector(UserToAgentSuccessWithMessage:)]) {
            
            [self.delegate UserToAgentSuccessWithMessage:_responseMessage];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(UserToAgentFildWithMessage:)]) {
            [self.delegate UserToAgentFildWithMessage:_responseMessage];
        }
    }
}



@end
