//
//  FateChange.m
//  BusinessPay
//
//  Created by zm on 7/5/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "FateChange.h"

@implementation FateChange

-(void)FateChangeRequest{
    NSString * urlStr = [self appendPayURL:self.trancode];
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.childAgengNum forKey:@"AGENTID"];
    [request addPostValue:self.phoneNumstr forKey:@"PHONENUMBER"];
    [request addPostValue:self.childFate forKey:@"FEERATE"];
  
    
    NSLog(@"phongeNumber---%@",self.phoneNumstr);
    NSLog(@"self.agentNumber---%@",self.childAgengNum);
    NSLog(@"self.trancode---%@",self.trancode);
    NSLog(@"urlStr---%@",urlStr);
    NSLog(@"childFate---%@",_childFate);
    
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    
    NSError *error = [request error];
    
    if (!error) {
        [self decodeInformationQuery:[request responseString]];
    } else {
        NSLog(@"error  = %@", [error description]);
        if ([self.delegate respondsToSelector:@selector(FateChangeFildWithMessage:)]) {
            [self.delegate FateChangeFildWithMessage:@"连接服务器失败"];
        }
    }
}


- (void)decodeInformationQuery:(NSString *)content
{
    NSString * string =  [[User shareUser] decrypt:content];
    
    
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    _responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    _responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    if ([_responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate respondsToSelector:@selector(FateChangeSuccessWithMessage:)]) {
            
            [self.delegate FateChangeSuccessWithMessage:_responseMessage];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(FateChangeFildWithMessage:)]) {
            [self.delegate FateChangeFildWithMessage:_responseMessage];
        }
    }
    
}


@end
