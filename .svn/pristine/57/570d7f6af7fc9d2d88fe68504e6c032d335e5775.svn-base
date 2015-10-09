//
//  RechargePhoneDO.m
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-17.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "RechargePhoneDO.h"

@implementation RechargePhoneDO

-(void)rechangePhoneRequest
{
    NSString *urlStr=[self appendPayURL:self.trancode];
    NSURL *url=[NSURL URLWithString:urlStr];
    
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.merchantNum forKey:@"MERCNUM"];
    [request addPostValue:self.proID forKey:@"PRDID"];
    [request addPostValue:self.proType forKey:@"PRDTYPE"];
    [request addPostValue:self.oppositePhoneNumber forKey:@"PHONENUMBER"];
    [request addPostValue:self.reQoperators forKey:@"REQOPERATORS"];
    [request addPostValue:self.payPassword forKey:@"TRAPWD"];
    
    [request setValidatesSecureCertificate:NO];
    [request startSynchronous];
    
    NSError *error=[request error];
    if(!error)
    {
        [self decode:[request responseString]];
    }else
    {
        [self.delegate respondsToSelector:@selector(rechangePhoneFeildWithMessage:)];
        [self.delegate rechangePhoneFeildWithMessage:@"链接服务器失败"];
    }

    
    
    
}


-(void)decode:(NSString *)content
{
    NSString * string =  [[User shareUser] decrypt:content];
    
    
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    _responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    _responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    
    if( [_responseCode isEqualToString:kRequestSuccessCode])
    {
        [self.delegate respondsToSelector:@selector(rechangePhoneSuccessWithMessage:)];
        [self.delegate rechangePhoneSuccessWithMessage:_responseMessage];
    }else
    {
        [self.delegate respondsToSelector:@selector(rechangePhoneFeildWithMessage:)];
        [self.delegate rechangePhoneFeildWithMessage:_responseMessage];
        
    }

}
@end
