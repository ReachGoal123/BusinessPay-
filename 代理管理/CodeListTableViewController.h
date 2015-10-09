//
//  CodeListTableViewController.h
//  BusinessPay
//
//  Created by zm on 7/5/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodeNotUserImformationQuery.h"

@interface CodeListTableViewController : UITableViewController

@property(strong, nonatomic)NSMutableArray *codeArr;

@property(strong, nonatomic)CodeNotUserImformationQuery *codeImformation;

@end
