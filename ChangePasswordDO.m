//
//  ChangePasswordDO.m
//  BusinessPay
//
//  Created by Tears on 14-4-15.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "ChangePasswordDO.h"

@implementation ChangePasswordDO

- (void)changePasswordRequest
{
//    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                 self.phoneNumber,@"PHONENUMBER",
//                                 self.oldPassword,@"PASSWORD",
//                                 self.passWordnew,@"PASSWORDNEW",
//                                 nil];
//    NSString * requestStr = [[User shareUser] encrypt:dic];
    NSString * urlStr = [self appendPosm5URL:self.trancode];
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    //[request setPostValue:requestStr forKey:@"requestParam"];
    [request addPostValue:self.phoneNumber forKey:@"PHONENUMBER"];
    [request addPostValue:self.oldPassword forKey:@"PASSWORD"];
    [request addPostValue:self.passWordnew forKey:@"PASSWORDNEW"];
    
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    NSError *error = [request error];
    
    if (!error) {
        [self decodechangePassword:[request responseString]];
    } else {
        if ([self.delegate respondsToSelector:@selector(changePasswordFieldWithMessage:)]) {
            [self.delegate changePasswordFieldWithMessage:@"链接服务器失败"];
        }
    }
}

- (void)decodechangePassword:(NSString *)content
{
    NSString * string =  [[User shareUser] decrypt:content];
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    NSString * responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    if ([responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate respondsToSelector:@selector(changePasswordSuccessWithMessage:)]) {
            [self.delegate changePasswordSuccessWithMessage:responseMessage];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(changePasswordFieldWithMessage:)]) {
            [self.delegate changePasswordFieldWithMessage:responseMessage];
        }
    }
}

- (void)changePasswordAfterVerificationRequest
{
/*
    <?xml version="1.0" encoding="UTF-8"?><EPOSPROTOCOL><PHONENUMBER>13147047062</PHONENUMBER><RSPCOD>000000</RSPCOD><RSPMSG>密码修改成功</RSPMSG><PACKAGEMAC>5FCBB378745879EBC39D138C50296AAB</PACKAGEMAC></EPOSPROTOCOL>
*/
    
//    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                 self.phoneNumber,@"PHONENUMBER",
//                                 self.passWordnew,@"PASSWORD",
//                                 self.trancode,@"TRANCODE",
//                                 nil];
    //NSString * requestStr = [[User shareUser] encrypt:dic];
    NSString * urlStr = [self appendPosm5URL:self.trancode];
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    //[request setPostValue:requestStr forKey:@"requestParam"];
    [request addPostValue:self.phoneNumber forKey:@"PHONENUMBER"];
    [request addPostValue:self.passWordnew forKey:@"PASSWORD"];
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    NSError *error = [request error];
    
    if (!error) {
        [self decodechangePassword:[request responseString]];
    } else {
        if ([self.delegate respondsToSelector:@selector(changePasswordFieldWithMessage:)]) {
            [self.delegate changePasswordFieldWithMessage:@"链接服务器失败"];
        }    }
}


@end
