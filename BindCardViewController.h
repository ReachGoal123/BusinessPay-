//
//  BindCardViewController.h
//  BusinessPay
//
//  Created by SHANGYINTONG on 15/4/29.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseViewController.h"
#import "BindCardDO.h"
#import "YiBaoPayChannelDO.h"

@interface BindCardViewController : BaseViewController<BindCardDelegate,YiBaoPayChannelDelegate,UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>


@property (nonatomic,strong) NSMutableArray *arr;

@property (nonatomic,strong) NSString *money;

@property (nonatomic,strong) NSString *cardTel;

@end
