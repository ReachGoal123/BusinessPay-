//
//  AccountDO.m
//  BusinessPay
//
//  Created by SHANGYITONG on 14-12-21.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "AccountDO.h"


@implementation AccountDO

-(void)accountRequest
{
    NSString *urlStr=[self appendPosm7URL:self.trancode];
    NSURL *url=[NSURL URLWithString:urlStr];
    //ASIHTTPRequest *request=[request re]
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.phoneNumber forKey:@"ACTID"];
    NSLog(@"url= %@",url);
    [request setValidatesSecureCertificate:NO];
    [request startSynchronous];
    
    NSLog(@"%i", [request responseStatusCode]);
    
    NSError *error = [request error];
    
    if (!error) {
       
        [self decodeAccount:[request responseString]];
    } else {
        if([self.delegate respondsToSelector:@selector(accountFieldWithMessage:)])
        {
            [self.delegate accountFieldWithMessage:@"链接服务器失败"];
        }
    }


    
}


-(void) decodeAccount:(NSString *)content

//- (void)decodeAccount:(NSString *)content
{
    NSLog(@"%@",content);
    NSString * string =  [[User shareUser] decrypt:content];
    
    
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
   _responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    
    AccountDO *accountDO=[[AccountDO alloc] init];
    
    accountDO.loginStatus=[[[rootElement elementsForName:@"LOGSTS"] firstObject]stringValue];
    
    accountDO.userName=[[[rootElement elementsForName:@"MERNAM"] firstObject]stringValue];
    
    accountDO.accountStatus=[[[rootElement elementsForName:@"ACTSTS"] firstObject]stringValue];
    
    accountDO.totalAccount=[[[rootElement elementsForName:@"TOTAMT"] firstObject] stringValue];
    
    accountDO.fixAccount=[[[rootElement elementsForName:@"FIXAMT"] firstObject] stringValue];
    
    accountDO.checkAccount=[[[rootElement elementsForName:@"CHECHAMT"] firstObject]stringValue];
    
    accountDO.avidAccount =[[[rootElement elementsForName:@"AVAAMT"] firstObject]stringValue];
    
    accountDO.accumulatedIncome=[[[rootElement elementsForName:@"CUMULATIVE"] firstObject]stringValue];
    
    accountDO.yestedayIncome =[[[rootElement elementsForName:@"YESTERINCOM"] firstObject]stringValue];
    
    accountDO.weekIncome=[[[rootElement elementsForName:@"WEEKINCOM"] firstObject ] stringValue];
    
    accountDO.monthIncome=[[[rootElement elementsForName:@"MONTHINCOM"] firstObject ]stringValue];
    
    accountDO.bindCard =[[[rootElement elementsForName:@"ACTCARD"] firstObject ]stringValue];
    
    accountDO.bankName=[[[rootElement elementsForName:@"BANKNAM"] firstObject ]stringValue];
    
    accountDO.typeCard=[[[rootElement elementsForName:@"CRDFLG"] firstObject ]stringValue];
    
    
    if([self.responseCode isEqualToString:kRequestSuccessCode])
    {
        [self.delegate respondsToSelector:@selector(accountResponseSuccessWithMessage:withAccount:)];
        [self.delegate accountResponseSuccessWithMessage:responseMessage withAccount:accountDO];
        
    }
    else
    {
        if([self.delegate respondsToSelector:@selector(accountFieldWithMessage:)])
        {
        [self.delegate accountFieldWithMessage:responseMessage];
        }
    }
   
    
}

@end
