//
//  ChangePayPasswordViewController.h
//  BusinessPay
//
//  Created by SHANGYITONG on 14-12-24.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "BaseViewController.h"
#import "PayPasswordChange.h"
#import "IQKeyboardManager.h"
#import "UIView+IQKeyboardToolbar.h"

@interface ChangePayPasswordViewController : BaseViewController<PayPasswordChangeDelegate,UITextFieldDelegate>
{
    NSInteger   selectedTextFieldTag;
}

@property (nonatomic,weak) IBOutlet UITextField *oldPassword;
@property (nonatomic,weak) IBOutlet UITextField *password;
@property (nonatomic,weak) IBOutlet UITextField *verifyPassword;


-(IBAction)cilckButton:(id)sender;
-(IBAction)tapAction:(UITapGestureRecognizer *)sender;

@end
