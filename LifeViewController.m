//
//  LifeViewController.m
//  BusinessPay
//
//  Created by Tears on 14-4-24.
//  Copyright (c) 2014年 Tears. All rights reserved.
//



#import "LifeViewController.h"

@interface LifeViewController ()


@end

@implementation LifeViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title"] forBarMetrics:UIBarMetricsDefault];
    
    
    UIImage *title_bg = [UIImage imageNamed:@"titleNew.png"];  //获取图片
    CGSize titleSize = self.navigationController.navigationBar.bounds.size;  //获取Navigation Bar的位置和大小
    title_bg = [self scaleToSize:title_bg size:titleSize];//设置图片的大小与Navigation Bar相同
    [self.navigationController.navigationBar
     setBackgroundImage:title_bg
     forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = YES;
    
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"钱海钱包"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    
    
}
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self showWarmingWithMessage:@"即将开通"];
    //[self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
     [self showWarmingWithMessage:@"即将开通!"];
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"附  近"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
//    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 20)];
//    imageView.image = [UIImage imageNamed:@"navbackground"];
//    [self.view addSubview:imageView];

    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
//    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 5)];
//    view.backgroundColor = [UIColor clearColor];
}

//- (IBAction)clickAction:(id)sender {
//    [self showWarmingWithMessage:@"即将开通"];
//}

@end
