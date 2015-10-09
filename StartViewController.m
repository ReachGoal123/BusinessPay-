//
//  StartViewController.m
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-7.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "StartViewController.h"
#import "ARLabel.h"
#import "PayPhonemoneyDO.h"

@interface StartViewController ()
@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    //NSString * phoneNumber = [ud objectForKey:@"phoneNumber"];
    //NSString * password=[ud objectForKey:@"password"];
    NSString *psw=[ud objectForKey:@"lock"];
        
    
    
    if(psw==nil)
    {
        [self performSelector:@selector(presentToLoginVC) withObject:nil afterDelay:0.0f];

        
        
    }else
    {
        [self performSelector:@selector(presentToLockVc) withObject:nil afterDelay:0.0f];
    }
    
}


- (void) presentToLockVc
{
    [self performSegueWithIdentifier:@"togesSegue" sender:self];
}


- (void) presentToLoginVC
{
    [self performSegueWithIdentifier:@"toLoginSegue" sender:self];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




@end
