//
//  LoginDO.m
//  BusinessPay
//
//  Created by Tears on 14-4-11.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "LoginDO.h"
#import "MerchantInfo.h"
#import "SqliteDatabase.h"


@implementation LoginDO

- (void)loginRequest
{
    NSDictionary *infoDict = [[NSBundle mainBundle]infoDictionary];
    
    NSString * urlStr = [self appendPosm5URL:self.trancode];
//    NSLog(@"loging---%@",urlStr);
      if ( [urlStr isEqualToString:@"http://183.63.52.147:8092/mpay/199002.tran7"] ) {
          [User shareUser].loginType = @"1" ;
    }  

    NSURL * url = [NSURL URLWithString:urlStr];

    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
   
    request.delegate = self;
    //[request setPostValue:requestStr forKey:@"requestParam"];
    [request addPostValue:self.userNamePhoneNumber forKey:@"PHONENUMBER"];
    [request addPostValue:self.passWord forKey:@"PASSWORD"];
    [User shareUser].passWord=self.passWord;                      //保存用户密码，用户手势登录
    [request addPostValue:self.SIMNumber forKey:@"PCSIM"];      
    [request addPostValue:self.appType forKey:@"APPTYP"];
    [request addPostValue:self.trancode forKey:@"TERMINALNUMBER"];
    [request addPostValue:@"2" forKey:@"CLIENTTYPE"];
    
     //推送所需的userID,channelID
    [request addPostValue:[User shareUser].appUserID forKey:@"APPUSERID"];
    [request addPostValue:[User shareUser].appChannelID forKey:@"APPCHANNELID"];
    
    [request addPostValue:[infoDict objectForKey:@"CFBundleShortVersionString"] forKey:@"CURVERSION"];
    
    
    [request addPostValue:[[UIDevice currentDevice] systemVersion] forKey:@"IOSVERSION"];
    NSLog(@"url=%@",url);
    NSLog(@"app版本号：%@",[infoDict objectForKey:@"CFBundleShortVersionString"]);
    //NSLog(@"request=%@",request);
    [request setValidatesSecureCertificate:NO] ;
    
    [request startAsynchronous] ;
    
//    _error = [request error];
//    
//    if (!_error) {
//         [self decodeLogin:[request responseString]];
//    } else {
//        if ([self.delegate respondsToSelector:@selector(loginFildWithMessage:)]) {
//            [self.delegate loginFildWithMessage:@"连接服务器失败"];
//        }
//    }

}

-(void)requestFinished:(ASIHTTPRequest *)request{
    
    [self decodeLogin:[request responseString]];
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    if ([self.delegate respondsToSelector:@selector(loginFildWithMessage:)]) {
        [self.delegate loginFildWithMessage:@"连接服务器失败"];
    }
    
}




- (void)decodeLogin:(NSString *)content
{
    NSString * string =  [[User shareUser] decrypt:content];
    NSLog(@"login result");
    
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    MerchantInfo *merchantInfo=[MerchantInfo stringManager];
    
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    _responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    _responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    self.user.termno = [[[rootElement elementsForName:@"TERMINALNUMBER"] firstObject] stringValue];
    self.user.phoneNumber = [[[rootElement elementsForName:@"PHONENUMBER"] firstObject] stringValue];
    self.user.merchantNum=[[[rootElement elementsForName:@"MERCNUM"] firstObject] stringValue];
    
    //self.user.upminFate=[[[rootElement elementsForName:@"OEMFEERATE"] firstObject] stringValue];//修改下级代理最低费率
    
    self.user.currolstr = [[[rootElement elementsForName:@"CURROL"] firstObject] stringValue]; //角色信息，0普通用户 1代理
    
    
    NSLog(@"self.user.phoneNumber---%@",self.user.phoneNumber);
    NSLog(@"currolstr---%@",self.user.currolstr);
    
    if ([self.user.currolstr isEqualToString:@"1"]) {
        self.user.agentNumber = [[[rootElement elementsForName:@"AGENTID"] firstObject] stringValue]; //代理编号
        
        
        NSLog(@"self.user.agentNumber---%@",self.user.agentNumber);
    }

    
    NSString *verification=[[[rootElement elementsForName:@"MERSTS"] firstObject] stringValue];
    self.user.verificationStatus=[verification intValue];
    NSLog(@"%@",verification);
    
    NSLog(@"verificationStatus=  %i",self.user.verificationStatus);
    merchantInfo.merchantNum=[[[rootElement elementsForName:@"MERCNUM"] firstObject]stringValue];
    
    //if ([[[rootElement elementsForName:@"STS"] firstObject]stringValue]) {
    self.user.status=[[[[rootElement elementsForName:@"STS"] firstObject]stringValue] intValue];
   
     self.user.reChangeStutas=[[[[rootElement elementsForName:@"TXNSTS"]firstObject ]stringValue] intValue];
    //NSLog(@"STS=%i",self.user.status);
    if ([[[rootElement elementsForName:@"LOGNUM"] firstObject]stringValue]){
        self.user.loginNum=[[[[rootElement elementsForName:@"LOGNUM"] firstObject]stringValue]intValue];
    }else
    {
        self.user.loginNum=-1;
    }
   // NSLog(@"LOGNUM=%i",self.user.loginNum);//费率
    self.user.nocCardFeeRete=[[[rootElement elementsForName:@"NOCARDFEERATE"] firstObject]stringValue];
    
    //上传相片返回状态值
    if([[[rootElement elementsForName:@"IDCARDPICSTA"]firstObject]stringValue] ){
        self.user.idcardSts=[[[[rootElement elementsForName:@"IDCARDPICSTA"]firstObject]stringValue]intValue];
    }else{
        self.user.idcardSts=1;
    }
    
    if ([[[rootElement elementsForName:@"CUSTPICSTA"] firstObject]stringValue]) {
        self.user.senceSts=[[[[rootElement elementsForName:@"CUSTPICSTA"] firstObject]stringValue] intValue];
    }else
    {
        self.user.senceSts=1;
    }
    if ([[[rootElement elementsForName:@"FRYHKIMGPATHSTA"] firstObject]stringValue]) {
        self.user.bankCardSts=[[[[rootElement elementsForName:@"FRYHKIMGPATHSTA"] firstObject]stringValue] intValue];
        
    }else
    {
        self.user.bankCardSts=1;
    }

    
    
       
    if ([_responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate respondsToSelector:@selector(loginSuccessWithMessage:)]) {
            [self.delegate loginSuccessWithMessage:_responseMessage];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(loginFildWithMessage:)]) {
            [self.delegate loginFildWithMessage:_responseMessage];
        }
    }
}


@end
