//
//  CreateActivationCode.m
//  BusinessPay
//
//  Created by zm on 4/5/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "CreateActivationCode.h"

@implementation CreateActivationCode

-(void)CreateActivationCodeRequest{
    NSString * urlStr = [self appendPayURL:self.trancode];
    
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.currentAgentNumber forKey:@"AGENTID"];  //当前代理商编号
    [request addPostValue:self.LoginPhoneNum forKey:@"PHONENUMBER"];  //当前登录号码
    [request addPostValue:self.PayPassword forKey:@"ACTPW"];  //当前登录号码
    [request addPostValue:self.codeNum forKey:@"MAKEAMOUNT"];  //当前登录号码
    
    NSLog(@"self.trancode---%@",self.trancode);
    NSLog(@"self.currentAgentNumber---%@",self.currentAgentNumber);
    NSLog(@"self.LoginPhoneNum---%@",self.LoginPhoneNum);
    NSLog(@"self.PayPassword---%@",self.PayPassword);
    NSLog(@"self.codeNum---%@",self.codeNum);
    
    
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    
    NSError *error = [request error];
    
    if (!error) {
        [self decodeValidation:[request responseString]];
    } else {
        NSLog(@"error  = %@", [error description]);
        if ([self.delegate respondsToSelector:@selector(CreateActivationCodeFildWithMessage:)]) {
            [self.delegate CreateActivationCodeFildWithMessage:@"连接服务器失败"];
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
    
       NSArray *arr = [[[rootElement elementsForName:@"TRANDETAILS"] firstObject] elementsForName:@"TRANDETAIL"];
    
     _codeArray =[[NSMutableArray alloc] init];
    
    NSLog(@"==========>_responseCode :%@",_responseCode);
    NSLog(@"==========>kRequestSuccessCode :%@",kRequestSuccessCode);
    
    if ([_responseCode isEqualToString:kRequestSuccessCode]) {
        
        if (arr.count > 0){
            for (int i = 0; i < arr.count; i ++) {
                CreateActivationCode *createcode = [[CreateActivationCode alloc]init];
                createcode.creatCodeNum = [[[[arr objectAtIndex:i] elementsForName:@"ACTCODE"] firstObject] stringValue];
                [_codeArray addObject:createcode];
            }
        }
        if ([self.delegate respondsToSelector:@selector(CreateActivationCodeSuccessWithMessage:andArr:)]) {
            
            [self.delegate CreateActivationCodeSuccessWithMessage:_responseMessage andArr:_codeArray];
        }
        
    }
    
    
    else {
        if ([self.delegate respondsToSelector:@selector(CreateActivationCodeFildWithMessage:)]) {
            [self.delegate CreateActivationCodeFildWithMessage:_responseMessage];
        }
    }
}



@end
