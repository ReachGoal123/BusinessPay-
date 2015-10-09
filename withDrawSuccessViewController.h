//
//  withDrawSuccessViewController.h
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-12.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseViewController.h"
#import "AccountDO.h"

@interface withDrawSuccessViewController : BaseViewController

@property (nonatomic,strong) AccountDO *accountDO;

@property (nonatomic,strong) NSString * money;

@property (nonatomic,assign) int buttonIndex;


@end
