//
//  IntroduceViewController.m
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-3.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "IntroduceViewController.h"

@interface IntroduceViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;


@end

@implementation IntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view.
    //[self.navigationController setTitle:@"钱海钱包简介"];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH,20)];
    imageView.image = [UIImage imageNamed:@"titleNew.png"];
    [self.view addSubview:imageView];
 
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleNew.png"] forBarMetrics:UIBarMetricsDefault];
    
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbackground"] forBarMetrics:UIBarMetricsDefault];
    //[self.navigationItem setTitle:@"钱海钱包简介"];
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"钱海钱包简介"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    self.textView.editable=NO;
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if([textView isFirstResponder]){
        return YES;
    }
    return NO;
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
