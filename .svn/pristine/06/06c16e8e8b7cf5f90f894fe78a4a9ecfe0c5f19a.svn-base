//
//  ReChangeStatusViewController.m
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-18.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "ReChangeStatusViewController.h"

@implementation ReChangeStatusViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleNew.png"] forBarMetrics:UIBarMetricsDefault];
    if (self.status==0) {
        self.imageView.image=[UIImage imageNamed:@"withDrawSuccess"];
        self.statusLabel.text=@"充值成功";
    }else
    {
        self.imageView.image=[UIImage imageNamed:@"failed"];
        self.statusLabel.text=@"充值失败";
    }
}


-(void)backAction:(id)sender
{
    if (self.status==0) {
        [self performSegueWithIdentifier:@"toPayVCSegue" sender:self];
    }else
    {
       // [self dismissViewControllerAnimated:YES completion:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
