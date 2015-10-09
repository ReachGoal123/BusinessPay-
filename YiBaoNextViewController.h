//
//  YiBaoNextViewController.h
//  BusinessPay
//
//  Created by SHANGYINTONG on 15/4/28.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseViewController.h"
#import "YiBaoPayChannelDO.h"
#import "IQKeyboardManager.h"
#import "UIView+IQKeyboardToolbar.h"


@interface YiBaoNextViewController : BaseViewController<YiBaoPayChannelDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) NSString *phoneNumber;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *clsno;    //订单号


@end
