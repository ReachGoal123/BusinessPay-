//
//  ChangePasswordAfterVerificationViewController.m
//  BusinessPay
//
//  Created by Tears on 14-4-16.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "ChangePasswordAfterVerificationViewController.h"

@interface ChangePasswordAfterVerificationViewController ()
- (IBAction)changePasswordAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *passwordNewTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordNewTextField;

@end

@implementation ChangePasswordAfterVerificationViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"登录密码修改"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
}

- (IBAction)changePasswordAction:(id)sender {
    
    if (self.passwordNewTextField.text.length < 6) {
        [self showWarmingWithMessage:@"密码为6—15位数字，字母或特殊符号"];
        return;
    }
    if (![self.passwordNewTextField.text isEqualToString:self.confirmPasswordNewTextField.text]) {
        [self showWarmingWithMessage:@"密码不一致"];
        return;
    }
    [self.view endEditing:YES];
    [UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(resetPasswordRequest) withObject:nil afterDelay:kDelayTime];
}

- (void) resetPasswordRequest
{
    ChangePasswordDO * changePasswordDO = [[ChangePasswordDO alloc] init];
    changePasswordDO.phoneNumber = self.phoneNumber;
    changePasswordDO.passWordnew = self.passwordNewTextField.text;
    changePasswordDO.trancode = kTrancode_ResetPassword ;
    changePasswordDO.delegate = self;
    [changePasswordDO changePasswordAfterVerificationRequest];
}

- (void)changePasswordSuccessWithMessage:(NSString *)message
{
    [UIComponentService showSuccessHudWithStatus:@"修改密码成功，请重新登录"];
    [self.loginVC savePhoneNumber:nil andPassword:nil];
     [LLLockPassword saveLockPassword:nil];
    
    [self performSegueWithIdentifier:@"toLoginSegue" sender:self];
    
}

- (void)changePasswordFieldWithMessage:(NSString *)message
{
    [UIComponentService showSuccessHudWithStatus:message];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.passwordNewTextField == textField)
    {
        if ([toBeString length] > 15) {
            textField.text = [toBeString substringToIndex:15];
            return NO;
        }
    }
    if (self.confirmPasswordNewTextField == textField)
    {
        if ([toBeString length] > 15) {
            textField.text = [toBeString substringToIndex:15];
            return NO;
        }
    }
    return YES;
}


@end
