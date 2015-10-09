//
//  CodeingViewController.m
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-4.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "CodeingViewController.h"
#import "QRCodeGenerator.h"

@interface CodeingViewController ()
{
    UIImage *codeImage;
    QRPointType pointType;
    QRPositionType positionType;
    UIColor *codeColor;

}
@end

@implementation CodeingViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleNew.png"] forBarMetrics:UIBarMetricsDefault];
    self.nameLabel.text=self.name;
   // NSLog(@"nameLabel=%@",self.nameLabel.text);
    

    pointType = QRPointRect;
    positionType = QRPositionNormal;
    codeColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    //    codeColor = [UIColor darkGrayColor];
    [self.imageView setBackgroundColor:[UIColor lightGrayColor]];
    codeImage = [QRCodeGenerator qrImageForString:_codeContent imageSize:self.imageView.frame.size.width withPointType:pointType withPositionType:positionType withColor:codeColor];
    [self.imageView setImage:codeImage];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
