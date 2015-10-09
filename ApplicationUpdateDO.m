//
//  ApplicationUpdateDO.m
//  BusinessPay
//
//  Created by Tears on 14-4-17.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "ApplicationUpdateDO.h"

@implementation ApplicationUpdateDO

- (void)applicationUpdateRequest
{

//    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                 self.applicationName,@"APKNAME",
//                                 self.trancode,@"TRANCODE",
//                                 nil];
//    NSString * requestStr = [[User shareUser] encrypt:dic];
    NSString * urlStr = [self appendPosm5URL:self.trancode];
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    //[request setPostValue:requestStr forKey:@"requestParam"];
    [request addPostValue:self.applicationName forKey:@"APKNAME"];
    [request addPostValue:self.trancode forKey:@"TRANCODE"];
    
    [request setValidatesSecureCertificate:NO] ;
    [request startSynchronous] ;
    NSError *error = [request error];
    
    if (!error) {
        //        NSString *responseString = [request responseString];
        [self decodeOrderDetail:[request responseString]];
        //        NSLog(@"%@", responseString);
    } else {
        NSLog(@"error  = %@", [error description]);
    }
}


- (void)decodeOrderDetail:(NSString *)content
{
    /*
     <?xml version="1.0" encoding="UTF-8"?><EPOSPROTOCOL><VERCODE>1</VERCODE><VERNAME>V1.0</VERNAME><APKNAME>YDPay.apk</APKNAME><APPNAME>移动支付</APPNAME><CREATETIM>20131108</CREATETIM><APKRUL>http://180.166.124.89:8092/posm/upload/YDPay-YDZF-E11-V1.2(测试环境).apk</APKRUL><APKNOTE>测试</APKNOTE><ISFORCE>1</ISFORCE><RSPCOD>000000</RSPCOD><RSPMSG>查询成功</RSPMSG><PACKAGEMAC>81C8052E5E695F611ADAEE62E19B695E</PACKAGEMAC></EPOSPROTOCOL>
     
     */
    
    NSString * string =  [[User shareUser] decrypt:content];
    NSLog(@"  XML  === %@",string);
    NSError * error ;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:string options:0 error:&error];
   GDataXMLElement *rootElement = [document rootElement];
   NSString * responseCode = [[[rootElement elementsForName:@"RSPCOD"] firstObject] stringValue];
    NSString * responseMessage =  [[[rootElement elementsForName:@"RSPMSG"] firstObject] stringValue];
    NSLog(@"%@%@",responseCode,responseMessage);
}



@end
