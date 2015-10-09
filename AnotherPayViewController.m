//
//  AnotherPayViewController.m
//  BusinessPay
//
//  Created by SHANGYITONG on 14-12-16.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "AnotherPayViewController.h"

@interface AnotherPayViewController ()

@end

@implementation AnotherPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView setDelegate:self];
    
    self.webView.scrollView.bounces=NO;
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"mytitle"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"titleNew.png"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundColor:[UIColor colorWithRed:25/255.f green:25/255.f  blue:25/255.f  alpha:1.0]];
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:225/255.f green:225/255.f blue:225/255.f alpha:1.0]];
    //self.webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320,700)];
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:self.link]];
    NSLog(@"mylink=%@",self.link);
    //[UIComponentService showHudWithStatus:kPleaseWait];
    [self.webView loadRequest:request];
    
    
    //毛军亮
   // [self.view addSubview:self.webView];
    // Do any additional setup after loading the view.
}

-(void)dismissAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}


-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
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
