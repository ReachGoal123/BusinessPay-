//
//  orderCheckDO.m
//  BusinessPay
//
//  Created by SHANGYITONG on 14-12-23.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "orderCheckDO.h"

@implementation orderCheckDO

-(void)orderCheckRequest
{
    NSString *urlStr=[self appendPosm7URL:self.trancode];
    NSURL *url=[NSURL URLWithString:urlStr];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.currentPageNum forKey:@"PAGENUM"];
    [request addPostValue:self.numPerPage forKey:@"NUMPERPAGE"];
    
    [request setValidatesSecureCertificate:NO];
    [request startSynchronous];
    
    NSLog(@"%i",[request responseStatusCode]);
    
    NSError *error;
    if(error==nil)
    {
        [self decodeOrderCheck:[request responseString]];
    }else
    {
        [self.delegate respondsToSelector:@selector(orderCheckFieldWithMessage:)];
        [self.delegate orderCheckFieldWithMessage:@"链接服务器失败"];
    }
    
    
}

-(void) decodeOrderCheck:(NSString *)content
{
    
    //NSLog(@"%@",content);
    NSString * string =  [[User shareUser] decrypt:content];
    
    
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    NSString * responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    
    self.transactionMoney=[[[rootElement elementsForName:@"TXNAMT"] firstObject]stringValue];
    
    self.operstat=[[[rootElement elementsForName:@"OPERSTS"] firstObject]stringValue];
    
    self.operTime=[[[rootElement elementsForName:@"OPERTIM"]firstObject ] stringValue];
    
    
    if([responseCode isEqualToString:kRequestSuccessCode])
    {
        [self.delegate respondsToSelector:@selector(orderCheckResponseSuccessWithMessage:)];
        [self.delegate orderCheckResponseSuccessWithMessage:responseMessage];
        
    }
    else
    {
        [self.delegate respondsToSelector:@selector(orderCheckFieldWithMessage:)];
        [self.delegate orderCheckFieldWithMessage:responseMessage];
    }
    

    

}


@end
