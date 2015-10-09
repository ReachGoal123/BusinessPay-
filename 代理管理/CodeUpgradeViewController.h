//
//  CodeUpgradeViewController.h
//  BusinessPay
//
//  Created by SHANGYINTONG on 15/5/11.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseViewController.h"
#import "IQKeyboardManager.h"
#import "UIView+IQKeyboardToolbar.h"
#import "CodeUpgradeTO.h"

@interface CodeUpgradeViewController : BaseViewController<UITextFieldDelegate,CodeUpgradeTODelegate,UIAlertViewDelegate>
{

     NSInteger   selectedTextFieldTag;
}

@property(nonatomic,strong)IBOutlet UITextField *codeField;

@property(nonatomic,strong)IBOutlet UIButton *codeButton;

@property(nonatomic,strong)IBOutlet UIButton *moneyButton;

@property(nonatomic,strong)IBOutlet UIButton *sureButton;

@property(nonatomic,strong)NSString *userphone;
@property(nonatomic,strong)NSString *trancode;
@property(nonatomic,strong)NSString *upgradeCode;
@property(nonatomic,strong)NSString *upgradeType;

-(IBAction)upgradeButton:(id)sender;

-(IBAction)accountUpgradeButton:(id)sender;



@end
