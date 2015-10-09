//
//  NewAgentViewController.h
//  BusinessPay
//
//  Created by zm on 29/4/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "PhoneNumValidation.h"
#import "UserUpgradeToAgent.h"
#import "IQKeyboardManager.h"
#import "UIView+IQKeyboardToolbar.h"

@interface NewAgentViewController : BaseViewController<ABPeoplePickerNavigationControllerDelegate,NumberValidationDelegate,UserToAgentDelegate>{
    
    NSInteger   selectedTextFieldTag;
}

@property(nonatomic,weak)IBOutlet  UITextField *PhoneNum;

@property(nonatomic,weak) IBOutlet UILabel *fateLabel;

@property(strong, nonatomic)ABPeoplePickerNavigationController *picker;

@property(strong, nonatomic)NSString *BeVerifiedNum;  //被验证号

@property(strong, nonatomic)NSString *CurrentLoginPhoneNum;  //当前登录手机号

@property(strong, nonatomic)NSString *fatestr;  //当前登录手机号

@property (strong,nonatomic) PhoneNumValidation *phonevalidation;

@property(strong, nonatomic)UIAlertView *fateAlertView;


@property(nonatomic,weak)IBOutlet  UIButton *sureButton;


@property(strong, nonatomic)NSMutableArray *fateAlertArr;

@property(strong, nonatomic)NSString *fatestring;


-(IBAction)telePhoneNumChange:(id)sender;  //选择代理号

-(IBAction)fateNumChange:(id)sender;  //选择代理号

-(IBAction)sureUpgradeAction:(id)sender;   //点击确定

@end
