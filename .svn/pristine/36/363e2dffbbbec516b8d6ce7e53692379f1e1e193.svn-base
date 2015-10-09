//
//  TerminalVerificationDO.m
//  BusinessPay
//
//  Created by Tears on 14-4-17.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "TerminalVerificationDO.h"

@implementation TerminalVerificationDO

- (void)terminalVerificationRequest
{
//    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                 self.trancode,@"TRANCODE",
//                                 self.termno,@"TERMNO",
//                                 self.userLoginName,@"BSOPERID",
//                                 self.appType,@"APPTYP",
//                                 self.phoneNumber,@"PHONENUMBER",
//                                 nil];
    //NSString * requestStr = [[User shareUser] encrypt:dic];
    NSString * urlStr = [self appendPosm5URL:self.trancode];
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    //[request setPostValue:requestStr forKey:@"requestParam"];
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.termno forKey:@"TERMNO"];
    [request addPostValue:self.userLoginName forKey:@"BSOPERID"];
    [request addPostValue:self.appType forKey:@"APPTYP"];
    [request addPostValue:self.phoneNumber forKey:@"PHONENUMBER"];
    
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    NSError *error = [request error];
    
    if (!error) {
        [self decodeOrderDetail:[request responseString]];
    } else {
        if ([self.delegate  respondsToSelector:@selector(terminalVerificationFieldWithMessage:)]) {
            [self.delegate terminalVerificationFieldWithMessage:@"链接服务器失败"];
        }
    }
}

- (void)decodeOrderDetail:(NSString *)content
{
    /*
     <?xml version="1.0" encoding="UTF-8"?><EPOSPROTOCOL><RSPCOD>000002</RSPCOD><RSPMSG>该终端已注册,不能重复注册</RSPMSG><PACKAGEMAC>C180E50DC581E958A3A3FE7E1F4AEC8B</PACKAGEMAC></EPOSPROTOCOL>
     
     */
    
    NSString * string =  [[User shareUser] decrypt:content];
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    NSString * responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    if ([responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate respondsToSelector:@selector(terminalVerificationResponseScuess)]) {
            [self.delegate terminalVerificationResponseScuess];
        }
    } else {
        if ([self.delegate  respondsToSelector:@selector(terminalVerificationFieldWithMessage:)]) {
            [self.delegate terminalVerificationFieldWithMessage:responseMessage];
        }
    }
}


@end
