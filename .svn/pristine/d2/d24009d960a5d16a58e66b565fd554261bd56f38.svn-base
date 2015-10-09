//
//  FindPayPasswordViewController.h
//  BusinessPay
//
//  Created by SHANGYITONG on 14-12-24.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "BaseViewController.h"
#import "FindPayPasswordDO.h"

#import "IQKeyboardManager.h"
#import "UIView+IQKeyboardToolbar.h"

@interface FindPayPasswordViewController : BaseViewController<FindPayPasswordDelegate>
{
    NSInteger   selectedTextFieldTag;

}

@property(nonatomic,weak) IBOutlet UITextField *phoneNumber;
@property(nonatomic,weak) IBOutlet UITextField *cardID;
@property(nonatomic,weak) IBOutlet UITextField *messageCode;

-(IBAction)gainMessageCode:(id)sender;

-(IBAction)comfireMessage:(id)sender;

-(IBAction)tapAction:(UITapGestureRecognizer *)sender;

@end
