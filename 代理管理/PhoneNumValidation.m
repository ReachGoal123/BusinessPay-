//
//  PhoneNumValidation.m
//  BusinessPay
//
//  Created by zm on 30/4/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "PhoneNumValidation.h"


@implementation PhoneNumValidation

- (void)phoneNumValidationRequest{
    
    NSString * urlStr = [self appendPayURL:self.trancode];
    
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.CurrentLoginPhoneNum forKey:@"PHONENUMBER"];
    [request addPostValue:self.VerifiedNum forKey:@"CHECKPHONENUM"];
    
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    _error = [request error];
    
    NSLog(@"error  = %@", [_error description]);
    
    if (!_error) {
        [self decodeValidation:[request responseString]];
    } else {
        NSLog(@"error  = %@", [_error description]);
        if ([self.delegate respondsToSelector:@selector(NumberValidationFildWithMessage:)]) {
            [self.delegate NumberValidationFildWithMessage:@"连接服务器失败"];
        }
    }
}


- (void)decodeValidation:(NSString *)content
{
    NSString * string =  [[User shareUser] decrypt:content];
    
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    _responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    _responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    
    NSLog(@"_responseCode---%@",_responseCode);
    NSLog(@"_responseMessage---%@",_responseMessage);
    
    if ([_responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate respondsToSelector:@selector(NumberValidationSuccessWithMessage:)]) {
            
            [self.delegate NumberValidationSuccessWithMessage:_responseMessage];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(NumberValidationFildWithMessage:)]) {
            [self.delegate NumberValidationFildWithMessage:_responseMessage];
        }
    }
}


@end
