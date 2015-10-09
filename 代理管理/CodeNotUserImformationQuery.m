//
//  CodeNotUserImformationQuery.m
//  BusinessPay
//
//  Created by zm on 6/5/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "CodeNotUserImformationQuery.h"

@implementation CodeNotUserImformationQuery

-(void)CodeNotUserImformationQueryRequest{

    NSString * urlStr = [self appendPayURL:self.trancode];
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.agentNumber forKey:@"AGENTID"];
    [request addPostValue:self.phongeNumberCode forKey:@"PHONENUMBER"];
    [request addPostValue:@"1" forKey:@"PAGENUM"];
    [request addPostValue:@"500" forKey:@"NUMPERPAGE"];
    
    NSLog(@"phongeNumber---%@",self.phongeNumberCode);
    NSLog(@"self.agentNumber---%@",self.agentNumber);
    NSLog(@"self.trancode---%@",self.trancode);
    
    NSLog(@"urlStr---%@",urlStr);
    
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    
    NSError *error = [request error];
    
    if (!error) {
        [self decodeInformationQuery:[request responseString]];
    } else {
        NSLog(@"error  = %@", [error description]);
        if ([self.delegate respondsToSelector:@selector(CodeNotUserImformationQueryFildWithMessage:)]) {
            [self.delegate CodeNotUserImformationQueryFildWithMessage:@"连接服务器失败"];
        }
    }
}

- (void)decodeInformationQuery:(NSString *)content
{
    NSString * string =  [[User shareUser] decrypt:content];
    
    
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    _responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    _responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    NSArray *arr = [[[rootElement elementsForName:@"TRANDETAILS"] firstObject] elementsForName:@"TRANDETAIL"];
    _termArr =[[NSMutableArray alloc] init];
    
    if ([_responseCode isEqualToString:kRequestSuccessCode]){
        if (arr.count > 0) {
            for (int i = 0; i < arr.count; i++) {
                CodeNotUserImformationQuery *codequery = [[CodeNotUserImformationQuery alloc]init];
                codequery.kaishiTime = [[[[arr objectAtIndex:i] elementsForName:@"ACTIVDAT"] firstObject] stringValue];
                codequery.jieshuTime = [[[[arr objectAtIndex:i] elementsForName:@"INVAILDAT"] firstObject] stringValue];
                 codequery.codeType = [[[[arr objectAtIndex:i] elementsForName:@"INVAILDAT"] firstObject] stringValue];
                 codequery.activCode = [[[[arr objectAtIndex:i] elementsForName:@"ACTCOD"] firstObject] stringValue];
                
                NSLog(@"codequery.kaishiTime---%@",codequery.kaishiTime);
                NSLog(@"codequery.jieshuTime---%@",codequery.jieshuTime);
                NSLog(@"codequery.codeType---%@",codequery.codeType);
                NSLog(@"codequery.activCode---%@",codequery.activCode);
                
                 [_termArr addObject:codequery];
            }
        }

    }
    if ([self.delegate respondsToSelector:@selector(CodeNotUserImformationQuerySuccessWithMessage:andArr:)]) {
        
        [self.delegate CodeNotUserImformationQuerySuccessWithMessage:_responseMessage andArr:_termArr];
    }
    else {
        if ([self.delegate respondsToSelector:@selector(CodeNotUserImformationQueryFildWithMessage:)]) {
            [self.delegate CodeNotUserImformationQueryFildWithMessage:_responseMessage];
        }
    }

}


@end
