//
//  FindPayPasswordViewController.m
//  BusinessPay
//
//  Created by SHANGYITONG on 14-12-24.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "FindPayPasswordViewController.h"
#import "ReSetPayPasswordViewController.h"
#import "MerchantDO.h"


@implementation FindPayPasswordViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setKeyBoard];
    [self performSelector:@selector(textFieldbecomeFirstResponder:) withObject:self.phoneNumber afterDelay:kDelayTime];
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"找回在支付密码"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleNew.png"] forBarMetrics:UIBarMetricsDefault];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    selectedTextFieldTag=textField.tag;
    if(selectedTextFieldTag==101)
    {
        //[self performSelector:@selector(merchantRequest) withObject:nil afterDelay:kDelayTime];
        [self merchantRequest];
    }
}



-(void)merchantRequest
{
    MerchantDO *merchantDO=[[MerchantDO alloc] init];
    merchantDO.trancode=kTrancode_MerchantData;
    merchantDO.phoneNumber=[User shareUser].phoneNumber;
    merchantDO.termType=kTermType;
    [merchantDO merchantInformationInquiryRequest];
}


- (void)setKeyBoard
{
    NSArray *tfArr = [NSArray arrayWithObjects:_phoneNumber,_cardID,_messageCode, nil];
    
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



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([segue.identifier isEqualToString:@"resetPayPasswordSuegue"]) {
//        ReSetPayPasswordViewController * reSetPassword  =(ReSetPayPasswordViewController *)segue.destinationViewController;
        //changePassword.phoneNumber = self.phoneNumber.text;
//    }
}

//- (IBAction)disMissAction:(UIBarButtonItem *)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

- (IBAction)comfireMessage:(id)sender {
    [self.view endEditing:YES];
    BOOL isPhoneNumber = [BaseModel isValidPhone:self.phoneNumber.text];
    BOOL isIDCard = [BaseModel Chk18PaperId:self.cardID.text];
    if (self.phoneNumber.text.length == kTextLengthZero) {
        [self showWarmingWithMessage:@"请输入此用户手机号"];
        return;
    }
    if (!isPhoneNumber) {
        [self showWarmingWithMessage:@"手机号码有误"];
        return;
    }
    if(![self.phoneNumber.text isEqualToString:[User shareUser].phoneNumber])
    {
        [self showWarmingWithMessage:@"请输入此用户手机号"];
        return;
    }
    if (!isIDCard) {
        [self showWarmingWithMessage:@"身份证号码有误"];
        return;
    }
    if(![self.cardID.text isEqualToString:[User shareUser].IDcard])
    {
        
        [self showWarmingWithMessage:@"请输入本人身份证号"];
    }
    if (self.messageCode.text.length == kTextLengthZero) {
        [self showWarmingWithMessage:@"验证码不能为空"];
        return;
    }
    
    [UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(FindPasswrodRequest) withObject:nil afterDelay:kDelayTime];
    
}

- (void) FindPasswrodRequest
{
    FindPayPasswordDO * findPasswordDO = [[FindPayPasswordDO alloc] init];
    findPasswordDO.delegate = self;
    //findPasswordDO.appType = kAppType;
     findPasswordDO.trancode = kTrancode_FindPayPasswordVerification;
    findPasswordDO.phoneNumber = self.phoneNumber.text;
    findPasswordDO.IDCard = self.cardID.text;
    //findPasswordDO.messageVerCode = self.messageCode.text;
    findPasswordDO.messageVerCode=self.messageCode.text;
    NSLog(@"%@",findPasswordDO.messageVerCode);
    [findPasswordDO findPayPasswordRequest];
}

- (IBAction)gainMessageCode:(id)sender {
    
    [self.view endEditing:YES];
    BOOL isPhoneNumber = [BaseModel isValidPhone:self.phoneNumber.text];
    BOOL isIDCard = [BaseModel Chk18PaperId:self.cardID.text];
    if (!isPhoneNumber) {
        [self showWarmingWithMessage:@"手机号码有误"];
        return;
    }
    if(![self.phoneNumber.text isEqualToString:[User shareUser].phoneNumber])
    {
        [self showWarmingWithMessage:@"请输入此用户手机号"];
        return;
    }

    if (!isIDCard) {
        [self showWarmingWithMessage:@"身份证号码有误"];
        return;
    }
    if(![self.cardID.text isEqualToString:[User shareUser].IDcard])
    {
        [self showWarmingWithMessage:@"请输入本人身份证号"];
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
    FindPayPasswordDO * findPasswordDO = [[FindPayPasswordDO alloc] init];
    findPasswordDO.delegate         = self;
    //findPasswordDO.appType          = kAppType;
    findPasswordDO.trancode  = kTrancode_FindPaypasswordSMVerification ;
    findPasswordDO.IDCard    =self.cardID.text;
    findPasswordDO.phoneNumber      = self.phoneNumber.text;
    [findPasswordDO findPayPasswordMessageVerificationRequest];
}

- (void)findPayPasswordSuccessWithMessage:(NSString *)message
{
    [UIComponentService showSuccessHudWithStatus:message];
    [self performSegueWithIdentifier:@"resetPayPasswordSuegue" sender:self];
}

- (void)findPayPasswordFieldWithMessage:(NSString *)message
{
    [UIComponentService showFailHudWithStatus:message];
}

- (void)messageVerificationSuccessWithMessage:(NSString *)message
{
    [UIComponentService showSuccessHudWithStatus:message];
}

- (void)messageVerificationFieldWithMessage:(NSString *)message
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
    
    if (self.cardID == textField)
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
