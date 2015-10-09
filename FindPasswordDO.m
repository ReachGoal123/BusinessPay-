//
//  FindPasswordDO.m
//  BusinessPay
//
//  Created by Tears on 14-4-14.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "FindPasswordDO.h"

@implementation FindPasswordDO

- (void)findPasswordRequest
{
//    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                 self.phoneNumber,@"PHONENUMBER",
//                                 self.messageCaptcha,@"VLIDATECODE",
//                                 self.appType,@"APPTYP",
//                                 self.trancode,@"TRANCODE",
//                                 nil];
//    NSString * requestStr = [[User shareUser] encrypt:dic];
    NSString * urlStr = [self appendPosm5URL:self.trancode];
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    //[request setPostValue:requestStr forKey:@"requestParam"];
    [request addPostValue:self.phoneNumber forKey:@"PHONENUMBER"];
    [request addPostValue:self.messageCaptcha forKey:@"VLIDATECODE"];
    [request addPostValue:self.appType forKey:@"APPTYP"];
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    NSError *error = [request error];
    
    if (!error) {
        [self decodeFindPassword:[request responseString]];
    } else {
        NSLog(@"error  = %@", [error description]);
        if ([self.delegate respondsToSelector:@selector(findPasswordFieldWithMessage:)]) {
            [self.delegate findPasswordFieldWithMessage:@"链接服务器失败"];
        }

}
    
}

- (void)decodeFindPassword:(NSString *)content
{
    
    /*
    <?xml version="1.0" encoding="UTF-8"?><EPOSPROTOCOL><PHONENUMBER>13147047062</PHONENUMBER><RSPCOD>000000</RSPCOD><RSPMSG>验证码匹配成功</RSPMSG><PACKAGEMAC>A28156D33A91C283009AFDF2CCB8D5E0</PACKAGEMAC></EPOSPROTOCOL>
    */
    
    NSString * string =  [[User shareUser] decrypt:content];
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    NSString * responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    if ([responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate respondsToSelector:@selector(findPasswordSuccessWithMessage:)]) {
            [self.delegate findPasswordSuccessWithMessage:responseMessage];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(findPasswordFieldWithMessage:)]) {
            [self.delegate findPasswordFieldWithMessage:responseMessage];
        }
    }
}

- (void)findPasswordMessageVerificationRequest
{
//    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                 self.phoneNumber,@"PHONENUMBER",
//                                 self.IDCard,@"IDCARDNUMBER",
//                                 self.termno,@"TERMNO",
//                                 self.appType,@"APPTYP",
//                                 self.trancode,@"TRANCODE",
//                                 nil];
    //NSString * requestStr = [[User shareUser] encrypt:dic];
    NSString * urlStr = [self appendPosm5URL:self.messageTrancode];
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    //[request setPostValue:requestStr forKey:@"requestParam"];
    [request addPostValue:self.phoneNumber forKey:@"PHONENUMBER"];
    //[request addPostValue:self.IDCard forKey:@"IDCARDNUMBER"];
    [request addPostValue:self.appType forKey:@"APPTYP"];
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    
    [request addPostValue:@"2" forKey:@"TRMTYP"];
    [request addPostValue:@"100001" forKey:@"TYPE"];
    
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    NSError *error = [request error];
    
    if (!error) {
        //        NSString *responseString = [request responseString];
        [self decodeMessage:[request responseString]];
        //        NSLog(@"%@", responseString);
    } else {
        NSLog(@"error  = %@", [error description]);
        if ([self.delegate respondsToSelector:@selector(messageVerificationSuccessFieldWithMessage:)]) {
            [self.delegate messageVerificationSuccessFieldWithMessage:@"连接服务器失败"];
        }

}
}

- (void)decodeMessage:(NSString *)content
{
    NSString * string =  [[User shareUser] decrypt:content];
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    NSString * responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    if ([responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate respondsToSelector:@selector(messageVerificationSuccessWithMessage:)]) {
            [self.delegate messageVerificationSuccessWithMessage:responseMessage];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(messageVerificationSuccessFieldWithMessage:)]) {
            [self.delegate messageVerificationSuccessFieldWithMessage:@"链接服务器失败"];
        }
    }
}


@end
