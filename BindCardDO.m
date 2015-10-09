//
//  BindCardDO.m
//  BusinessPay
//
//  Created by SHANGYINTONG on 15/4/29.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BindCardDO.h"

@implementation BindCardDO

-(void)bindCardRequest
{
    
    NSString  *urlStr=[self appendPayURL:self.trancode];
    NSURL *url=[NSURL URLWithString:urlStr];
    
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    [request addPostValue:self.phoneNumber forKey:@"PHONENUMBER"];
    
    [request setValidatesSecureCertificate:NO];
    [request startSynchronous];
    
    NSError *error;
    if(!error)
    {
        [self decodeBindCard:[request responseString]];
    } else {
        NSLog(@"error  = %@", [error description]);
        if ([self.delegate respondsToSelector:@selector(bindCardRequestFeildWithMessage:)]) {
            [self.delegate bindCardRequestFeildWithMessage:@"连接服务器失败"];
        }
    }

    
    
}


-(void) decodeBindCard:(NSString *)content
{
 
    NSString * string =  [[User shareUser] decrypt:content];
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
    GDataXMLElement *rootElement = [document rootElement];
    NSString * responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    
    NSArray * orderArr      =[[[rootElement elementsForName:@"TRANDETAILS"] firstObject] elementsForName:@"TRANDETAIL"];
    NSMutableArray * tempArr =[[NSMutableArray alloc] init];
    if ([responseCode isEqualToString:kRequestSuccessCode]) {
        if (orderArr.count > 0) {
            for (int i = 0; i < orderArr.count; i ++) {
                BindCardDO * bindCardDO = [[BindCardDO alloc] init];
                bindCardDO.cardType = [[[[orderArr objectAtIndex:i] elementsForName:@"CREDTYPE"] firstObject] stringValue];
                bindCardDO.cardNumber=[[[[orderArr objectAtIndex:i] elementsForName:@"CREDCODE"]firstObject]stringValue];
                bindCardDO.issuer=[[[[orderArr objectAtIndex:i] elementsForName:@"ISSUER"] firstObject]stringValue];
                bindCardDO.ferID=[[[[orderArr objectAtIndex:i] elementsForName:@"FRPID"] firstObject] stringValue];
                bindCardDO.cardTel=[[[[orderArr objectAtIndex:i] elementsForName:@"CARDTEL"] firstObject] stringValue];
                bindCardDO.cardName=[[[[orderArr objectAtIndex:i] elementsForName:@"CARDNAME"]firstObject]stringValue];
                bindCardDO.cardCode=[[[[orderArr objectAtIndex:i] elementsForName:@"CARDCODE"]firstObject]stringValue];
                bindCardDO.expireYear=[[[[orderArr objectAtIndex:i] elementsForName:@"EXPIREYEAR"]firstObject] stringValue];
                bindCardDO.expireMonth=[[[[orderArr objectAtIndex:i] elementsForName:@"EXPIREMONTH"]firstObject]stringValue];
                
                bindCardDO.cvv=[[[[orderArr objectAtIndex:i] elementsForName:@"CVV"]firstObject]stringValue];
                bindCardDO.reChangeNumber=[[[[orderArr objectAtIndex:i] elementsForName:@"RECHARGENUMBER"]firstObject ]stringValue];
                
                
                [tempArr addObject:bindCardDO];

            }
        }
        if ([self.delegate respondsToSelector:@selector(bindCardRequestSuccessWithMessage:andBindCardDOArr:)]) {
            [self.delegate bindCardRequestSuccessWithMessage:responseMessage andBindCardDOArr:tempArr];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(bindCardRequestFeildWithMessage:)]) {
            [self.delegate bindCardRequestFeildWithMessage:responseMessage];
        }
    }
    
}

@end
