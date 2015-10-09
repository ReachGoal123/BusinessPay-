//
//  SetPayPasswordViewController.h
//  BusinessPay
//
//  Created by SHANGYITONG on 15-1-7.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseViewController.h"
#import "SetPayPasswordDO.h"
#import "IQKeyboardManager.h"
#import "UIView+IQKeyboardToolbar.h"
#import "LLLockViewController.h"

@interface SetPayPasswordViewController : BaseViewController<SetPayPasswordDelegate,UITextFieldDelegate>
{
     NSInteger   selectedTextFieldTag;
    LLLockViewType lockViewType;
}


@property (nonatomic,strong) IBOutlet UITextField *password;
@property (nonatomic,strong) IBOutlet UITextField *comfirPassword;


-(IBAction)backButton:(id)sender;

-(IBAction)comfirButton:(id)sender;

-(IBAction)tapAction:(UITapGestureRecognizer *)sender;

@end
