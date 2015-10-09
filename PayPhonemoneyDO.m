//
//  PayPhonemoneyDO.m
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-17.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "PayPhonemoneyDO.h"

@implementation PayPhonemoneyDO

-(void)payMoneyRequest
{
    
    NSString *urlStr=[self appendPayURL:self.trancode];
    NSURL *url=[NSURL URLWithString:urlStr];
    
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setValidatesSecureCertificate:NO];
    [request startSynchronous];

    NSLog(@"url=%@",url);
    
    NSError *error=[request error];
    if(!error)
    {
        [self decodePayRequest:[request responseString]];
    }else
    {
        [self.delegate respondsToSelector:@selector(payMoneyRequestFeildWithMessage:)];
        [self.delegate payMoneyRequestFeildWithMessage:@"链接服务器失败"];
    }

    
}



-(void) decodePayRequest:(NSString *)content
{
    NSString * string =  [[User shareUser] decrypt:content];
    
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
   _responeCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
   _responeMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    
    NSArray * orderArr      =[[[rootElement elementsForName:@"TRANDETAILS"] firstObject] elementsForName:@"TRANDETAIL"];
    _Arr =[[NSMutableArray alloc] init];
    if ([_responeCode isEqualToString:kRequestSuccessCode]) {
        if (orderArr.count > 0) {
            for (int i = 0; i < orderArr.count; i ++) {
                
                PayPhonemoneyDO *payPhoneDO=[[PayPhonemoneyDO alloc]init];
                payPhoneDO.proID=[[[[orderArr objectAtIndex:i] elementsForName:@"PRDID"] firstObject]stringValue];
                payPhoneDO.proName=[[[[orderArr objectAtIndex:i] elementsForName:@"PRDNAME"] firstObject]stringValue];
                payPhoneDO.proType=[[[[orderArr objectAtIndex:i] elementsForName:@"PRDTYPE"] firstObject] stringValue];
                payPhoneDO.proAmt=[[[[orderArr objectAtIndex:i] elementsForName:@"PRDAMT"] firstObject] stringValue];
                payPhoneDO.proNum=[[[[orderArr objectAtIndex:i] elementsForName:@"PRDNUM"] firstObject] stringValue];
                payPhoneDO.proParValue=[[[[orderArr objectAtIndex:i] elementsForName:@"PRDPARVALUE"] firstObject] stringValue];
                
                [_Arr addObject:payPhoneDO];
            }
        }
    }
    //NSLog(@"arr=%@",_Arr);
    if ([self.delegate respondsToSelector:@selector(payMoneyRequestSuccessWithMessage:)]) {
        [self.delegate payMoneyRequestSuccessWithMessage:_responeMessage];
    }
    
    else
    {
        if ([self.delegate respondsToSelector:@selector(payMoneyRequestFeildWithMessage:)]) {
            [self.delegate payMoneyRequestFeildWithMessage:_responeMessage];
        }
    }

    
    
}
@end
