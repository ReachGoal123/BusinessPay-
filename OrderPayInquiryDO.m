//
//  OrderPayInquiryDO.m
//  BusinessPay
//
//  Created by SHANGYITONG on 15-1-13.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "OrderPayInquiryDO.h"

@implementation OrderPayInquiryDO


- (void)orderListInquiryRequest
{
    
    NSString * urlStr = [self appendPayURL:self.trancode];
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    //[request setPostValue:requestStr forKey:@"requestParam"];
    [request addPostValue:self.currentPage forKey:@"PAGENUM"];
    [request addPostValue:self.accountPerPage forKey:@"NUMPERPAGE"];
    [request addPostValue:self.startDataTime forKey:@"SDAT"];
    [request addPostValue:self.endDataTime forKey:@"EDAT"];
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.phoneNumber forKey:@"PHONENUMBER"];
    
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    NSError *error = [request error];
    
    if (!error) {
        [self decodeOrderListInquiry:[request responseString]];
    } else {
        if ([self.delegate respondsToSelector:@selector(orderPayInquiryResponseFailWithMessage:)]) {
            [self.delegate orderPayInquiryResponseFailWithMessage:@"链接服务器失败"];
        }
        
    }
}

- (void)decodeOrderListInquiry:(NSString *)content
{
    /*
     <?xml version="1.0" encoding="UTF-8"?><EPOSPROTOCOL><PHONENUMBER>13048883620</PHONENUMBER><TRANDETAILS><TRANDETAIL class="array"><PRDORDNO>01102014042121153700000101</PRDORDNO><ORDERTIM>20140421211537</ORDERTIM><ORDAMT>0</ORDAMT><TN>201404212115370050982</TN><PAYORDNO>P014042100000092</PAYORDNO><TRANSTS>00</TRANSTS><PRDORDTYPE>0</PRDORDTYPE></TRANDETAIL><TRANDETAIL class="array"><PRDORDNO>01102014042417593200000114</PRDORDNO><ORDERTIM>20140424175932</ORDERTIM><ORDAMT>1</ORDAMT><TN>201404241759320014942</TN><PAYORDNO>P014042400000105</PAYORDNO><TRANSTS>00</TRANSTS><PRDORDTYPE>0</PRDORDTYPE></TRANDETAIL><TRANDETAIL class="array"><PRDORDNO>01102014042417594600000115</PRDORDNO><ORDERTIM>20140424175946</ORDERTIM><ORDAMT>1</ORDAMT><TN>201404241759460014952</TN><PAYORDNO>P014042400000106</PAYORDNO><TRANSTS>00</TRANSTS><PRDORDTYPE>0</PRDORDTYPE></TRANDETAIL><TRANDETAIL class="array"><PRDORDNO>01102014042418171100000116</PRDORDNO><ORDERTIM>20140424181711</ORDERTIM><ORDAMT>778</ORDAMT><TN>201404241817110015312</TN><PAYORDNO>P014042400000107</PAYORDNO><TRANSTS>00</TRANSTS><PRDORDTYPE>0</PRDORDTYPE></TRANDETAIL><TRANDETAIL class="array"><PRDORDNO>01102014042317551800000112</PRDORDNO><ORDERTIM>20140423175518</ORDERTIM><ORDAMT>2147483647</ORDAMT><TN>201404231755180094372</TN><PAYORDNO>P014042300000103</PAYORDNO><TRANSTS>00</TRANSTS><PRDORDTYPE>0</PRDORDTYPE></TRANDETAIL></TRANDETAILS><RSPCOD>000000</RSPCOD><RSPMSG>交易成功</RSPMSG><TOLCNT>5</TOLCNT><NUMPERPAGE>500</NUMPERPAGE><PACKAGEMAC>A199A4C00C4D8EE9957AC72F75839F88</PACKAGEMAC></EPOSPROTOCOL>
     */
    
    NSString * string =  [[User shareUser] decrypt:content];
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    NSString * responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    NSLog(@"===== %@",[[rootElement elementsForName:@"TRANDETAILS"] firstObject]);
    NSArray * orderArr      =[[[rootElement elementsForName:@"TRANDETAILS"] firstObject] elementsForName:@"TRANDETAIL"];
     _tempArr =[NSMutableArray array];
    if ([responseCode isEqualToString:kRequestSuccessCode]) {
        if (orderArr.count > 0) {
            for (int i = 0; i < orderArr.count; i ++) {
                
                OrderPayInquiryDO * orderDO = [[OrderPayInquiryDO alloc] init];
                orderDO.payOrderNumber = [[[[orderArr objectAtIndex:i] elementsForName:@"CLSLOGNO"] firstObject] stringValue];
                orderDO.totalRecord=[[[[orderArr objectAtIndex:i] elementsForName:@"TOLCNT"]firstObject]stringValue];
                
                orderDO.orderMoney = [[[[orderArr objectAtIndex:i] elementsForName:@"ORDAMT"] firstObject] stringValue];
                orderDO.payTime = [[[[orderArr objectAtIndex:i] elementsForName:@"ORDERTIM"] firstObject] stringValue];
                orderDO.payStatus = [[[[orderArr objectAtIndex:i] elementsForName:@"TRANSTS"] firstObject] stringValue];
                orderDO.orderType = [[[[orderArr objectAtIndex:i] elementsForName:@"prdordtype"] firstObject] stringValue];
                orderDO.orderNum=[[[[orderArr objectAtIndex:i] elementsForName:@"ORDERNUM"]firstObject]stringValue];
                
                orderDO.transacteLineNumber = [[[[orderArr objectAtIndex:i] elementsForName:@"TN"] firstObject] stringValue];
                orderDO.transacteCheckLineNumber=[[[[orderArr objectAtIndex:i] elementsForName:@"QN"]firstObject]stringValue];
                
                
                orderDO.clsDate=[[[[orderArr objectAtIndex:i] elementsForName:@"CLSDAT"]firstObject]stringValue];
                orderDO.txtDate=[[[[orderArr objectAtIndex:i] elementsForName:@"TXNDAT"] firstObject]stringValue];
                orderDO.txtamt=[[[[orderArr objectAtIndex:i] elementsForName:@"TXNAMT"]firstObject]stringValue];
                orderDO.frramt=[[[[orderArr objectAtIndex:i] elementsForName:@"FRRAMT"] firstObject] stringValue];
                orderDO.clsAmt=[[[[orderArr objectAtIndex:i] elementsForName:@"CLSAMT"] firstObject]stringValue];
               // NSLog(@"txtamt=%@,frramt=%@,clsamt=%@",orderDO.txtamt,orderDO.frramt,orderDO.clsAmt);
                
                [_tempArr addObject:orderDO];
            }
        }
        if ([self.delegate respondsToSelector:@selector(orderPayInquiryResponseSuccessWithMessage:andOrderInquiryDOArry:)]) {
            [self.delegate orderPayInquiryResponseSuccessWithMessage:responseMessage andOrderInquiryDOArry:_tempArr];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(orderPayInquiryResponseFailWithMessage:)]) {
            [self.delegate orderPayInquiryResponseFailWithMessage:responseMessage];
        }
    }
}

@end
