//
//  HelpPhoneNumberViewController.m
//  BusinessPay
//
//  Created by SHANGYITONG on 15-1-6.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "HelpPhoneNumberViewController.h"

@implementation HelpPhoneNumberViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH,20)];
    imageView.image = [UIImage imageNamed:@"titleNew.png"];
    [self.view addSubview:imageView];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleNew.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"客服电话"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    
   // self.label.text=@"客服电话 ";
}



-(void)clickButton:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://4008719668"]];

}

@end
