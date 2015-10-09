//
//  RechangeViewController.h
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-18.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "RechargePhoneDO.h"
#import "PayPhonemoneyDO.h"
#import "IQKeyboardManager.h"
#import "UIView+IQKeyboardToolbar.h"
#import "AYHCustomComboBox.h"
#import "PhoneNumberManager.h"
#import "PhoneNumberInfo.h"
#import "AccountDO.h"

@interface RechangeViewController : BaseViewController<ABPeoplePickerNavigationControllerDelegate,UITextFieldDelegate,RechargePhoneDelegate,UIAlertViewDelegate,AYHCustomComboBoxDelegate,AccountDelegate>
{
    NSInteger   selectedTextFieldTag;
    ABPeoplePickerNavigationController *picker;
    NSArray* items;
    PhoneNumberManager *phoneNumberManager;
    PhoneNumberInfo *phoneInfo;
    
    BOOL isVisibleSex;
    BOOL isVisibleNation;
}

@property (nonatomic,weak) IBOutlet UITextField *phoneNumberTextFeild;
@property (nonatomic,weak) IBOutlet UITextField *moneyTextFeild;

@property (nonatomic,weak) IBOutlet UILabel *mayLabel;
@property (nonatomic,weak) IBOutlet UILabel *actualLabel;
@property (nonatomic,weak) IBOutlet UILabel *operatorsLabel;

@property (nonatomic,weak) IBOutlet UILabel *accountLabel;


@property (nonatomic,strong) NSMutableArray *temArr;

@property (nonatomic,strong) UIAlertView *alert;
@property (nonatomic,strong) UIAlertView *moneyAlert;

@property (nonatomic,strong) PayPhonemoneyDO *payPhonemoneyDO;


@property (nonatomic,strong) NSArray *mobileArr;      //移动号
@property (nonatomic,strong) NSArray * telecomArr;    //电信
@property (nonatomic,strong) NSArray *unicomArr;      //联通

@property (nonatomic,strong) AccountDO *accountDO;



@property (nonatomic,strong) RechargePhoneDO *rechargePhoneDO;

@property (nonatomic,assign) int status;  //判断成功失败的状态码；



//下拉列表的属性

@property (nonatomic,strong) AYHCustomComboBox *ccbSex;




-(IBAction)selectBookAction:(id)sender;
-(IBAction)reChangeAction:(id)sender;
-(IBAction)selectMoneyAction:(id)sender;



@end
