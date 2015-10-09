//
//  RealNameVerificationViewController.h
//  BusinessPay
//
//  Created by Tears on 14-4-15.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RealNameDO.h"

#import "DetailTableViewController.h"
#import "IQKeyboardManager.h"
#import "UIView+IQKeyboardToolbar.h"
#import "RegisterDO.h"


@interface RealNameVerificationViewController : BaseViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,RealNameVerificationDelegate,UIActionSheetDelegate>
{
    BOOL isprovince;
    BOOL isBankName;
}

@property (nonatomic, assign)RealNameVerificationType type;

@property (nonatomic,strong) IBOutlet UIScrollView *scrollView;

@end
