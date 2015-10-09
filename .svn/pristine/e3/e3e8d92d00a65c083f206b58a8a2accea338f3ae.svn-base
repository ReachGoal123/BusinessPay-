//
//  SoftwarVersionViewController.m
//  BusinessPay//
//  Created by SHANGYITONG on 15-1-6.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "SoftwarVersionViewController.h"

@implementation SoftwarVersionViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH,20)];
    imageView.image = [UIImage imageNamed:@"titleNew.png"];
    [self.view addSubview:imageView];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleNew.png"] forBarMetrics:UIBarMetricsDefault];
    

    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"软件版本"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    
    NSString *version=[SoftwarVersionViewController getIOSVersion];
    self.label.text=[NSString stringWithFormat:@"当前版本： %@",version];
}

+ (NSString *)getIOSVersion{
    NSDictionary *infoDict = [[NSBundle mainBundle]infoDictionary];
    
    return [infoDict objectForKey:@"CFBundleShortVersionString"];
}
@end
