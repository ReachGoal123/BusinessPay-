//
//  TranferAccount2ViewController.h
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-5.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseViewController.h"

#import "TransferAccountDO.h"
#import "AccountDO.h"
#import "IQKeyboardManager.h"
#import "UIView+IQKeyboardToolbar.h"
#import "MerchantDO.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>


@interface TranferAccount2ViewController : BaseViewController<UITextFieldDelegate,transferAccountDelegate,ABPeoplePickerNavigationControllerDelegate,AccountDelegate>
{
    NSInteger   selectedTextFieldTag;
    BOOL  isHaveDian;
}


@property (nonatomic,weak) IBOutlet UILabel *nameLabel;
@property (nonatomic,weak) IBOutlet UILabel *phoneNumberLabel;
@property (nonatomic,weak) IBOutlet UILabel *canUseMoneyLabel;
@property (nonatomic,weak) IBOutlet UITextField *moneyTextField;
@property (nonatomic,weak) IBOutlet UITextField *payPasswordTextField;

@property (nonatomic,strong) UIAlertView *alert;


@property (nonatomic,weak) IBOutlet UILabel *tipLabel;


@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *phoneNumber;



@property(nonatomic,strong) AccountDO *accountDO;
@property(nonatomic,strong) MerchantDO *merchantDO;

@property (nonatomic,strong) TransferAccountDO *tranferAccountDO;


@property (nonatomic,weak) IBOutlet UITextView *textView;


-(IBAction)tranferAction:(id)sender;

@end
