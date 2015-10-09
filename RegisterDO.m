//
//  RegisterDO.m
//  BusinessPay
//
//  Created by Tears on 14-4-11.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "RegisterDO.h"

@implementation RegisterDO

- (void)registerBankNameRequestWithTrancode: (NSString *)trancode
{
    NSString * string = [NSString stringWithFormat:@"%@%@",self.bankCardNumber,kBankCardNumberAppendStr];
    NSLog(@"String=%@",string);
    NSString * track2Str = [string substringToIndex:48];
    NSString * track3Str = [string substringFromIndex:48];
    track2Str = [track2Str stringByReplacingOccurrencesOfString:@"f" withString:@""];
    track2Str = [track2Str stringByReplacingOccurrencesOfString:@"d" withString:@"D"];
    track3Str = [track3Str stringByReplacingOccurrencesOfString:@"f" withString:@""];
    track3Str = [track3Str stringByReplacingOccurrencesOfString:@"d" withString:@"D"];
    
//    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                 self.termno,@"TERMNO",
//                                 track2Str,@"TRACK2",
//                                 track3Str,@"TRACK3",
//                                 nil];
//    NSString * requestStr = [[User shareUser] encrypt:dic];
    
    NSString * urlStr = [self appendPospURL:trancode];
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    //[request setPostValue:requestStr forKey:@"requestParam"];
    //[request addPostValue:self.termno forKey:@"TERMNO"];
    [request addPostValue:track2Str forKey:@"TRACK2"];
    [request addPostValue:track3Str forKey:@"TRACK3"];
    [request setValidatesSecureCertificate:NO] ;
    
    NSLog(@"url=%@",url);
    //NSLog(@"%@",request);
    [request startSynchronous] ;
    NSError *error = [request error];
    
    if (!error) {
        [self decode:[request responseString]];
    } else {
        if ([self.delegate respondsToSelector:@selector(registerResponseFailWithMessage:)]) {
            [self.delegate registerResponseFailWithMessage:@"链接服务器失败"];
        }
    }
}

- (void) decode:(NSString *) content
{
    NSString * string =  [[User shareUser] decrypt:content];
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    RegisterDO * registerDO = [[RegisterDO alloc] init];
    
    registerDO.belongsBankName =[[[rootElement elementsForName:@"ISSNAM"] firstObject] stringValue];
    registerDO.bankID          =[[[rootElement elementsForName:@"ISSNO"] firstObject] stringValue];
    registerDO.responseCode    =[[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    registerDO.responseMessage =[[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    registerDO.cardType        =[[[[[rootElement elementsForName:@"DCFLAG"] firstObject] stringValue] substringFromIndex:1] intValue];
    registerDO.MACValue        =[[[rootElement elementsForName:@"PACKAGEMAC"] firstObject] stringValue];
    NSArray * provinceArr      =[[[rootElement elementsForName:@"TRANDETAILS"] firstObject] elementsForName:@"TRANDETAIL"];
    NSMutableArray * tempArr =[[NSMutableArray alloc] init];
    if ([registerDO.responseCode isEqualToString:kRequestSuccessCode]) {
        for (int i = 0; i < provinceArr.count; i ++) {
            self.provinceDO = [[ProvinceDO alloc] init];
            self.provinceDO.provinceName = [[[[provinceArr objectAtIndex:i] elementsForName:@"PROVNAM"] firstObject] stringValue];
            self.provinceDO.provinceID = [[[[provinceArr objectAtIndex:i] elementsForName:@"PROVID"] firstObject] stringValue];
            [tempArr addObject:self.provinceDO];
            self.provinceDO = nil;
        }
        registerDO.provinceArr = tempArr;
        if ([self.delegate respondsToSelector:@selector(responseSuccess:)]) {
            [self.delegate responseSuccess:registerDO];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(responseFildWithMessage:)]) {
            [self.delegate responseFildWithMessage:registerDO.responseMessage];
        }
    
    }
}

-(void)registerCityNameRequestWithTrancode: (NSString *)trancode andProvinceID:(NSString *)provinceID
{
    
    NSString * urlStr=[self appendPospURL:trancode];
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.termno forKey:@"TERMNO"];
    [request addPostValue:kInquiryCurrentPage forKey:@"PAGENUM"];
    [request addPostValue:kInquiryNumber forKey:@"NUMPERPAGE"];
    
    [request addPostValue:provinceID forKey:@"PROVID"];
    [request setValidatesSecureCertificate:NO];
    [request startSynchronous];
    NSLog(@"url=%@",url);
    
    NSError *error=[request error];
    if (!error) {
                [self decodeCity:[request responseString]];
            } else {
                if ([self.delegate respondsToSelector:@selector(registerResponseFailWithMessage:)]) {
                    [self.delegate registerResponseFailWithMessage:@"链接服务器失败"];
                }
            }
}



- (void)decodeCity :(NSString *)content
{
    NSString * string =  [[User shareUser] decrypt:content];
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    RegisterDO * registerDO = [[RegisterDO alloc] init];
    registerDO.responseCode    =[[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    registerDO.responseMessage =[[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    
    NSArray * cityArr      =[[[rootElement elementsForName:@"TRANDETAILS"] firstObject] elementsForName:@"TRANDETAIL"];
    if ([registerDO.responseCode isEqualToString:kRequestSuccessCode]) {
        NSMutableArray * tempArr =[[NSMutableArray alloc] init];
        for (int i = 0; i < cityArr.count; i ++) {
            self.cityDO = [[CityDO alloc] init];
            self.cityDO.cityName = [[[[cityArr objectAtIndex:i] elementsForName:@"CITYNAM"] firstObject] stringValue];
            self.cityDO.cityID = [[[[cityArr objectAtIndex:i] elementsForName:@"CITYID"] firstObject] stringValue];
            [tempArr addObject:self.cityDO];
            self.cityDO = nil;
        }
        registerDO.cityArr = tempArr;
        if ([self.delegate respondsToSelector:@selector(cityResponseSuccess:)]) {
            [self.delegate cityResponseSuccess:registerDO];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(responseFildWithMessage:)]) {
            [self.delegate responseFildWithMessage:registerDO.responseMessage];
        }
    }
}


- (void)registerSubbranchRequestWithRequester:(ASIFormDataRequest *)request
{
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    NSError *error = [request error];
    
    
    if (!error) {
        //        NSString *responseString = [request responseString];
        [self decodeSubbranch:[request responseString]];
        //        NSLog(@"%@", responseString);
    } else {
        if ([self.delegate respondsToSelector:@selector(registerResponseFailWithMessage:)]) {
            [self.delegate registerResponseFailWithMessage:@"链接服务器失败"];
        }
    }
}



- (void)registerSubbranchRequestWithTrancode: (NSString *)trancode andProvinceID :(NSString *)provinceID andCityID:(NSString *)cityID andBankID:(NSString *)bankID
{
    //NSString * requestStr = [[User shareUser] encrypt:messageDic];
    
    NSString * urlStr = [self appendPospURL:trancode];
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.termno forKey:@"TERMNO"];
    [request addPostValue:kInquiryCurrentPage forKey:@"PAGENUM"];
    [request addPostValue:kInquiryNumber forKey:@"NUMPERPAGE"];
    [request addPostValue:bankID forKey:@"ISSNO"];
    [request addPostValue:provinceID forKey:@"PROVID"];
    [request addPostValue:cityID forKey:@"CITYID"];
    

    NSLog(@"url=%@",url);
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    NSError *error = [request error];
    
    if (!error) {
        
        [self decodeSubbranch:[request responseString]];
              //NSLog(@"%@", [self decodeSubbranch:[ request responseString]]);
    } else {
        if ([self.delegate respondsToSelector:@selector(registerResponseFailWithMessage:)]) {
            [self.delegate registerResponseFailWithMessage:@"链接服务器失败"];
        }
    }

}

- (void)decodeSubbranch :(NSString *)content
{

    NSString * string =  [[User shareUser] decrypt:content];
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    RegisterDO * registerDO = [[RegisterDO alloc] init];
    registerDO.responseCode    =[[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    registerDO.responseMessage =[[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    
    NSArray * subbranchArr      =[[[rootElement elementsForName:@"TRANDETAILS"] firstObject] elementsForName:@"TRANDETAIL"];
    if ([registerDO.responseCode isEqualToString:kRequestSuccessCode]) {
        NSMutableArray * tempArr =[[NSMutableArray alloc] init];
        for (int i = 0; i < subbranchArr.count; i ++) {
            self.subbranchDO = [[SubbranchDO alloc] init];
            self.subbranchDO.subbranchName = [[[[subbranchArr objectAtIndex:i] elementsForName:@"BENELX"] firstObject] stringValue];
            self.subbranchDO.subbranchID = [[[[subbranchArr objectAtIndex:i] elementsForName:@"BKNO"] firstObject] stringValue];
            [tempArr addObject:self.subbranchDO];
            self.subbranchDO = nil;
        }
        registerDO.subbranchArr = tempArr;
        NSLog(@"subbranchArr=%@",registerDO.subbranchArr);
        if ([self.delegate respondsToSelector:@selector(subbranchResponseSuccess:)]) {
            [self.delegate subbranchResponseSuccess:registerDO];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(responseFildWithMessage:)]) {
            [self.delegate responseFildWithMessage:registerDO.responseMessage];
        }
    }
    
}
- (void)registerMessageVerificationRequestWithRequester:(ASIFormDataRequest *)request
{
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    NSError *error = [request error];
    //NSLog(@"%@",[request responseString]);
    
    if (!error) {
        [self decodeMessageVerification:[request responseString]];
    } else {
        if ([self.delegate respondsToSelector:@selector(registerResponseFailWithMessage:)]) {
            [self.delegate registerResponseFailWithMessage:@"链接服务器失败"];
        }
    }
}

//- (void)registerMessageVerificationRequestWithTrancode: (NSString *)trancode andRequestMessage :(NSMutableDictionary *)messageDic
//{
//    //NSString * requestStr = [[User shareUser] encrypt:messageDic];
//    NSString * urlStr = [self appendPosm5URL:trancode];
//    NSURL * url = [NSURL URLWithString:urlStr];
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    //[request setPostValue:requestStr forKey:@"requestParam"];
//    
//    //request addPostValue:<#(id<NSObject>)#> forKey:<#(NSString *)#>
//    
//    [request setValidatesSecureCertificate:NO] ;
//    [request startSynchronous] ;
//    NSError *error = [request error];
//    
//    if (!error) {
//        [self decodeMessageVerification:[request responseString]];
//    } else {
//        if ([self.delegate respondsToSelector:@selector(registerResponseFailWithMessage:)]) {
//            [self.delegate registerResponseFailWithMessage:@"链接服务器失败"];
//        }
//    }
//}

- (void)decodeMessageVerification:(NSString *)content
{
    NSString * string =  [[User shareUser] decrypt:content];
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    RegisterDO * registerDO = [[RegisterDO alloc] init];
    registerDO.verificationPhoneNumber  = [[[rootElement elementsForName:@"PHONENUMBER"] firstObject] stringValue];
    registerDO.responseCode             =[[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSLog(@"%@",registerDO.responseCode);
    registerDO.responseMessage          =[[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    if ([registerDO.responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate respondsToSelector:@selector(messageVerificationSuccessWithMessage:)]) {
            [self.delegate messageVerificationSuccessWithMessage:registerDO.responseMessage];
        }
    }
    else {
        if ([self.delegate respondsToSelector:@selector(registerResponseFailWithMessage:)]) {
            [self.delegate registerResponseFailWithMessage:registerDO.responseMessage];
        }
    }
    
}

- (void)registerRequestWithRequester:(ASIFormDataRequest *)request
{
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    NSError *error = [request error];
    
    if (!error) {
        //        NSString *responseString = [request responseString];
        [self decoderegister:[request responseString]];
        //        NSLog(@"%@", responseString);
    } else {
        if ([self.delegate respondsToSelector:@selector(registerResponseFailWithMessage:)]) {
            [self.delegate registerResponseFailWithMessage:@"链接服务器失败"];
        }
    }

}

//- (void)registerRequestWithTrancode: (NSString *)trancode andRequestMessage :(NSMutableDictionary *)messageDic
//{
//    NSString * requestStr = [[User shareUser] encrypt:messageDic];
//    NSString * urlStr = [self appendPosm5URL:trancode];
//    NSURL * url = [NSURL URLWithString:urlStr];
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    [request setPostValue:requestStr forKey:@"requestParam"];
//    [request setValidatesSecureCertificate:NO] ;
//    [request startSynchronous] ;
//    NSError *error = [request error];
//    
//    if (!error) {
//        //        NSString *responseString = [request responseString];
//        [self decoderegister:[request responseString]];
//        //        NSLog(@"%@", responseString);
//    } else {
//        if ([self.delegate respondsToSelector:@selector(registerResponseFailWithMessage:)]) {
//            [self.delegate registerResponseFailWithMessage:@"链接服务器失败"];
//        }
//    }
//}

- (void)decoderegister:(NSString *)content
{
    NSString * string =  [[User shareUser] decrypt:content];
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    RegisterDO * registerDO = [[RegisterDO alloc] init];
    registerDO.responseCode    =[[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    registerDO.responseMessage =[[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    if ([registerDO.responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate respondsToSelector:@selector(registerSucessWithMessage:)]) {
            [self.delegate registerSucessWithMessage:registerDO.responseMessage];
        }
    }
    else if ([registerDO.responseCode isEqualToString:@"100002"]){
        return;
    }
    else {
        if ([self.delegate respondsToSelector:@selector(registerResponseFailWithMessage:)]) {
            [self.delegate registerResponseFailWithMessage:registerDO.responseMessage];
        }
    }
}

@end
