//
//  MerchantDO.m
//  BusinessPay
//
//  Created by Tears on 14-4-16.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "MerchantDO.h"

@implementation MerchantDO

- (void)merchantInformationInquiryRequest
{
//    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                 self.phoneNumber,@"PHONENUMBER",
//                                 self.termno,@"TERMNO",
//                                 self.termType,@"TRMTYP",
//                                 nil];
//    NSString * requestStr = [[User shareUser] encrypt:dic];
    NSString * urlStr = [self appendPosm5URL:self.trancode];
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    //[request setPostValue:requestStr forKey:@"requestParam"];
    [request addPostValue:self.phoneNumber forKey:@"PHONENUMBER"];
    //[request addPostValue:self.termno forKey:@"TERMNO"];
    [request addPostValue:self.termType forKey:@"TRMTYP"];
    
    
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    NSLog(@"merchant=%i",[request responseStatusCode]);
    NSError *error = [request error];
    
    if (!error) {
        //        NSString *responseString = [request responseString];
        [self decodeMerchantInformation:[request responseString]];
        //        NSLog(@"%@", responseString);
    } else {
        if ([self.delegate respondsToSelector:@selector(merchantInformationInquiryFieldWithMessage:)]) {
            [self.delegate merchantInformationInquiryFieldWithMessage:@"链接服务器失败"];
        }
    }

}

- (void)decodeMerchantInformation:(NSString *)content
{
    NSString * string =  [[User shareUser] decrypt:content];
    NSLog(@"mechange result");
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement= [document rootElement];
     self.responseCode     = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage  = [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    
    MerchantDO * merchantDO     = [[MerchantDO alloc] init];
    merchantDO.merchantID       = [[[rootElement elementsForName:@"MERCNUM"] firstObject] stringValue];
    merchantDO.merchantName     = [[[rootElement elementsForName:@"ACTNAM"] firstObject] stringValue];
    [User shareUser].userName=merchantDO.merchantName;
    merchantDO.bankCardNumber   = [[[rootElement elementsForName:@"ACTNO"] firstObject] stringValue];
    merchantDO.bankName         = [[[rootElement elementsForName:@"OPNBNK"] firstObject] stringValue];
    merchantDO.IDCard           = [[[rootElement elementsForName:@"CARDID"] firstObject] stringValue];
    [User shareUser].IDcard=merchantDO.IDCard;
    merchantDO.phoneNumber      = [[[rootElement elementsForName:@"PHONENUMBER"] firstObject] stringValue];
    merchantDO.realNameStatus   = [[[rootElement elementsForName:@"MERSTATUS"] firstObject] stringValue];
    NSLog(@"merchantStatus== %@",merchantDO.realNameStatus);
       if ([self.responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate respondsToSelector:@selector(merchantInformationInquirySuccessWithMessage:andMerchantDO:)]) {
            [self.delegate merchantInformationInquirySuccessWithMessage:responseMessage andMerchantDO:merchantDO];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(merchantInformationInquiryFieldWithMessage:)]) {
            [self.delegate merchantInformationInquiryFieldWithMessage:responseMessage];
        }
    }
}

- (void)bankCardMessageChangeMerchantInformationInquiryRequest
{
//    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                 self.phoneNumber,@"MERNO",
//                                 self.trancode,@"TRANCODE",
//                                 nil];
//    NSString * requestStr = [[User shareUser] encrypt:dic];
    NSString * urlStr = [self appendPospURL:self.trancode];
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    //[request setPostValue:requestStr forKey:@"requestParam"];
    [request addPostValue:self.phoneNumber forKey:@"MERNO"];
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    NSError *error = [request error];
    
    if (!error) {
        [self decodeBankCardMessageChangeMerchantInformation:[request responseString]];
    } else {
        if ([self.delegate respondsToSelector:@selector(merchantInformationInquiryFieldWithMessage:)]) {
            [self.delegate merchantInformationInquiryFieldWithMessage:@"链接服务器失败"];
        }

    }
}

- (void)decodeBankCardMessageChangeMerchantInformation:(NSString *)content
{
    NSString * string =  [[User shareUser] decrypt:content];
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement= [document rootElement];
    NSString * responseCode     = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage  = [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    
    MerchantDO * merchantDO     = [[MerchantDO alloc] init];
    merchantDO.provinceID       = [[[rootElement elementsForName:@"PROVNO"] firstObject] stringValue];
    merchantDO.provinceName     = [[[rootElement elementsForName:@"PROVNAME"] firstObject] stringValue];
    merchantDO.cityID           = [[[rootElement elementsForName:@"CITYID"] firstObject] stringValue];
    merchantDO.cityName         = [[[rootElement elementsForName:@"CITYNAM"] firstObject] stringValue];
    merchantDO.bankID           = [[[rootElement elementsForName:@"ISSNO"] firstObject] stringValue];
    merchantDO.bankName         = [[[rootElement elementsForName:@"ISSNAM"] firstObject] stringValue];
    merchantDO.subbranchID      = [[[rootElement elementsForName:@"BKNO"] firstObject] stringValue];
    merchantDO.subbranchName    = [[[rootElement elementsForName:@"BENELX"] firstObject] stringValue];
    
    if ([responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate respondsToSelector:@selector(merchantBankInformationInquirySuccessWithMessage:andMerchantDO:)]) {
            [self.delegate merchantBankInformationInquirySuccessWithMessage:responseMessage andMerchantDO:merchantDO];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(merchantInformationInquiryFieldWithMessage:)]) {
            [self.delegate merchantInformationInquiryFieldWithMessage:responseMessage];
        }
    }
}

@end
