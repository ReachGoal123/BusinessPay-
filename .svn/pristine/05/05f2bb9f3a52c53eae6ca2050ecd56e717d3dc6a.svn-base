//
//  MyCircleDO.m
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-17.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "MyCircleDO.h"

@implementation MyCircleDO


-(void)myCircleRequest
{
    NSString *urlStr=[self appendPosm7URL:self.trancode];
    NSURL *url=[NSURL URLWithString:urlStr];
    
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.phoneNumber forKey:@"PHONENUMBER"];
    [request addPostValue:self.pageNum forKey:@"PAGENUM"];
    [request addPostValue:self.numPerPage forKey:@"NUMPERPAGE"];
    
    [request setValidatesSecureCertificate:NO];
    [request startSynchronous];
    
    NSError *error=[request error];
    if(!error)
    {
        [self decodeBuyFate:[request responseString]];
    }else
    {
        [self.delegate respondsToSelector:@selector(myCircleRequestFieldWithMessage:)];
        [self.delegate myCircleRequestFieldWithMessage:@"链接服务器失败"];
    }
    
}


-(void) decodeBuyFate:(NSString *) content
{
    NSString * string =  [[User shareUser] decrypt:content];
    
    
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    NSString * responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    self.totalRecode=[[[rootElement elementsForName:@"TOLCNT"] firstObject]stringValue];
    
   // self.tranlist =[rootElement elementsForName:<#(NSString *)#>]
    
    NSArray * orderArr      =[[[rootElement elementsForName:@"TRANDETAILS"] firstObject] elementsForName:@"TRANDETAIL"];
    _termArr =[[NSMutableArray alloc] init];
    if ([responseCode isEqualToString:kRequestSuccessCode]) {
        if (orderArr.count > 0) {
            for (int i = 0; i < orderArr.count; i ++) {
                
                MyCircleDO *myCircleDO=[[MyCircleDO alloc]init];
                myCircleDO.merchantName=[[[[orderArr objectAtIndex:i] elementsForName:@"MERCNAM"] firstObject]stringValue];
                myCircleDO.merPhoneNumber=[[[[orderArr objectAtIndex:i] elementsForName:@"MERPHONENUMBER"] firstObject]stringValue];
                myCircleDO.applyDate=[[[[orderArr objectAtIndex:i] elementsForName:@"APPLYDAT"] firstObject] stringValue];
                //fateListDO.price=[[[[orderArr objectAtIndex:i] elementsForName:@"PRICE"] firstObject]stringValue];
                
                [_termArr addObject:myCircleDO];
            }
        }
    }
    if ([self.delegate respondsToSelector:@selector(myCircleRequestSuccessWithMessage:andArr:)]) {
        [self.delegate myCircleRequestSuccessWithMessage:responseMessage andArr:_termArr];
    }
    
    else
    {
        if ([self.delegate respondsToSelector:@selector(myCircleRequestFieldWithMessage:)]) {
            [self.delegate myCircleRequestFieldWithMessage:responseMessage];
        }
    }
    
}


@end
