//
//  ChangePayPasswordViewController.m
//  BusinessPay
//
//  Created by SHANGYITONG on 14-12-24.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "ChangePayPasswordViewController.h"

@implementation ChangePayPasswordViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setKeyBoard];
    
    //[UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(textFieldbecomeFirstResponder:) withObject:nil afterDelay:kDelayTime];
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"修改支付密码"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
}


- (void)setLabBackground
{
    for (int i = 8; i < 12; i++) {
        UILabel * lab = (UILabel *)[self.view viewWithTag:i];
        lab.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"registertext"]];
    }
}

- (void)setKeyBoard
{
    NSArray *tfArr = [NSArray arrayWithObjects:_oldPassword,_password,_verifyPassword, nil];
    
    [IQKeyboardManager sharedManager];
    
    for (int i = 0; i < tfArr.count; i++) {
        UITextField *tf = (UITextField *)[tfArr objectAtIndex:i];
        tf.delegate = self;
        [tf addPreviousNextDoneOnKeyboardWithTarget:self
                                     previousAction:@selector(previousClicked:)
                                         nextAction:@selector(nextClicked:)
                                         doneAction:@selector(doneClicked:)];
        //First textField
        if (i == 0)
        {
            [tf setEnablePrevious:NO next:YES];
        }
        //Last textField
        else if(i== tfArr.count - 1)
        {
            [tf setEnablePrevious:YES next:NO];
        }
    }
}




#pragma mark - toolBarItemAction

-(void)nextClicked:(UISegmentedControl*)segmentedControl
{
    [(UITextField*)[self.view viewWithTag:selectedTextFieldTag+1] becomeFirstResponder];
}

-(void)doneClicked:(UIBarButtonItem*)barButton
{
    [self.view endEditing:YES];
}

-(void)previousClicked:(UISegmentedControl*)segmentedControl
{
    [(UITextField*)[self.view viewWithTag:selectedTextFieldTag-1] becomeFirstResponder];
}



-(void)tapAction:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}


-(void)cilckButton:(id)sender
{
    if (self.oldPassword.text.length == kTextLengthZero) {
        [self showWarmingWithMessage:@"请输入原支付密码"];
    }
    
    if ([self.password.text isEqualToString:[User shareUser].passWord])
    {
        [self showWarmingWithMessage:@"支付密码不能与登录密码一致"];
        return;
    }
    if (self.oldPassword.text.length != kTextLengthZero&&[self.oldPassword.text isEqualToString:self.password.text])
    {
        [self showWarmingWithMessage:@"新支付密码不能与原支付密码一致"];
        return;
    }
    if (![self.password.text isEqualToString:self.verifyPassword.text]) {
        [self showWarmingWithMessage:@"支付密码与确认密码不一致"];
        return;
    }
    PayPasswordChange *payPasswordChange=[[PayPasswordChange alloc] init];
    payPasswordChange.trancode=kTrancode_PayPasswordChange;
    payPasswordChange.phoneNumber=[User shareUser].phoneNumber;
    payPasswordChange.oldPassword=self.oldPassword.text;
    payPasswordChange.Passwords=self.password.text;
    payPasswordChange.delegate=self;
    
    
    [UIComponentService showHudWithStatus:kPleaseWait];
    [payPasswordChange payPasswordChangeRequest];
    
    
}

-(void)payPasswordChangeFieldWithMessage:(NSString *)message
{
    [UIComponentService showFailHudWithStatus:message];
}

-(void)payPasswordChangeResponseSuccessWithMessage:(NSString *)message
{
    [UIComponentService showSuccessHudWithStatus:@"支付密码修改成功"];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.oldPassword == textField)
    {
        if ([toBeString length] > 6) {
            textField.text = [toBeString substringToIndex:6];
            return NO;
        }
    }
    if (self.password == textField)
    {
        if ([toBeString length] > 6) {
            textField.text = [toBeString substringToIndex:6];
            return NO;
        }
    }
    if (self.verifyPassword == textField)
    {
        if ([toBeString length] > 6) {
            textField.text = [toBeString substringToIndex:6];
            return NO;
        }
    }
    return YES;
}


@end
