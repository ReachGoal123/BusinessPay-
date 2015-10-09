//
//  ResetPayPasswordDO.m
//  BusinessPay
//
//  Created by SHANGYITONG on 14-12-24.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "ResetPayPasswordDO.h"

@implementation ResetPayPasswordDO

-(void)reSetPasswordRequest
{
    NSString *urlStr=[self appendPosm7URL:self.trancode];
    NSURL *url=[NSURL URLWithString:urlStr];
    
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.phoneNumber forKey:@"ACTID"];
    [request addPostValue:self.password forKey:@"PASSWORD"];
    
    [request setValidatesSecureCertificate:NO];
    [request startSynchronous];
    
    NSError *error=[request error];
    if(!error)
    {
        [self decodeReSetPassword:[request responseString]];
    }else
    {
        [self.delegate respondsToSelector:@selector(reSetPasswordFieldWithMessage:)];
        [self.delegate reSetPasswordFieldWithMessage:@"链接服务器失败"];
    }

}




-(void)decodeReSetPassword:(NSString *)content
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
        [self.delegate respondsToSelector:@selector(reSetPasswordSuccessWithMessage:)];
        [self.delegate reSetPasswordSuccessWithMessage:responseMessage];
    }else
    {
        [self.delegate respondsToSelector:@selector(reSetPasswordFieldWithMessage:)];
        [self.delegate reSetPasswordFieldWithMessage:responseMessage];
        
    }

}


@end
