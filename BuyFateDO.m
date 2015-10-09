//
//  BuyFateDO.m
//  BusinessPay
//
//  Created by SHANGYITONG on 15-2-28.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BuyFateDO.h"

@implementation BuyFateDO


-(void)buyFateRequest
{
    NSString *urlStr=[self appendPosm7URL:self.trancode];
    NSURL *url=[NSURL URLWithString:urlStr];
    
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.phoneNumber forKey:@"PHONENUMBER"];
    [request addPostValue:self.feedID forKey:@"FEERATNO"];
    [request addPostValue:self.payPassword forKey:@"FORMATCPW"];
    
    [request setValidatesSecureCertificate:NO];
    [request startSynchronous];
    
    NSError *error=[request error];
    if(!error)
    {
        [self decodeBuyFate:[request responseString]];
    }else
    {
        [self.delegate respondsToSelector:@selector(buyFateFieldWithMessage:)];
        [self.delegate buyFateFieldWithMessage:@"链接服务器失败"];
    }

}


-(void) decodeBuyFate:(NSString *) content
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
        [self.delegate respondsToSelector:@selector(buyFateSuccessWithMessage:)];
        [self.delegate buyFateSuccessWithMessage:responseMessage];
    }else
    {
        [self.delegate respondsToSelector:@selector(buyFateFieldWithMessage:)];
        [self.delegate buyFateFieldWithMessage:responseMessage];
        
    }

    
}

@end
