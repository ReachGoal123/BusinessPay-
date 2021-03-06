//
//  RegisterViewController.h
//  BusinessPay
//
//  Created by Tears on 14-4-9.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQKeyboardManager.h"
#import "UIView+IQKeyboardToolbar.h"
#import "RegisterDO.h"
#import "DetailTableViewController.h"
#import "TerminalVerificationDO.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "MerchantDO.h"

@interface RegisterViewController : BaseViewController<UITextFieldDelegate,RegisterRequestDelegate,shareProvinceMessageDelegate,TerminalVerificationDelegate,ABPeoplePickerNavigationControllerDelegate,MerchantInformationInquiryDelegate>

@property (nonatomic,strong) IBOutlet UIButton *surebutton;

@property (nonatomic,strong) UIView *myView;
@property (nonatomic,strong) UIColor *color;


@end
