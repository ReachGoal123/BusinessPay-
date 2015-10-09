//
//  PayPasswordChange.m
//  BusinessPay
//
//  Created by SHANGYITONG on 14-12-23.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "PayPasswordChange.h"

@implementation PayPasswordChange

-(void)payPasswordChangeRequest
{
    
    NSString *urlStr=[self appendPosm7URL:self.trancode];
    NSURL *url=[NSURL URLWithString:urlStr];
    //ASIHTTPRequest *request=[request re]
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.phoneNumber forKey:@"ACTID"];
    [request addPostValue:self.oldPassword forKey:@"OLDACTPW"];
    [request addPostValue:self.Passwords forKey:@"NEWACTPW"];
    
    NSLog(@"url= %@",url);
    [request setValidatesSecureCertificate:NO];
    [request startSynchronous];
    
    NSLog(@"%i", [request responseStatusCode]);
    
    NSError *error = [request error];
    
    if (!error) {
        
        [self decodePasswordChange:[request responseString]];
    } else {
        [self.delegate respondsToSelector:@selector(payPasswordChangeFieldWithMessage:)];
        [self.delegate payPasswordChangeFieldWithMessage:@"链接服务器失败"];
    }
    

}





-(void) decodePasswordChange:(NSString *)content
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
        [self.delegate respondsToSelector:@selector(payPasswordChangeResponseSuccessWithMessage:)];
        [self.delegate payPasswordChangeResponseSuccessWithMessage:responseMessage];
        
    }
    else
    {
        [self.delegate respondsToSelector:@selector(payPasswordChangeFieldWithMessage:)];
        [self.delegate payPasswordChangeFieldWithMessage:responseMessage];
    }

    
}


@end
