//
//  ChooseBankViewController.h
//  BusinessPay
//
//  Created by SHANGYINTONG on 15/4/24.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderCreateDO.h"

@interface ChooseBankViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,OrderCreateDelegate>


@property (nonatomic,strong) NSString *money;

@end
