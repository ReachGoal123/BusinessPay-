//
//  AccountDetailViewController.h
//  BusinessPay
//
//  Created by SHANGYITONG on 14-12-24.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountDO.h"

@interface AccountDetailViewController : UIViewController
{
//    NSMutableArray *_arrayImage;
}

@property (nonatomic,strong) AccountDO *accountDO;

//@property (nonatomic,strong)IBOutlet UITableView *tableView;


@property(nonatomic,strong) IBOutlet UILabel *weekIncome;
@property(nonatomic,strong) IBOutlet UILabel *monthIncome;
@property(nonatomic,strong) IBOutlet UILabel *totalIncome;
@property(nonatomic,strong) IBOutlet UILabel *yestodayIncome;
@property(nonatomic,strong) IBOutlet UILabel *totalAccount;

//-(IBAction)clickButton:(id)sender;

@end
