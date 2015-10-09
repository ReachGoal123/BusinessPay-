//
//  FeedBackDO.m
//  BusinessPay
//
//  Created by SHANGYINTONG on 15/5/4.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "FeedBackDO.h"

@implementation FeedBackDO

-(void)feedBackRequest
{
    NSString *urlStr=[self appendPosm5URL:self.trancode];
    
    NSURL *url=[NSURL URLWithString:urlStr];
    
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.phoneNumber forKey:@"PHONENUMBER"];
    [request addPostValue:self.contactName forKey:@"CONTACTNAME"];
    [request addPostValue:self.email forKey:@"EMAIL"];
    [request addPostValue:self.content forKey:@"CONTENT"];
    [request addPostValue:self.contactType forKey:@"CONTACTTYPE"];
    
    [request setValidatesSecureCertificate:NO];
    [request startSynchronous];
    
    NSError *error=[request error];
    
    if (!error) {
        [self decodeFeedBackRequest:[request responseString]];
    }else
    {
        [self.delegate respondsToSelector:@selector(feedBackRequestFeildWithMessage:)];
        [self.delegate feedBackRequestFeildWithMessage:@"链接服务器失败"];
    }
    
    
}


-(void) decodeFeedBackRequest:(NSString *)content
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
        [self.delegate respondsToSelector:@selector(feedBackRequestSuccessWithMessage:)];
        [self.delegate feedBackRequestSuccessWithMessage:responseMessage];
    }else
    {
        [self.delegate respondsToSelector:@selector(feedBackRequestFeildWithMessage:)];
        [self.delegate feedBackRequestFeildWithMessage:responseMessage];
        
    }

    
    
}
@end
