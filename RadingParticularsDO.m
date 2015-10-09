//
//  RadingParticularsDO.m
//  BusinessPay
//
//  Created by SHANGYINTONG on 15-4-8.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "RadingParticularsDO.h"

@implementation RadingParticularsDO


-(void)radingRequest
{
    NSString * urlStr = [self appendPosm7URL:self.trancode];
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.alogNO forKey:@"ALOGNO"];
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    NSError *error = [request error];
    
    if (!error) {
        [self decodeRadingRequest:[request responseString]];
    } else {
        if ([self.delegate respondsToSelector:@selector(radingParticularsFeildWithMessage:)]) {
            [self.delegate radingParticularsFeildWithMessage:@"链接服务器失败"];
        }
        
    }
    
}


-(void)decodeRadingRequest:(NSString *)content
{
    NSString * string =  [[User shareUser] decrypt:content];
    NSLog(@"  XMLdetail  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    NSString * responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    
    RadingParticularsDO *radingParticularsDO=[[RadingParticularsDO alloc] init];
    
    
    radingParticularsDO.reChangeNumber=[[[rootElement elementsForName:@"RECNUMBER"] firstObject ]stringValue];
    radingParticularsDO.cardNO=[[[rootElement elementsForName:@"CARDNO"] firstObject ]stringValue];
    radingParticularsDO.cardName=[[[rootElement elementsForName:@"CARDNAM"] firstObject] stringValue];
    
    radingParticularsDO.bankName=[[[rootElement elementsForName:@"BANKNAM"] firstObject ]stringValue];
    
    radingParticularsDO.outName=[[[rootElement elementsForName:@"OUTACTNAM"] firstObject]stringValue];
    
    radingParticularsDO.pactNam=[[[rootElement elementsForName:@"PACTNAM"] firstObject]stringValue];
    
    radingParticularsDO.outActid=[[[rootElement elementsForName:@"OUTACTID"] firstObject]stringValue];
    
    radingParticularsDO.pactActid=[[[rootElement elementsForName:@"PACTID"] firstObject]stringValue];
    
    radingParticularsDO.orderStutas=[[[rootElement elementsForName:@"OPERSTS"] firstObject]stringValue];
    
    radingParticularsDO.orderType=[[[rootElement elementsForName:@"OPERBTYP"] firstObject]stringValue];
    radingParticularsDO.orderStype=[[[rootElement elementsForName:@"OPERSTYP"] firstObject]stringValue];
    radingParticularsDO.orderTime=[[[rootElement elementsForName:@"OPERTIM"] firstObject]stringValue];
    
    radingParticularsDO.txtAmt=[[[rootElement elementsForName:@"TXNAMT"] firstObject]stringValue];
    
    radingParticularsDO.feeAmt=[[[rootElement elementsForName:@"FEEAMT"] firstObject]stringValue];
    
    radingParticularsDO.actid=[[[rootElement elementsForName:@"ACTID"] firstObject]stringValue];
    
    radingParticularsDO.targActid=[[[rootElement elementsForName:@"TARGATCNAM"] firstObject]stringValue];
    
    
    if ([responseCode isEqualToString:kRequestSuccessCode]) {
        if ([self.delegate respondsToSelector:@selector(radingParticularsSuccessWithMessage:withRadingPar:)]) {
            [self.delegate radingParticularsSuccessWithMessage:responseMessage withRadingPar:radingParticularsDO];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(radingParticularsFeildWithMessage:)]) {
            [self.delegate radingParticularsFeildWithMessage:responseMessage];
        }
    }
    
}


@end
