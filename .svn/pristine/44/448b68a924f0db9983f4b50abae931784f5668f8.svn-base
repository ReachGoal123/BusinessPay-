//
//  ReSetPayPasswordViewController.m
//  BusinessPay
//
//  Created by SHANGYITONG on 14-12-24.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "ReSetPayPasswordViewController.h"
//@class MyAccountViewController;
//#import "MyAccountViewController.h"

@implementation ReSetPayPasswordViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setKeyBoard];
    
    [self performSelector:@selector(textFieldbecomeFirstResponder:) withObject:nil afterDelay:kDelayTime];
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"重设支付密码"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
}


- (void)setKeyBoard
{
    NSArray *tfArr = [NSArray arrayWithObjects:_password,_confirmPassword, nil];
    
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



-(void)clickConfirmButton:(id)sender
{
    if ([self.password.text isEqualToString:[User shareUser].passWord])
    {
        [self showWarmingWithMessage:@"支付密码不能与登录密码一致"];
        return;
    }
    if (![self.password.text isEqualToString:self.confirmPassword.text]) {
        [self showWarmingWithMessage:@"支付密码与确认密码不一致"];
        return;
    }
    ResetPayPasswordDO *payPasswordChange=[[ResetPayPasswordDO alloc] init];
    payPasswordChange.trancode=kTrancode_FindPayPasswordReset;
    payPasswordChange.phoneNumber=[User shareUser].phoneNumber;
    payPasswordChange.password=self.password.text;
    payPasswordChange.delegate=self;
    
    [UIComponentService showHudWithStatus:kPleaseWait];
    [payPasswordChange reSetPasswordRequest];

}


-(void)tapAction:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES ];
}


-(void)reSetPasswordSuccessWithMessage:(NSString *)message
{
    [UIComponentService showSuccessHudWithStatus:@"重置支付密码成功"];
    //[self dismissViewControllerAnimated:YES completion:nil];
    //MyAccountViewController *myAccountVC=[[MyAccountViewController alloc]init];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    //[self.navigationController popToViewController:myAccountVC animated:YES];
}

-(void)reSetPasswordFieldWithMessage:(NSString *)message
{
    [UIComponentService showFailHudWithStatus:message];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.password == textField)
    {
        if ([toBeString length] > 6) {
            textField.text = [toBeString substringToIndex:6];
            return NO;
        }
    }
    if (self.confirmPassword == textField)
    {
        if ([toBeString length] > 6) {
            textField.text = [toBeString substringToIndex:6];
            return NO;
        }
    }
    return YES;
}


@end
