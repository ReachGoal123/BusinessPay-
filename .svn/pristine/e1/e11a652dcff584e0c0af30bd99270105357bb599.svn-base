//
//  LoginViewController.h
//  BusinessPay
//
//  Created by Tears on 14-4-9.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginDO.h"
#import "ApplicationUpdateDO.h"
#import "IQKeyboardManager.h"
#import "UIView+IQKeyboardToolbar.h"
#import "LLLockViewController.h"
#import "UpdateVersionDO.h"

@interface LoginViewController : BaseViewController<LoginRequestDelegate,UITextFieldDelegate,UIAlertViewDelegate,updateVersionDelegate>
{
    LLLockViewType lockViewtype;
}

-(void) savePhoneNumber:(NSString *) phoneNumber andPassword:(NSString *)passwrod;

@property (nonatomic,weak) IBOutlet UIImageView *imageView;

@property (nonatomic,strong) NSString *identifying;

@end
