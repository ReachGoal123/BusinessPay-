//
//  ReChangeStatusViewController.h
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-18.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseViewController.h"

@interface ReChangeStatusViewController : BaseViewController


@property (nonatomic,assign) int status;

@property (nonatomic,weak) IBOutlet UIImageView *imageView;
@property (nonatomic,weak) IBOutlet UILabel *statusLabel;


-(IBAction)backAction:(id)sender;

@end
