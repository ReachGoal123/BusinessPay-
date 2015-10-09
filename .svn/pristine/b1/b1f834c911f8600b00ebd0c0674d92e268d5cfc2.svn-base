//
//  WithDrawViewController.h
//  BusinessPay
//
//  Created by SHANGYITONG on 14-12-24.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "BaseViewController.h"
#import "WithDrawDO.h"
#import "AccountDO.h"
#import "IQKeyboardManager.h"
#import "UIView+IQKeyboardToolbar.h"

@interface WithDrawViewController : BaseViewController<WithDrawDelegate,UIAlertViewDelegate,UITextFieldDelegate,AccountDelegate>
{
    NSInteger   selectedTextFieldTag;
    BOOL       setPasswordCanSee;
    int      _buttonIndex;
    BOOL     isHaveDian ;
    
}

- (IBAction)isSeePassword:(id)sender;



@property(nonatomic,strong)IBOutlet UILabel *bankName;
@property(nonatomic,strong)IBOutlet UILabel *bankCardID;
@property(nonatomic,strong)IBOutlet UILabel *typeCard;
@property(nonatomic,strong)IBOutlet UILabel *canwithDrawMoney;

@property(nonatomic,weak) IBOutlet UITextField *money;
@property(nonatomic,weak) IBOutlet UITextField *password;

@property(nonatomic,strong) UIAlertView *commonWithDrawAlert;
@property(nonatomic,strong) UIAlertView *quickWithDrawAlert;

-(IBAction)clickWithDrawButton:(id)sender;

-(IBAction)quickWithDrawButton:(id)sender;

@property(nonatomic,strong) AccountDO *accountDO;



@property (nonatomic,strong) WithDrawDO *comWithDrawDO;
@property (nonatomic,strong) WithDrawDO *quickWithDrawDO;

@end
