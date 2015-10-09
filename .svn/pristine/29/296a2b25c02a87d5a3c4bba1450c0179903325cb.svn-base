//
//  PhoneNumberUploadPhotoDO.m
//  BusinessPay
//
//  Created by SHANGYITONG on 15-1-14.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "PhoneNumberUploadPhotoDO.h"

@implementation PhoneNumberUploadPhotoDO

- (void)phoneNumberUploadChangeRequest
{
    NSString * urlStr = [self appendPosmUploadURL:self.trancode];
    
    NSString *urls=[NSString stringWithFormat:@"%@?MERCNUM=%@&TRANCODE=%@&IDCARDPIC=%@&CUSTPIC=%@&TRMTYP=%@",urlStr,[User shareUser].merchantNum,self.trancode,self.IDFileName,self.photoFileName,@"2"];
    
    NSURL *url=[NSURL URLWithString:urls];
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:url];
    
    NSLog(@"url=%@",url);
    
    
    //    [request addFile:@"/Users/shangyitong/Documents/1@2x.png" forKey:@"CUSTPIC"];
    //    [request addFile:@"/Users/shangyitong/Downloads/userlogin_bg.jpg" forKey:@"IDCARDPIC"];
    
    [request addFile:self.IDFilePath forKey:@"CUSTPIC"];
    [request addFile:self.photoFilePath forKey:@"IDCARDPIC"];
    
    
    [request setValidatesSecureCertificate:NO];
    [request setTimeOutSeconds:360];
    [request startSynchronous] ;
    NSLog(@"%i",[request responseStatusCode]);
    NSError *error = [request error];
    
    if (!error) {
        
        [self decodeOrderDetail:[request responseString]];
        
    } else {
        if ([self.delegate respondsToSelector:@selector(phoneNumberChangeUploadFailWithMessage:)]) {
            [self.delegate phoneNumberChangeUploadFailWithMessage:@"链接服务器失败"];
        }
    }
    
    
}


- (void)decodeOrderDetail:(NSString *)content
{
    
    
    NSLog(@"  XML  === %@",content);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:content options:0 error:&error];
    //NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 上传成功 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    GDataXMLElement *rootElement = [document rootElement];
    NSString * responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    if ([responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate respondsToSelector:@selector(phoneNumberChangeUploadSuccessWithMessage:)]) {
            [self.delegate phoneNumberChangeUploadSuccessWithMessage:responseMessage];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(phoneNumberChangeUploadFailWithMessage:)]) {
            [self.delegate phoneNumberChangeUploadFailWithMessage:responseMessage];
        }
    }

}



@end
