//
//  GuideViewController.m
//  BusinessPay
//
//  Created by SHANGYINTONG on 15/5/8.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()

@property (nonatomic,strong) UIScrollView *scrollView;


@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *arr=[NSArray arrayWithObjects:@"firstGuide.png",@"secondGuide.png",@"thirdGuide", nil];
    //数组内放的是图片
    self.scrollView=[[UIScrollView alloc] initWithFrame:self.view.bounds];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
