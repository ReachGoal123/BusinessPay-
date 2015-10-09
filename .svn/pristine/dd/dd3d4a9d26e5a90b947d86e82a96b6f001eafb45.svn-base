//
//  BankUploadPhotoDO.m
//  BusinessPay
//
//  Created by SHANGYITONG on 15-1-5.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BankUploadPhotoDO.h"

@implementation BankUploadPhotoDO

-(void)upLoadRequest
{
     NSString * urlStr = [self appendPosmUploadURL:self.trancode];
    
    NSString *urls=[NSString stringWithFormat:@"%@?MERCNUM=%@&TRANCODE=%@&IDCARDPIC=%@&CUSTPIC=%@&TRMTYP=%@",urlStr,[User shareUser].merchantNum,self.trancode,self.IDFileName,self.photoFileName,@"2"];
    
    NSURL *url=[NSURL URLWithString:urls];
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:url];
    
    NSLog(@"url=%@",url);
    
    [request addFile:self.IDFilePath forKey:@"CUSTPIC"];
    [request addFile:self.photoFilePath forKey:@"IDCARDPIC"];
    
    
    [request setValidatesSecureCertificate:NO];
    [request setTimeOutSeconds:360];
    [request startSynchronous] ;
    NSLog(@"%i",[request responseStatusCode]);
    NSError *error = [request error];
    
    if (!error) {
        
        [self decodeUploadPhoth:[request responseString]];
        
    } else {
        if ([self.delegate respondsToSelector:@selector(upLoadPhotoFailWithMessage:)]) {
            [self.delegate upLoadPhotoFailWithMessage:@"链接服务器失败"];
        }
    }

}


-(void)decodeUploadPhoth:(NSString *)content
{
    NSLog(@"  XML  === %@",content);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:content options:0 error:&error];
    //NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 上传成功 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    GDataXMLElement *rootElement = [document rootElement];
    NSString * responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    if ([responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate respondsToSelector:@selector(upLoadPhotoSuccessWithMessage:)]) {
            [self.delegate upLoadPhotoSuccessWithMessage:responseMessage];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(upLoadPhotoFailWithMessage:)]) {
            [self.delegate upLoadPhotoFailWithMessage:responseMessage];
        }
    }
}

@end
