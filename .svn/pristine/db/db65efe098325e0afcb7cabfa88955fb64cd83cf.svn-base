//
//  UploadPhotoDO.m
//  BusinessPay
//
//  Created by SHANGYINTONG on 15/4/30.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "UploadPhotoDO.h"

@implementation UploadPhotoDO


-(void)upLoadPhotoRequest
{
    NSString * urlStr = [self appendPosmUploadURL:self.trancode];
    
    NSString *urls=[NSString stringWithFormat:@"%@?IMGNAME=%@",urlStr,self.imageName];
    
    NSURL * url = [NSURL URLWithString:[urls stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request addFile:self.imagePath forKey:@"IMGNAME"];
    
    [request setValidatesSecureCertificate:NO];
    [request setTimeOutSeconds:360];
    [request startSynchronous] ;
    NSLog(@"%i",[request responseStatusCode]);
    NSError *error = [request error];
    if (!error) {
        [self decodeRequest:[request responseString]];
    } else {
        if ([self.delegate respondsToSelector:@selector(upLoadRequestSuccessWithMessage:)]) {
            [self.delegate upLOadRequestFeildWihtMessage:@"链接服务器失败"];
        }
    }
    
}


-(void) decodeRequest:(NSString *)content
{
    NSLog(@"XML=%@",content);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:content options:0 error:&error];
    GDataXMLElement *rootElement= [document rootElement];
    NSString *  responseCode     = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage  = [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    
    self.upLoadImagePath=[[[rootElement elementsForName:@"IMGPATH"] firstObject]stringValue];
    
    
    if ([responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate respondsToSelector:@selector(upLoadRequestSuccessWithMessage:andImagePath:)]) {
            [self.delegate upLoadRequestSuccessWithMessage:responseMessage andImagePath:self.upLoadImagePath];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(upLOadRequestFeildWihtMessage:)]) {
            [self.delegate upLOadRequestFeildWihtMessage:responseMessage];
        }
    }

}

@end
