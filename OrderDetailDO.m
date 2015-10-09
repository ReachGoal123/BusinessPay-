//
//  OrderDetailDO.m
//  BusinessPay
//
//  Created by Tears on 14-4-17.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "OrderDetailDO.h"

@implementation OrderDetailDO

- (void)orderDetailRequest
{
    
     
    NSString * urlStr = [self appendPayURL:self.trancode];
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    //[request setPostValue:requestStr forKey:@"requestParam"];
    [request addPostValue:self.phoneNumber forKey:@"PHONENUMBER"];
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.orderDataTime forKey:@"MERORDERDATE"];
    [request addPostValue:self.orderCode forKey:@"MERORDERID"];
    [request addPostValue:self.urlType forKey:@"URLTYPE"];
    
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    NSError *error = [request error];
    
    if (!error) {
        [self decodeOrderDetail:[request responseString]];
    } else {
        if ([self.delegate respondsToSelector:@selector(orderDetailFailWithMessage:andPhoneNumber:andMerorderStatus:)]) {
            [self.delegate orderDetailFailWithMessage:@"链接服务器失败" andPhoneNumber:nil andMerorderStatus:nil];
        }

    }

}

- (void)decodeOrderDetail:(NSString *)content
{
    /*
     <?xml version="1.0" encoding="UTF-8"?><EPOSPROTOCOL><PHONENUMBER>13048883620</PHONENUMBER><ORDAMT>1</ORDAMT><ORDERTIME>20140417194925</ORDERTIME><ORDERNUM>01102014041719492500000098</ORDERNUM><RSPCOD>09996</RSPCOD><RSPMSG>订单未支付[8600001]</RSPMSG><PACKAGEMAC>9CD8D1D307FF2BCBC4369D2911C687BF</PACKAGEMAC></EPOSPROTOCOL>
     */
    
    NSString * string =  [[User shareUser] decrypt:content];
    NSLog(@"  XMLdetail  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    NSString * responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    NSString * orderPhoneNumber =  [[[rootElement elementsForName:@"PHONENUMBER"] firstObject] stringValue];
    self.meroederStatus=[[[rootElement elementsForName:@"MERORDERSTATUS"]firstObject]stringValue];
    if ([responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate respondsToSelector:@selector(orderDetailSuccessWithMessage:andPhoneNumber:andMerorderStatus:)]) {
            [self.delegate orderDetailSuccessWithMessage:responseMessage andPhoneNumber:orderPhoneNumber andMerorderStatus:self.meroederStatus];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(orderDetailFailWithMessage:andPhoneNumber:andMerorderStatus:)]) {
            [self.delegate orderDetailFailWithMessage:responseMessage andPhoneNumber:orderPhoneNumber andMerorderStatus:self.meroederStatus];
        }
    }
}


@end
