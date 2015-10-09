//
//  BankCardChangeDO.m
//  BusinessPay
//
//  Created by Tears on 14-4-16.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "BankCardChangeDO.h"

@implementation BankCardChangeDO

- (void)bankCardChangeApplicationRequest
{

//    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                 self.phoneNumber,@"PHONENUMBER",
//                                 self.bankName,@"OPNBNK",
//                                 self.provinceID,@"OPNBNKPRO",
//                                 self.trancode,@"TRANCODE",
//                                 self.cityID,@"OPNBNKCITY",
//                                 self.subbranchID,@"OPNBNKBRA",
//                                 self.userName,@"ACTNAM",
//                                 self.cardNumber,@"ACTNO",
//                                 self.trancode,@"TRANCODE",
//                                 nil];
//    NSString * requestStr = [[User shareUser] encrypt:dic];
    NSString * urlStr = [self appendPosm5URL:self.trancode];
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    //[request setPostValue:requestStr forKey:@"requestParam"];
    [request addPostValue:self.phoneNumber forKey:@"PHONENUMBER"];
    [request addPostValue:self.bankName forKey:@"OPNBNK"];
    [request addPostValue:self.provinceID forKey:@"OPNBNKPRO"];
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.cityID forKey:@"OPNBNKCITY"];
    [request addPostValue:self.subbranchID forKey:@"OPNBNKBRA"];
    [request addPostValue:self.userName forKey:@"ACTNAM"];
    
    
    NSLog(@"self.username=%@",self.userName);
    [request addPostValue:self.cardNumber forKey:@"ACTNO"];
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    NSError *error = [request error];
    
    if (!error) {
        //        NSString *responseString = [request responseString];
        [self decodebankCardChangeApplication:[request responseString]];
        //        NSLog(@"%@", responseString);
    } else {
        if ([self.delegate respondsToSelector:@selector(changFailWithMessage:)]) {
            [self.delegate changFailWithMessage:@"链接服务器失败"];
        }

    }
}

- (void)decodebankCardChangeApplication:(NSString *)content
{
    /*
    <?xml version="1.0" encoding="UTF-8"?><EPOSPROTOCOL><PHONENUMBER>13147047062</PHONENUMBER><RSPCOD>000000</RSPCOD><RSPMSG>提交申请成功,请耐心等待审核！</RSPMSG><PACKAGEMAC>C58F8AB4531BF70863FA03B9C94389C2</PACKAGEMAC></EPOSPROTOCOL>
    */
     
    NSString * string =  [[User shareUser] decrypt:content];
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    NSString * responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    if ([responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate  respondsToSelector:@selector(changSuccessWithMessage:)]) {
            [self.delegate changSuccessWithMessage:responseMessage];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(changFailWithMessage:)]) {
            [self.delegate changFailWithMessage:responseMessage];
        }
    }
}


@end
