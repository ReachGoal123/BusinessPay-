//
//  childAgentQuery.m
//  BusinessPay
//
//  Created by zm on 4/5/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "childAgentQuery.h"

@implementation childAgentQuery

-(void)childAgentQueryRequest{
    NSString * urlStr = [self appendPayURL:self.trancode];
    
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.currentAgentNumber forKey:@"CURAGENTID"];  //当前代理商编号
    [request addPostValue:self.LoginPhoneNum forKey:@"PHONENUMBER"];  //当前登录号码
    [request addPostValue:@"1" forKey:@"PAGENUM"];
    [request addPostValue:@"15" forKey:@"NUMPERPAGE"];
    
    NSLog(@"self.trancode---%@",self.trancode);
    NSLog(@"self.currentAgentNumber---%@",self.currentAgentNumber);
    NSLog(@"self.LoginPhoneNum---%@",self.LoginPhoneNum);
    
    
    
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    
    NSError *error = [request error];
    
    if (!error) {
        [self decodeValidation:[request responseString]];
    } else {
        NSLog(@"error  = %@", [error description]);
        if ([self.delegate respondsToSelector:@selector(childAgentQueryFildWithMessage:)]) {
            [self.delegate childAgentQueryFildWithMessage:@"连接服务器失败"];
        }
    }
    
}




- (void)decodeValidation:(NSString *)content{
    
    NSString * string =  [[User shareUser] decrypt:content];
    
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    _responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    _responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    
    NSArray *arr = [[[rootElement elementsForName:@"TRANDETAILS"] firstObject] elementsForName:@"TRANDETAIL"];
    
    _termArr =[[NSMutableArray alloc] init];
    if ([_responseCode isEqualToString:kRequestSuccessCode]) {
        if (arr.count > 0){
            for (int i = 0; i < arr.count; i ++){
                
                childAgentQuery *childagent = [[childAgentQuery alloc]init];
                
                childagent.childAgentNumber = [[[[arr objectAtIndex:i] elementsForName:@"AGENTID"] firstObject] stringValue];//自代理商id
                childagent.childAgentName = [[[[arr objectAtIndex:i] elementsForName:@"AGTNAM"] firstObject] stringValue]; //名字
                childagent.costRate =     [[[[arr objectAtIndex:i] elementsForName:@"FEERATE"] firstObject] stringValue];  //费率
                childagent.pickGoodsNumber = [[[[arr objectAtIndex:i] elementsForName:@"ACTCODNUM"] firstObject] stringValue]; //提货量
//                childagent.childPhoneNum = [[[[arr objectAtIndex:i] elementsForName:@"ACTID"] firstObject] stringValue]; //电话号
                NSLog(@"===%@",childagent.costRate);
                NSLog(@"===%@",childagent.pickGoodsNumber);
                [_termArr addObject:childagent];
                
            }
            
        }
    }
    
    
    if ([self.delegate respondsToSelector:@selector(childAgentQuerySuccessWithMessage:andArr:)]) {
        
        [self.delegate childAgentQuerySuccessWithMessage:_responseMessage andArr:_termArr];
    }
    else {
        if ([self.delegate respondsToSelector:@selector(childAgentQueryFildWithMessage:)]) {
            [self.delegate childAgentQueryFildWithMessage:_responseMessage];
        }
    }
}



@end
