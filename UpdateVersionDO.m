//
//  UpdateVersionDO.m
//  BusinessPay
//
//  Created by SHANGYINTONG on 15-4-2.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "UpdateVersionDO.h"

@implementation UpdateVersionDO

-(void)updateRequest
{
    
     NSDictionary *infoDict = [[NSBundle mainBundle]infoDictionary];   //获取当前版本号
    
    
    NSString * urlStr = [self appendPosm5URL:self.trancode];
    //NSLog(@"%@",urlStr);
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:@"02" forKey:@"CLIENTTYPE"];
    [request addPostValue:[infoDict objectForKey:@"CFBundleShortVersionString"] forKey:@"CURVERSION"];
    [request addPostValue:[[UIDevice currentDevice] systemVersion] forKey:@"IOSVERSION"];
    NSLog(@"phoneVerSion=%@",[[UIDevice currentDevice] systemVersion]);
    
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    NSError *error = [request error];
    
    if (!error) {
        [self decodeUpdate:[request responseString]];
    } else {
        NSLog(@"error  = %@", [error description]);
        if ([self.delegate respondsToSelector:@selector(updateFeildWithMessage:)]) {
            [self.delegate updateFeildWithMessage:@"连接服务器失败"];
        }
    }

    
}


-(void)decodeUpdate:(NSString *)content
{
    NSLog(@" %@",content);
    NSString * string =  [[User shareUser] decrypt:content];
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    
    UpdateVersionDO *updateDO=[[UpdateVersionDO alloc] init];
    
    
    updateDO.isUpdate=[[[rootElement elementsForName:@"ISUPDATE"] firstObject ]stringValue];
    updateDO.updateUrl=[[[rootElement elementsForName:@"UPDURL"] firstObject ]stringValue];
    
    
    NSString * responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    
   
    
    if ([responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate respondsToSelector:@selector(updateSuccessWithMessage:withUpdateVersion:)]) {
            [self.delegate updateSuccessWithMessage:responseMessage withUpdateVersion:updateDO];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(updateFeildWithMessage:)]) {
            [self.delegate updateFeildWithMessage:responseMessage];
        }
    }

}

@end
