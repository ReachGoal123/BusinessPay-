//
//  TransferAccountDO.m
//  BusinessPay
//
//  Created by SHANGYITONG on 15-1-27.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "TransferAccountDO.h"

@implementation TransferAccountDO


-(void)TranferaccountRequest
{
    NSString *urlStr=[self appendPosm7URL:self.trancode];
    NSURL *url=[NSURL URLWithString:urlStr];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    
    
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    //NSLog(@"trancode=%@",self.trancode);
    [request addPostValue:self.phoneNumber forKey:@"OACTID"];
    //NSLog(@"")
    [request addPostValue:self.oppositePhone forKey:@"PACTID"];
    [request addPostValue:self.name forKey:@"PACTNAM"];
    [request addPostValue:self.password forKey:@"ACTPW"];
    [request addPostValue:self.type forKey:@"ACCESSTYP"];
    [request addPostValue:self.money forKey:@"TRANAMT"];
//    NSLog(@"oppositePhone=%@",self.oppositePhone);
//    NSLog(@"name=%@",self.name);
//    NSLog(@"password=%@",self.password);
//    NSLog(@"type=%@",self.type);
//    NSLog(@"money=%@",self.money);
    
    
    NSLog(@"url=%@",url);
    
    [request setValidatesSecureCertificate:NO];
    
    [request startSynchronous];
    
    NSLog(@"statusCode=%i",[request responseStatusCode]);
    
    NSError *error=[request error];
    
    if(!error){
        [self decodeTranferAccount:[request responseString]];
    }else{
        if([self.delegate respondsToSelector:@selector(TranferaccountFieldWithMessage:)])
        {
            [self.delegate TranferaccountFieldWithMessage:@"链接服务器失败"];
        }
    }
    
    
}

-(void)decodeTranferAccount:(NSString *)content
{
    NSString *string=[[User shareUser] decrypt:content];
    
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
     _responeCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
     _responeMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    
    self.checkAmt=[[[rootElement elementsForName:@"CHECKAMT"] firstObject]stringValue];
    self.avaAmt=[[[rootElement elementsForName:@"AVAAMT"] firstObject]stringValue];
    
    
    if ([_responeCode isEqualToString:kRequestSuccessCode]) {
        if([self.delegate respondsToSelector:@selector(TranferaccountResponseSuccessWithMessage:)])
        {
            [self.delegate TranferaccountResponseSuccessWithMessage:_responeMessage];
        }
    }else
    {
        if([self.delegate respondsToSelector:@selector(TranferaccountFieldWithMessage:)])
        {
            [self.delegate TranferaccountFieldWithMessage:_responeMessage];
        }
    }

    
}

@end
