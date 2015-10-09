//
//  WithDrawDO.m
//  BusinessPay
//
//  Created by SHANGYITONG on 14-12-24.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "WithDrawDO.h"

@implementation WithDrawDO


-(void)withDrawRequest
{
    NSString *urlStr=[self appendPosm7URL:self.trancode];
    NSURL *url=[NSURL URLWithString:urlStr];
    //ASIHTTPRequest *request=[request re]
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.phoneNumber forKey:@"ACTID"];
    [request addPostValue:self.txMoney forKey:@"TXNAMT"];
    [request addPostValue:self.payPassword forKey:@"ACTPW"];
    [request addPostValue:self.isUrgency forKey:@"ISURGENT"];
    //[request addPostValue:self.accountCard forKey:@"ACTCARD"];
    
    NSLog(@"url= %@",url);
    [request setValidatesSecureCertificate:NO];
    [request setTimeOutSeconds:20];
    [request startSynchronous];
    
    NSLog(@"%i", [request responseStatusCode]);
    
    NSError *error = [request error];
    
    if (!error) {
        
        [self decodeWithDrawRequest:[request responseString]];
    } else {
        if( [self.delegate respondsToSelector:@selector(withDrawFieldWithMessage:)])
        {
            [self.delegate withDrawFieldWithMessage:@"链接服务器失败"];
        }
    }

}

-(void)decodeWithDrawRequest:(NSString *) content
{
    NSString * string =  [[User shareUser] decrypt:content];
    
    
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    _responeCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    _responeMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];

    if([_responeCode isEqualToString:kRequestSuccessCode])
    {
       if( [self.delegate respondsToSelector:@selector(withDrawResponseSuccessWithMessage:)])
       {
        [self.delegate withDrawResponseSuccessWithMessage:_responeMessage];
       }
    }
    else if([_responeMessage isEqualToString:@"799999"])
    {
//        NSString *moneyString=[responseMessage substringToIndex:13];
//        float money=[moneyString integerValue]/100.f;
        if( [self.delegate respondsToSelector:@selector(withDrawFieldWithMessage:)])
        {
            [self.delegate withDrawFieldWithMessage:@"超出可提现金额"];
        }
    }else
    {
       if( [self.delegate respondsToSelector:@selector(withDrawFieldWithMessage:)])
       {
        [self.delegate withDrawFieldWithMessage:_responeMessage];
       }
        
    }
}


//-(void)payPasswordConfirm
//{
//    NSString *urlStr=[self appendPosm7URL:self.trancode];
//    NSURL *url=[NSURL URLWithString:urlStr];
//    //ASIHTTPRequest *request=[request re]
//    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
//    
//    [request addPostValue:self.trancode forKey:@"TRANCODE"];
//    [request addPostValue:self.phoneNumber forKey:@"ACTID"];
//    [request addPostValue:self.payPassword forKey:@"ACTPW"];
//    
//    NSLog(@"url= %@",url);
//    [request setValidatesSecureCertificate:NO];
//    [request startSynchronous];
//    
//    NSLog(@"%i", [request responseStatusCode]);
//    
//    NSError *error = [request error];
//    
//    if (!error) {
//        
//        [self decodeWithDrawRequest:[request responseString]];
//    } else {
//        NSLog(@"error  = %@", [error description]);
//    }
//
//    
//}

//-(void)decodePayPasswordConfirm:(NSString *) content
//{
//    
//    NSString * string =  [[User shareUser] decrypt:content];
//    
//    
//    NSLog(@"  XML  === %@",string);
//    NSError * error ;
//    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
//    GDataXMLElement *rootElement = [document rootElement];
//    self.payPasswordConfirmResponseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
//    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
//    
////    if([self.payPasswordConfirmResponseCode isEqualToString:kRequestSuccessCode])
////    {
////        [self.delegate respondsToSelector:@selector(payPasswordConfirmResponseSuccessWithMessage:)];
////        [self.delegate payPasswordConfirmResponseSuccessWithMessage: responseMessage];
////    }
////    else
////    {
////        [self.delegate respondsToSelector:@selector(payPasswordConfirmFieldWithMessage:)];
////        [self.delegate payPasswordConfirmFieldWithMessage:responseMessage];
////        
////    }

//}


//-(void)payPasswordConfirmTimes
//{
//    NSString *urlStr=[self appendPosm7URL:self.trancode];
//    NSURL *url=[NSURL URLWithString:urlStr];
//    //ASIHTTPRequest *request=[request re]
//    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
//    
//    [request addPostValue:self.trancode forKey:@"TRANCODE"];
//    [request addPostValue:self.phoneNumber forKey:@"ACTID"];
//    
//    NSLog(@"url= %@",url);
//    [request setValidatesSecureCertificate:NO];
//    [request startSynchronous];
//    
//    NSLog(@"%i", [request responseStatusCode]);
//    
//    NSError *error = [request error];
//    
//    if (!error) {
//        
//        [self decodeWithDrawRequest:[request responseString]];
//    } else {
//        NSLog(@"error  = %@", [error description]);
//    }
//}
//
////-(void)decodePayPasswordConfirmTimes:(NSString *) content
//{
//    NSString * string =  [[User shareUser] decrypt:content];
//    
//    
//    NSLog(@"  XML  === %@",string);
//    NSError * error ;
//    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
//    GDataXMLElement *rootElement = [document rootElement];
//    NSString * responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
//    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
//
//    if([responseCode isEqualToString:kRequestSuccessCode])
//    {
//        [self.delegate respondsToSelector:@selector(PasswordConfirmTimesResponseSuccessWithMessage:)];
//        [self.delegate PasswordConfirmTimesResponseSuccessWithMessage: responseMessage];
//    }
//    else
//    {
//        [self.delegate respondsToSelector:@selector(PasswordConfirmTimesFieldWithMessage:)];
//        [self.delegate PasswordConfirmTimesFieldWithMessage:responseMessage];
//        
//    }

//}


@end
