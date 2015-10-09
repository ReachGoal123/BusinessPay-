//
//  FateListDO.m
//  BusinessPay
//
//  Created by SHANGYITONG on 15-2-28.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "FateListDO.h"

@implementation FateListDO

-(void)fateListInquaryRequest
{
    NSString *urlStr=[self appendPosm7URL:self.trancode];
    NSURL *url=[NSURL URLWithString:urlStr];
    
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.phoneNumber forKey:@"PHONENUMBER"];
    
    
    [request setValidatesSecureCertificate:NO];
    [request startSynchronous];
    
    NSError *error=[request error];
    if(!error)
    {
        [self decodeFateList:[request responseString]];
    }else
    {
        [self.delegate respondsToSelector:@selector(fateListInquaryFieldWithMessage:)];
        [self.delegate fateListInquaryFieldWithMessage:@"链接服务器失败"];
    }

}




-(void) decodeFateList:(NSString *) content
{
    NSString * string =  [[User shareUser] decrypt:content];
    
    
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    NSString * responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    
    
    NSArray * orderArr =[[[rootElement elementsForName:@"TRANDETAILS"] firstObject] elementsForName:@"TRANDETAIL"];
    _temArr =[[NSMutableArray alloc] init];
    if ([responseCode isEqualToString:kRequestSuccessCode]) {
     if (orderArr.count > 0) {
       // for (int i = 0; i < orderArr.count; i ++) {
    
            FateListDO *fateListDO=[[FateListDO alloc]init];
            fateListDO.feeRateNO=[[[[orderArr objectAtIndex:1] elementsForName:@"FEERATNO"] firstObject]stringValue];
            fateListDO.feeRate=[[[[orderArr objectAtIndex:1] elementsForName:@"FEERATE"] firstObject]stringValue];
            fateListDO.feeRateDesc=[[[[orderArr objectAtIndex:1] elementsForName:@"FEERATEDESC"] firstObject] stringValue];
            fateListDO.price=[[[[orderArr objectAtIndex:1] elementsForName:@"PRICE"] firstObject]stringValue];
    
        [_temArr addObject:fateListDO];
          //  }
        }
    }
    if ([self.delegate respondsToSelector:@selector(fateListInquarySuccessWithMessage:andArr:)]) {
        [self.delegate fateListInquarySuccessWithMessage:responseMessage andArr:_temArr];
    }

    else
    {
        if ([self.delegate respondsToSelector:@selector(fateListInquaryFieldWithMessage:)]) {
           [self.delegate fateListInquaryFieldWithMessage:responseMessage];
        }
    }

    
}
@end
