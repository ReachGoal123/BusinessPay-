//
//  RealNameDO.m
//  BusinessPay
//
//  Created by Tears on 14-4-16.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "RealNameDO.h"
//#import "c"

@implementation RealNameDO

- (void)realNameVerificationRequest
{
    
    NSString * urlStr = [self appendPosmUploadURL:self.trancode];
   
    NSString *urls=[NSString stringWithFormat:@"%@?MERCNUM=%@&IDCARDPIC=%@&CUSTPIC=%@&BANKACCOUNT=%@",urlStr,self.merchantNum, self.IDFileName,self.photoFileName,self.bankNumber];

    NSURL * url = [NSURL URLWithString:[urls stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    //NSURL *url=[NSURL URLWithString:urls];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    NSLog(@"url=%@",url);
 

   [request addFile:self.IDCardFaceData forKey:@"IDCARDPIC"];

   [request addFile:self.photoData forKey:@"CUSTPIC"];
    
    //[request addFile:self.bankcardPhotoData forKey:@"FRYHKIMGPATH"];
    
    NSLog(@"idcafa=%@",self.IDCardFaceData);
//    
//   [request setFile:@"/Users/shangyitong/Downloads/1logo@2x.jpeg" forKey:@"CUSTPIC"];
//    [request setFile:@"/Users/shangyitong/Downloads/1Icon.jpeg" forKey:@"IDCARDPIC"];
//
//    NSLog(@"IDPhoto=%@",self.IDCardFaceData);
//    NSLog(@"SencePhoto=%@",self.photoData);
    
    [request setValidatesSecureCertificate:NO];
    [request setTimeOutSeconds:360];
    [request startSynchronous] ;
    NSLog(@"%i",[request responseStatusCode]);
    NSError *error = [request error];
    
    if (!error) {
       
        [self decodeRealNameVerification:[request responseString]];
       
    } else {
        if ([self.delegate respondsToSelector:@selector(realNameVerificationFailWithMessage:)]) {
            [self.delegate realNameVerificationFailWithMessage:@"链接服务器失败"];
        }
    }
}



- (void)decodeRealNameVerification:(NSString *)content
{
    //NSString * string =  [[User shareUser] decrypt:content];
    NSLog(@"  XML  === %@",content);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:content options:0 error:&error];
    //NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 上传成功 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    GDataXMLElement *rootElement = [document rootElement];
    NSString * responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    if ([responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate respondsToSelector:@selector(realNameVerificationSuccessWithMessage:)]) {
            [self.delegate realNameVerificationSuccessWithMessage:responseMessage];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(realNameVerificationFailWithMessage:)]) {
            [self.delegate realNameVerificationFailWithMessage:responseMessage];
        }
    }
}


@end
