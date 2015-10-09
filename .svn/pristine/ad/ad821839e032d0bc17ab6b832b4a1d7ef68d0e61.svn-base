//
//  LockViewController.m
//  BusinessPay
//
//  Created by Tears on 14-5-10.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "LockViewController.h"

@interface LockViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;

@end

@implementation LockViewController

- (IBAction)tapAction:(id)sender {
    [self.view endEditing:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self performSelector:@selector(textFieldbecomeFirstResponder:) withObject:self.passWordTextField afterDelay:kDelayTime ];
}

- (IBAction)lockAction:(id)sender {
    
    if (![self.passWordTextField.text isEqualToString:[User shareUser].passWord]) {
        [self showWarmingWithMessage:@"密码错误"];
        return;
    }
    
    CATransition *animation = [CATransition animation];
    animation.duration = 1.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"rippleEffect";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
