//
//  GainOperatorDO.m
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-18.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "GainOperatorDO.h"

@implementation GainOperatorDO

-(NSString *)getOperatorRequest:(NSString *)webServiceURL withGainCode:(NSString *)phoneNumber paramName:(NSString *)phoneNumberValue
{
    NSURL *url=[NSURL URLWithString:webServiceURL];
    
    //ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    
    [request setPostValue:phoneNumberValue forKey:phoneNumber];
    [request startSynchronous];
    NSError *err=[request error];
    if(!err)
    {
        return [request responseString];
    }
    NSLog(@"发送带参数的请求错误");
    return nil;
}

@end
