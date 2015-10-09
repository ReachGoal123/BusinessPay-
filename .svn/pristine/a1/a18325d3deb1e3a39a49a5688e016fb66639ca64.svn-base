//
//  UIViewController+Adapter.m
//  BusinessPay
//
//  Created by Tears on 14-4-9.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "UIViewController+Adapter.h"
#import "IQKeyboardManager.h"
@implementation UIViewController (Adapter)

- (void)setBackgroundImage
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundimage"]];
}

- (void)showWarmingWithMessage:(NSString *)text
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.labelText = text;
    hud.yOffset = -61.2f;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"warming"]];
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(1.5);
    } completionBlock:^{
        [hud removeFromSuperview];
    }];
}

@end
