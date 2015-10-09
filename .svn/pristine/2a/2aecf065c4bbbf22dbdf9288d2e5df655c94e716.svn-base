//
//  BaseViewController.m
//  BusinessPay
//
//  Created by Tears on 14-4-9.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "BaseViewController.h"

#import "MyMD5.h"
#import "AESCrypt.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setBackgroundImage];
}

- (void)textFieldbecomeFirstResponder: (UITextField *)textField
{
    [textField becomeFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)showAlertForSleepWithText:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.margin = 40.f;
//    hud.yOffset = -61.2f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.5f];
}



- (void)showAlertForActivityWithText:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = text;
    hud.layer.opacity = 0.8;
    hud.color = [UIColor blackColor];
    hud.tag = 9797;
}
- (void)hideAlertForActivity
{
    MBProgressHUD *hud = (MBProgressHUD *)[self.view viewWithTag:9797];
    [hud removeFromSuperview];
}


- (NSString *)decrypt:(NSString *)responseString
{
    NSString * key = [[MyMD5 md5Crypte] substringToIndex:16];
    
    NSString * responseXMLStr  = [AESCrypt decrypt:responseString andKey:key];
    
    return responseXMLStr;
}

- (void)showError
{

    
}

@end
