//
//  AccountViewController.h
//  BusinessPay
//
//  Created by Tears on 14-4-16.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MerchantDO.h"
#import "MyCircleDO.h"
#import "AgentInformationQuery.h"

@interface AccountViewController : BaseViewController<UIAlertViewDelegate,MyCircleDelegate,AgentInformationQueryDelegate>

@property(strong,nonatomic)IBOutlet UIButton *agentButton;
@end
