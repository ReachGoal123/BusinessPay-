//
//  PhoneNumberChangeDO.m
//  BusinessPay
//
//  Created by Tears on 14-4-17.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "PhoneNumberChangeDO.h"

@implementation PhoneNumberChangeDO

- (void)phoneNumberChangeRequest
{
//    
//    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                 self.phoneNumberNew,@"NEWPHONENUMBER",
//                                 self.phoneNumber,@"PHONENUMBER",
//                                 self.messageCaptcha,@"RANDOM",
//                                 self.trancode,@"TRANCODE",
//                                 nil];
//    NSString * requestStr = [[User shareUser] encrypt:dic];
    NSString * urlStr = [self appendPosm5URL:self.trancode];
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    //[request setPostValue:requestStr forKey:@"requestParam"];
    NSLog(@"url=%@",url);
    
    [request addPostValue:self.phoneNumberNew forKey:@"NEWPHONENUMBER"];
    NSLog(@"%@",self.phoneNumberNew);
    [request addPostValue:self.phoneNumber forKey:@"PHONENUMBER"];
    [request addPostValue:self.messageCaptcha forKey:@"RANDOM"];
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request setValidatesSecureCertificate:NO] ;
    
    NSLog(@"%@",self.messageCaptcha);
    [request startSynchronous] ;
    NSError *error = [request error];
    
    if (!error) {
        //        NSString *responseString = [request responseString];
        [self decodeOrderDetail:[request responseString]];
        //        NSLog(@"%@", responseString);
    } else {
        if ([self.delegate respondsToSelector:@selector(phoneNumberChangeFailWithMessage:)]) {
            [self.delegate phoneNumberChangeFailWithMessage:@"链接服务器失败"];
        }
    }



}

- (void)phoneNumberChangeMessageVerificationRequest
{
    
//    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                 self.phoneNumberNew,@"PHONENUMBER",
//                                 self.trancode,@"TRANCODE",
//                                 nil];
    //NSString * requestStr = [[User shareUser] encrypt:dic];
    NSString * urlStr = [self appendPosm5URL:self.trancode];
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    //[request setPostValue:requestStr forKey:@"requestParam"];
    [request addPostValue:self.phoneNumberNew forKey:@"PHONENUMBER"];
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:@"2" forKey:@"TRMTYP"];
    [request addPostValue:@"100001" forKey:@"TYPE"];
    
    
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    NSError *error = [request error];
    
    if (!error) {
        [self decodeMessageVerification:[request responseString]];
    } else {
        if ([self.delegate respondsToSelector:@selector(phoneNumberChangeFailWithMessage:)]) {
            [self.delegate phoneNumberChangeFailWithMessage:@"链接服务器失败"];
        }
    }
}

- (void)decodeMessageVerification:(NSString *)content
{
    
    /*
     <?xml version="1.0" encoding="UTF-8"?><EPOSPROTOCOL><PHONENUMBER>15989343631</PHONENUMBER><RSPCOD>000000</RSPCOD><RSPMSG>获取验证码成功</RSPMSG><PACKAGEMAC>CB02696C90C8D7EA044601AC508EFE32</PACKAGEMAC></EPOSPROTOCOL>
     */
    
    NSString * string =  [[User shareUser] decrypt:content];
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    NSString * responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    if ([responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate respondsToSelector:@selector(phoneNumberChangeMessageVerificationSuccessWithMessage:)]) {
            [self.delegate phoneNumberChangeMessageVerificationSuccessWithMessage:responseMessage];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(phoneNumberChangeFailWithMessage:)]) {
            [self.delegate phoneNumberChangeFailWithMessage:responseMessage];
        }
    }
}



- (void)decodeOrderDetail:(NSString *)content
{
    /*
    <?xml version="1.0" encoding="UTF-8"?><EPOSPROTOCOL><RSPCOD>000000</RSPCOD><RSPMSG>商户申请修改手机信息成功</RSPMSG><PACKAGEMAC>06D858AAC26508308D919FE5A5A28F87</PACKAGEMAC></EPOSPROTOCOL>
    */
    
    NSString * string =  [[User shareUser] decrypt:content];
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    NSString * responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    if ([responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate respondsToSelector:@selector(phoneNumberChangeSuccessWithMessage:)]) {
            [self.delegate phoneNumberChangeSuccessWithMessage:responseMessage];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(phoneNumberChangeFailWithMessage:)]) {
            [self.delegate phoneNumberChangeFailWithMessage:responseMessage];
        }
    }
}



@end
