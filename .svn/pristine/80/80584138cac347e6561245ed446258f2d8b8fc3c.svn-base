//
//  ViewController.m
//  BusinessPay
//
//  Created by Tears on 14-4-1.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "ViewController.h"
#import "ASIFormDataRequest.h"


@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
//    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                 @"SF",@"TRANCODE",
//                                 @"SFAESDAFASF",@"ACCOUNTNAME",
//                                 @"SFASF",@"IDNUMBER",
//                                 @"13410498688",@"PHONENUMBER",
//                                 @"123456",@"PASSWORD",
//                                 @"FJYTJTYJTY",@"TERMNO",
//                                 @"DHRHERHYR",@"TRMTYP",
//                                 @"JTYJTJ",@"BANKACCOUNT",
//                                 @"JTYJTJRTYJSDSRR",@"BRANKBRANCH",
//                                 @"SDGFE2EFGSG1E2S6",@"RANDOM",
//                                 @"HEHE",@"REFPHONE",
//                                 nil];
//
    //NSString * requestStr = [[User shareUser] encrypt:dic];
    
//  http://180.166.124.89:8092/posm/199001.tran5
    
    
    // 8084  8453
    NSURL * url = [NSURL URLWithString:@"https://192.168.1.111:8453/p2p/ws/user.do?action=list&uname=admin"];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request setValidatesSecureCertificate:NO];
    [request startSynchronous] ;
    NSError *error = [request error];
    
    if (!error) {
        NSString *responseString = [request responseString];
        NSLog(@"%@", responseString);
    } else {
        NSLog(@"error  = %@", [error description]);
    }

}


- (void) decode:(NSString *) content
{
    NSString * string =  [[User shareUser] decrypt:content];
    
    NSLog(@"  XML  === %@",string);
}

@end
