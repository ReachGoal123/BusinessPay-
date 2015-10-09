//
//  OrderListTableViewCell.h
//  BusinessPay
//
//  Created by SHANGYITONG on 15-1-13.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLab;
@property (weak, nonatomic) IBOutlet UILabel *payTimeLab;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
//@property (weak, nonatomic) IBOutlet UILabel *orderType;


@end
