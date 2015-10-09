//
//  ReSetPayPasswordViewController.h
//  BusinessPay
//
//  Created by SHANGYITONG on 14-12-24.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "BaseViewController.h"
#import "ResetPayPasswordDO.h"
#import "IQKeyboardManager.h"
#import "UIView+IQKeyboardToolbar.h"

@interface ReSetPayPasswordViewController : BaseViewController<ReSetPayPasswordDelegate>
{
    NSInteger   selectedTextFieldTag;
}

@property (nonatomic,weak)IBOutlet UITextField *password;
@property (nonatomic,weak)IBOutlet UITextField *confirmPassword;


-(IBAction)clickConfirmButton:(id)sender;

-(IBAction)tapAction:(UITapGestureRecognizer *)sender;

@end
