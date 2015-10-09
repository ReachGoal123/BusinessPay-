//
//  FindPayPasswordDO.m
//  BusinessPay
//
//  Created by SHANGYITONG on 14-12-24.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "FindPayPasswordDO.h"

@implementation FindPayPasswordDO

-(void)findPayPasswordRequest
{
    NSString *urlStr=[self appendPosm7URL:self.trancode];
    NSURL *url=[NSURL URLWithString:urlStr];
    
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.phoneNumber forKey:@"ACTID"];
    [request addPostValue:self.messageVerCode forKey:@"VLIDATECODE"];
    [request addPostValue:self.IDCard forKey:@"IDCODE"];
    
    
    [request setValidatesSecureCertificate:NO];
    [request startSynchronous];
    
    NSLog(@"%i",[request responseStatusCode]);
    
    NSError *error=[request error];
    if(!error)
    {
        [self decodePayPassword:[request responseString]];
    }else
    {
        [self.delegate respondsToSelector:@selector(findPayPasswordFieldWithMessage:)];
        [self.delegate findPayPasswordFieldWithMessage:@"链接服务器失败"];

        
    }
    
}




-(void) decodePayPassword:(NSString *) content
{
    NSString * string =  [[User shareUser] decrypt:content];
    
    
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    NSString * responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    
    if( [responseCode isEqualToString:kRequestSuccessCode])
    {
        [self.delegate respondsToSelector:@selector(findPayPasswordSuccessWithMessage:)];
        [self.delegate findPayPasswordSuccessWithMessage:responseMessage];
    }else
    {
        [self.delegate respondsToSelector:@selector(findPayPasswordFieldWithMessage:)];
        [self.delegate findPayPasswordFieldWithMessage:responseMessage];
        
    }
}



-(void)findPayPasswordMessageVerificationRequest
{
    NSString *urlStr=[self appendPosm7URL:self.trancode];
    NSURL *url=[NSURL URLWithString:urlStr];
    
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.phoneNumber forKey:@"ACTID"];
    [request addPostValue:@"2" forKey:@"TRMTYP"];
    [request addPostValue:@"100001" forKey:@"TYPE"];
    [request addPostValue:self.IDCard forKey:@"IDCODE"];
    //[request addPostValue:self.phoneNumber.text forKey:@"PHONENUMBER"];
    
    [request setValidatesSecureCertificate:NO];
    NSLog( @"stact=%i",[request responseStatusCode]);
    [request startSynchronous];
    
    NSError *error=[request error];
    if(!error)
    {
        [self decodeMessageVerfication:[request responseString]];
    }else
    {
        [self.delegate respondsToSelector:@selector(messageVerificationFieldWithMessage:)];
        [self.delegate messageVerificationFieldWithMessage:@"链接服务器失败"];
    }

}



-(void) decodeMessageVerfication:(NSString *)content
{
    NSString * string =  [[User shareUser] decrypt:content];
    
    
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    NSString * responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    
    if( [responseCode isEqualToString:kRequestSuccessCode])
    {
        [self.delegate respondsToSelector:@selector(messageVerificationSuccessWithMessage:)];
        [self.delegate messageVerificationSuccessWithMessage:responseMessage];
    }else
    {
        [self.delegate respondsToSelector:@selector(messageVerificationFieldWithMessage:)];
        [self.delegate messageVerificationFieldWithMessage:responseMessage];
        
    }

}



@end
