//
//  FindPassWordViewController.m
//  BusinessPay
//
//  Created by Tears on 14-4-10.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "FindPassWordViewController.h"
#import "ChangePasswordAfterVerificationViewController.h"

@interface FindPassWordViewController ()

- (IBAction)disMissAction:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *idCard;
@property (weak, nonatomic) IBOutlet UITextField *messageVerificate;
- (IBAction)findAction:(id)sender;
- (IBAction)SMSVerificationAction:(id)sender;
- (IBAction)tapAction:(UITapGestureRecognizer *)sender;

@end

@implementation FindPassWordViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleNew.png"] forBarMetrics:UIBarMetricsDefault];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleNew.png"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"找回密码"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    [self performSelector:@selector(textFieldbecomeFirstResponder:) withObject:self.phoneNumber afterDelay:kDelayTime];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"changePasswordSegue"]) {
        ChangePasswordAfterVerificationViewController * changePassword  =(ChangePasswordAfterVerificationViewController *)segue.destinationViewController;
        changePassword.phoneNumber = self.phoneNumber.text;
    }
}

- (IBAction)disMissAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)findAction:(id)sender {
    [self.view endEditing:YES];
    BOOL isPhoneNumber = [BaseModel isValidPhone:self.phoneNumber.text];
    //BOOL isIDCard = [BaseModel Chk18PaperId:self.idCard.text];
    if (!isPhoneNumber) {
        [self showWarmingWithMessage:@"手机号码有误"];
        return;
    }
    if (self.messageVerificate.text.length == kTextLengthZero) {
        [self showWarmingWithMessage:@"验证码不能为空"];
        return;
    }
    
    [UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(FindPasswrodRequest) withObject:nil afterDelay:kDelayTime];
    
}

- (void) FindPasswrodRequest
{
    FindPasswordDO * findPasswordDO = [[FindPasswordDO alloc] init];
    findPasswordDO.delegate = self;
    findPasswordDO.appType = kAppType;
    findPasswordDO.phoneNumber = self.phoneNumber.text;
    //findPasswordDO.IDCard = self.idCard.text;
    findPasswordDO.messageCaptcha = self.messageVerificate.text;
    findPasswordDO.trancode = kTrancode_ForgetPassword;
    [findPasswordDO findPasswordRequest];
}

- (IBAction)SMSVerificationAction:(id)sender {

    [self.view endEditing:YES];
    BOOL isPhoneNumber = [BaseModel isValidPhone:self.phoneNumber.text];
    BOOL isIDCard = [BaseModel Chk18PaperId:self.idCard.text];
    if (!isPhoneNumber) {
        [self showWarmingWithMessage:@"手机号码有误"];
        return;
    }
    
    [UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(SMSVerificationRequest) withObject:nil afterDelay:kDelayTime];
}

- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

- (void)SMSVerificationRequest
{
    FindPasswordDO * findPasswordDO = [[FindPasswordDO alloc] init];
    findPasswordDO.delegate         = self;
    findPasswordDO.appType          = kAppType;
    findPasswordDO.messageTrancode  = kTrancode_ForgetPasswordSMSVerification ;
    findPasswordDO.phoneNumber      = self.phoneNumber.text;
    //findPasswordDO.IDCard           = self.idCard.text;
    //findPasswordDO.termno           = kNil;
    [findPasswordDO findPasswordMessageVerificationRequest];
}

- (void)findPasswordSuccessWithMessage:(NSString *)message
{
    [UIComponentService showSuccessHudWithStatus:message];
    [self performSegueWithIdentifier:@"changePasswordSegue" sender:self];
}

- (void)findPasswordFieldWithMessage:(NSString *)message
{
    [UIComponentService showFailHudWithStatus:message];
}

- (void)messageVerificationSuccessWithMessage:(NSString *)message
{
    [UIComponentService showSuccessHudWithStatus:message];
}

- (void)messageVerificationSuccessFieldWithMessage:(NSString *)message
{
    [UIComponentService showFailHudWithStatus:message];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.idCard == textField)
    {
        if ([toBeString length] > 18) {
            textField.text = [toBeString substringToIndex:18];
            return NO;
        }
    }
    if (self.phoneNumber == textField)
    {
        if ([toBeString length] > 11) {
            textField.text = [toBeString substringToIndex:11];
            return NO;
        }
    }
    return YES;
}


@end
