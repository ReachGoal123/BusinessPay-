//
//  TranferAccountViewController.h
//  BusinessPay
//
//  Created by SHANGYITONG on 15-1-27.
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

@interface TranferAccountViewController : BaseViewController<UITextFieldDelegate,transferAccountDelegate,ABPeoplePickerNavigationControllerDelegate,MerchantInformationInquiryDelegate,UIAlertViewDelegate,AccountDelegate>
{
    NSInteger   selectedTextFieldTag;
    BOOL    isHaveDian;
}

@property(nonatomic,strong)  IBOutlet UITextField *nameTextField;
@property(nonatomic,strong)  IBOutlet UITextField *oppositePhoneTextField;
@property(nonatomic,strong)  IBOutlet UITextField *moneyTextField;
@property(nonatomic,strong)  IBOutlet UITextField *payPasswordTextField;

@property(nonatomic,strong)  IBOutlet UILabel *totalAccountLabel;

@property(nonatomic,strong)  IBOutlet UILabel *tipLabel;

@property (nonatomic,strong) UIAlertView *alert;


@property(nonatomic,strong) AccountDO *accountDO;
@property(nonatomic,strong) MerchantDO *merchantDO;

@property(nonatomic,strong) TransferAccountDO *transferAccountDO;

-(IBAction)tranferAction:(id)sender;


-(IBAction)selectAddressBook:(id)sender;

@property (nonatomic,weak) IBOutlet UITextView *textView;

@end
