//
//  UIComponentService.m
//  BccClient
//
//  Created by Apple on 12-10-5.
//  Copyright (c) 2012年 Straw. All rights reserved.
//

#import "UIComponentService.h"

@implementation UIComponentService

@synthesize bgimgIndex;

static UIComponentService *_instance;

+ (UIComponentService *)getInstance {
    if (_instance == nil) {
        _instance = [[UIComponentService alloc] init];
    }
    return _instance;
}

#pragma mark - UIComponent

/*
- (void)getRootViewController {
    rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    NSLog(@"rootViewController: %@", rootViewController.view);
}
*/

#pragma mark - Use SVProgressHUD

+ (void)showNoStatusHud {
    [SVProgressHUD show];
}

+ (void)showHudWithStatus:(NSString *)status {
    [SVProgressHUD showWithStatus:status maskType:SVProgressHUDMaskTypeClear];
}

+ (void)showSuccessHudWithStatus:(NSString *)message {
    [SVProgressHUD showSuccessWithStatus:message];
}

+ (void)showFailHudWithStatus:(NSString *)message {
    [SVProgressHUD showErrorWithStatus:message];
}

+ (void)showFailHudWithStatus:(NSString *)message duration:(NSTimeInterval)duration
{
    [SVProgressHUD showErrorWithStatus:message duration:duration];
}

+ (void)dismissHudView {
    [SVProgressHUD dismiss];
}

+ (void)dismissHudSuccess {
    [SVProgressHUD showSuccessWithStatus:@"载入成功"];
}

+ (void)showMessageAlertView:(NSString *)title message:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:message
                                      delegate:self
                             cancelButtonTitle:@"确定"
                             otherButtonTitles:nil, nil];
    [alert show];
}

+(void)showSimpleToast:(NSString *)message
{
    
}

@end
