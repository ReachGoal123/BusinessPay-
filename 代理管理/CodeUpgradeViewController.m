//
//  CodeUpgradeViewController.m
//  BusinessPay
//
//  Created by SHANGYINTONG on 15/5/11.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "CodeUpgradeViewController.h"
#import "FateViewController.h"


@interface CodeUpgradeViewController ()

@property(nonatomic,strong) UIAlertView *alertView;

@end

@implementation CodeUpgradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _codeField.keyboardType = UIKeyboardTypeNumberPad;
    
    
    [self.navigationItem setHidesBackButton:NO];
    
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"费率升级"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];

    [self setKeyBoard];
    
    
    NSString *codeNum = self.codeField.text;
    if (codeNum ==NULL) {
        self.codeButton.enabled = YES;
    }else{
        self.codeButton.enabled = NO;
    }
    
}

- (void) popToRootView{
    FateViewController *fateview =  [[FateViewController alloc]init];
    [self.navigationController popToViewController:fateview animated:YES];

}

- (void)setKeyBoard
{
    NSArray *tfArr = [NSArray arrayWithObjects:_codeField, nil];
    
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


-(IBAction)upgradeButton:(id)sender{
    
//    [UIComponentService showHudWithStatus:kPleaseWait];
    
    User *user = [User shareUser];
    NSString *codeNum = self.codeField.text;
    
    NSLog(@"codeNum---%@",codeNum);
    
    CodeUpgradeTO *codeup = [[CodeUpgradeTO alloc]init];
    codeup.delegate = self;
    
    codeup.trancode = @"701708";
    codeup.userTelephone = user.phoneNumber;
    codeup.upgradeType = @"1";
    codeup.userCode = codeNum;
    
    [codeup CodeUpgradeTORequset];
    

}

- (void)CodeUpgradeTOSuccessWithMessage: (NSString *)message{

    NSLog(@"CodeUpgradeTOSuccessWithMessage 成功");
    
    self.alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [self.alertView show];
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    [self.alertView dismissWithClickedButtonIndex:0 animated:YES];
    [self performSegueWithIdentifier:@"huizhuye" sender:nil];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
//    self.navigationController.navigationBarHidden = YES;
    
}








- (void)CodeUpgradeTOFildWithMessage: (NSString *)message{
    
    NSLog(@"CodeUpgradeTOFildWithMessage 失败");
    [UIComponentService showFailHudWithStatus:message];

}


-(IBAction)accountUpgradeButton:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];
}
@end
