//
//  MyCircleTableViewCell.h
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-17.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCircleTableViewCell : UITableViewCell

@property (weak,nonatomic) IBOutlet UILabel *merchantNameLabel;
@property (weak,nonatomic) IBOutlet UILabel *merchantPhoneNumberLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageIV;


@end
