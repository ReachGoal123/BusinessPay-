//
//  YiBaoPayChannelDO.m
//  BusinessPay
//
//  Created by SHANGYINTONG on 15/4/27.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "YiBaoPayChannelDO.h"

@implementation YiBaoPayChannelDO


-(void)payRequest
{
    
    NSString *urlStr=[self appendPayURL:self.trancode];
    NSURL *url=[NSURL URLWithString:urlStr];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    
    NSLog(@"payRequest url---%@",url);
    
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.phoneNumber forKey:@"PHONENUMBER"];
    [request addPostValue:self.merType forKey:@"MERTYPE"];
    [request addPostValue:self.cardWay forKey:@"CARDWAY"];
    [request addPostValue:self.orderAmt forKey:@"ORDAMT"];
    [request addPostValue:self.cardTel forKey:@"CARDTEL"];
    [request addPostValue:self.cardType forKey:@"CREDTYPE"];
    [request addPostValue:self.cardNumber forKey:@"CREDCODE"];
    [request addPostValue:self.cardName forKey:@"CARDNAME"];
    [request addPostValue:self.cardCode forKey:@"CARDCODE"];
    [request addPostValue:self.ferID forKey:@"FRPID"];
    [request addPostValue:self.expireYear forKey:@"EXPIREYEAR"];
    [request addPostValue:self.expireMonth forKey:@"EXPIREMONTH"];
    
    NSLog(@"self.expireYear---%@",self.expireYear);
    NSLog(@"self.expireMonth---%@",self.expireMonth);
    
    [request addPostValue:self.cvv forKey:@"CVV"];
    [request addPostValue:self.issuer forKey:@"ISSUER"];
    [request addPostValue:self.isBind forKey:@"isbind"];
    [request addPostValue:self.imagePath forKey:@"IMGPATH"];
    
    [request setValidatesSecureCertificate:NO];
    [request startSynchronous];
    
    
    NSError *error;
    
    if (!error) {
        [self decodePayRequest:[request responseString]];
    } else {
        NSLog(@"error  = %@", [error description]);
        if ([self.delegate respondsToSelector:@selector(payRequestWithFail:)]) {
            [self.delegate payRequestWithFail:@"连接服务器失败"];
        }
    }
    
    
}

-(void)decodePayRequest:(NSString *)content
{
    NSString * string =  [[User shareUser] decrypt:content];
    NSLog(@"  XML  === %@",string);
    
    //NSString *newString=[self filterHTML:string];
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    
   
    
    NSString * responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    //    NSString * transactionFlowCode =  [[[rootElement elementsForName:@"TN"] firstObject]
    
    YiBaoPayChannelDO *yibaoPayChannelDO=[[YiBaoPayChannelDO alloc] init];
    
    yibaoPayChannelDO.clslogNO=[[[rootElement elementsForName:@"CLSLOGNO"] firstObject] stringValue];
    yibaoPayChannelDO.isCheck=[[[rootElement elementsForName:@"ISCHECK"] firstObject] stringValue];
    
    yibaoPayChannelDO.vierifyCode=[[[rootElement elementsForName:@"VERIFYCODE"] firstObject]stringValue];
    
    
    if([responseCode isEqualToString:kRequestSuccessCode])
    {
        if ([self.delegate respondsToSelector:@selector(payRequestWithSuccess:andYibaoPay:)]) {
            [self.delegate payRequestWithSuccess:responseMessage andYibaoPay:yibaoPayChannelDO];
        }
    }else
    {
        if ([self.delegate respondsToSelector:@selector(payRequestWithFail:)]) {
            [self.delegate payRequestWithFail:responseMessage];
        }
    }
    
}


-(void)vierifyMessageRequest
{
    NSString *urlStr=[self appendPayURL:self.trancode];
    NSURL *url=[NSURL URLWithString:urlStr];
    
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.vierifyCode forKey:@"VERIFYCODE"];
    [request addPostValue:self.clslogNO forKey:@"CLSLOGNO"];
    
    [request setValidatesSecureCertificate:NO];
    [request startSynchronous];
    [request setTimeOutSeconds:30];
    
    NSError *error;
    
    if (!error) {
        [self decodeVierifyMessage:[request responseString]];
    } else {
        NSLog(@"error  = %@", [error description]);
        if ([self.delegate respondsToSelector:@selector(vierifyMessageRequestWithFail:)]) {
            [self.delegate vierifyMessageRequestWithFail:@"连接服务器失败"];
        }
    }

    
    
}


-(void) decodeVierifyMessage:(NSString *)content
{
    NSString *string=[[User shareUser] decrypt:content];
    
    NSLog(@"string=%@",string) ;
    
    NSError *error;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    
    NSString * responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    //    NSString * transactionFlowCode =  [[[rootElement elementsForName:@"TN"] firstObject]
    
    if ([responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate respondsToSelector:@selector(vierifyMessageRequestWithSuccess:)]) {
            [self.delegate vierifyMessageRequestWithSuccess:responseMessage];
        }
    }else
    {
        if ([self.delegate respondsToSelector:@selector(vierifyMessageRequestWithFail:)]) {
            [self.delegate vierifyMessageRequestWithFail:responseMessage];
        }
    }
}


-(void)sendMessageRequest
{
    NSString *urlStr=[self appendPayURL:self.trancode];
    
    NSURL *url=[NSURL URLWithString:urlStr];
    
    
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.clslogNO forKey:@"CLSLOGNO"];
    [request addPostValue:self.cardTel forKey:@"CARDTEL"];
    [request addPostValue:self.vierifyCode forKey:@"VERIFYCODE"];
    
    [request setValidatesSecureCertificate:NO];
    [request startSynchronous];
    
    NSError *error;
    
    if (!error) {
        [self decodeGetMessage:[request responseString]];
    }else
    {
        NSLog(@"error=%@",[error description]);
        if ([self.delegate respondsToSelector:@selector(sendMessageRequestWithFail:)]) {
            [self.delegate sendMessageRequestWithFail:@"连接服务器失败"];
        }
    }
}

-(void) decodeGetMessage:(NSString *)content
{
    NSString *string=[[User shareUser] decrypt:content];
    
    
    NSLog(@"string=%@",string) ;
    
    NSError *error;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    
    NSString * responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    //    NSString * transactionFlowCode =  [[[rootElement elementsForName:@"TN"] firstObject]
    
    if ([responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate respondsToSelector:@selector(sendMessageRequestWithSuccess:)]) {
            [self.delegate sendMessageRequestWithSuccess:responseMessage];
        }
    }else
    {
        if ([self.delegate respondsToSelector:@selector(sendMessageRequestWithFail:)]) {
            [self.delegate sendMessageRequestWithFail:responseMessage];
        }
    }

}


@end
