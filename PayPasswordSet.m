//
//  PayPasswordSet.m
//  BusinessPay
//
//  Created by SHANGYITONG on 14-12-23.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "PayPasswordSet.h"

@implementation PayPasswordSet


-(void)payPasswordSetRequest
{
    NSString *urlStr=[self appendPosm7URL:self.trancode];
    NSURL *url=[NSURL URLWithString:urlStr];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    
    
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.phoneNumber forKey:@"ACTID"];
    [request addPostValue:self.password forKey:@"ACTPW"];
    
    [request setValidatesSecureCertificate:NO];
    [request startSynchronous];
    
    NSLog(@"%i",[request responseStatusCode]);
    
    NSError *error = [request error];
    
    if (!error) {
        
        [self decodePayPasswordRequest:[request responseString]];
    } else {
        [self.delegate respondsToSelector:@selector(payPasswordSetFieldWithMessage:)];
        [self.delegate payPasswordSetFieldWithMessage:@"链接服务器失败"];
    }

}



-(void) decodePayPasswordRequest:(NSString *) content
{
    NSLog(@"%@",content);
    NSString * string =  [[User shareUser] decrypt:content];
    
    
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    NSString * responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    
    if([responseCode isEqualToString:kRequestSuccessCode])
    {
        [self.delegate respondsToSelector:@selector(payPasswordSetResponseSuccessWithMessage:)];
        [self.delegate payPasswordSetResponseSuccessWithMessage:responseMessage];
        
    }
    else
    {
        [self.delegate respondsToSelector:@selector(payPasswordSetFieldWithMessage:)];
        [self.delegate payPasswordSetFieldWithMessage:responseMessage];
    }
    

}


@end
