//
//  FateListViewController.h
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-2.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseViewController.h"
#import "FateListDO.h"
#import "BuyFateDO.h"

@interface FateListViewController : UITableViewController<FateListDelegate,BuyFateDelegate,UIAlertViewDelegate,UITextFieldDelegate>


@property (nonatomic,strong) NSMutableArray *temArr;
@property (nonatomic,strong) UIAlertView *alertView;



@end
