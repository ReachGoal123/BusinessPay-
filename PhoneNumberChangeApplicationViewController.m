//
//  PhoneNumberChangeApplicationViewController.m
//  BusinessPay
//
//  Created by Tears on 14-4-17.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "PhoneNumberChangeApplicationViewController.h"
#import "RealNameVerificationViewController.h"
#import "UploadPhotoNumberChangeViewController.h"

@interface PhoneNumberChangeApplicationViewController ()
{
    NSArray *_arr;
}

- (IBAction)phoneNumberChangeAction:(id)sender;
- (IBAction)SMSVerificationAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *oldPhoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberNewTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmNewPhoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *messageVerificationTextField;

@end

@implementation PhoneNumberChangeApplicationViewController





- (void)viewDidLoad
{
    [super viewDidLoad];
    self.oldPhoneNumberTextField.userInteractionEnabled = NO;
    NSString *phoneNumberFirst=[[User shareUser].phoneNumber substringToIndex:3];
    NSString *phoneNumberLast=[[User shareUser].phoneNumber substringFromIndex:[User shareUser].phoneNumber.length-4];
    
    
    self.oldPhoneNumberTextField.text = [NSString stringWithFormat:@"%@****%@",phoneNumberFirst,phoneNumberLast];
    [self performSelector:@selector(textFieldbecomeFirstResponder:) withObject:self.phoneNumberNewTextField afterDelay:kDelayTime];
    [self setKeyBoard];
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"钱  包"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
}

- (void)setKeyBoard
{
    NSArray *tfArr = [NSArray arrayWithObjects:self.oldPhoneNumberTextField,self.phoneNumberNewTextField,self.confirmNewPhoneNumberTextField,self.messageVerificationTextField, nil];
    
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
    if ([segue.identifier isEqualToString:@"phoneNumberChangeSegue"]) {
        RealNameVerificationViewController * realNameVC = (RealNameVerificationViewController *)segue.destinationViewController;
        realNameVC.type = RealNameVerificationType_PhoneNumber;
    }
    if([segue.identifier isEqualToString:@"photoSegue"])
    {
        UploadPhotoNumberChangeViewController *upvc=(UploadPhotoNumberChangeViewController *)segue.destinationViewController;
        upvc.array=_arr;
    }

}


- (IBAction)phoneNumberChangeAction:(id)sender {
    if(self.oldPhoneNumberTextField.text.length == kTextLengthZero){
        [self showWarmingWithMessage:@"请输入旧手机号"];
        return;
    }
    
    if (![self.phoneNumberNewTextField.text isEqualToString:self.confirmNewPhoneNumberTextField.text]) {
        [self showWarmingWithMessage:@"手机号不一致"];
        return;
    }
    [self.view endEditing:YES];
    [UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(phoneNumberRequest) withObject:nil afterDelay:kDelayTime];
    
}

- (void)phoneNumberRequest
{
    PhoneNumberChangeDO * phoneNumberChangeDO = [[PhoneNumberChangeDO alloc] init];
    phoneNumberChangeDO.delegate = self;
    phoneNumberChangeDO.phoneNumberNew = self.phoneNumberNewTextField.text;
    NSLog(@"newPhoneNumber=%@",phoneNumberChangeDO.phoneNumberNew);
    phoneNumberChangeDO.phoneNumber = [User shareUser].phoneNumber;
    phoneNumberChangeDO.messageCaptcha = self.messageVerificationTextField.text;
    phoneNumberChangeDO.trancode = kTrancode_PhoneNumberChange;
    
    _arr=[NSArray arrayWithObjects:kTrancode_PhoneNumberChange,[User shareUser].phoneNumber,self.phoneNumberNewTextField.text,self.messageVerificationTextField.text, nil];
    
    [phoneNumberChangeDO phoneNumberChangeRequest];
}

- (IBAction)SMSVerificationAction:(id)sender {
    BOOL isPhoneNumber = [BaseModel isValidPhone:self.phoneNumberNewTextField.text];
    if (isPhoneNumber == NO) {
        [self showWarmingWithMessage:@"新手机号码有误"];
        return;
    }
    [UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(SMSVerificationRequest) withObject:nil afterDelay:kDelayTime];
}

- (void)SMSVerificationRequest
{
    PhoneNumberChangeDO * phoneNumberChangeDO = [[PhoneNumberChangeDO alloc] init];
    phoneNumberChangeDO.delegate = self;
    //    15989343631
    [UIComponentService showHudWithStatus:kPleaseWait];
    phoneNumberChangeDO.phoneNumberNew = self.phoneNumberNewTextField.text;
    phoneNumberChangeDO.trancode = kTrancode_PhoneNumberChangeVerification ;
    [phoneNumberChangeDO phoneNumberChangeMessageVerificationRequest];
}

- (void)phoneNumberChangeSuccessWithMessage: (NSString *)message
{
    [UIComponentService showSuccessHudWithStatus:@"拍摄身份证正面照和情景照"];
    
    [self performSelector:@selector(pushViewController) withObject:nil afterDelay:2.f];
    
}

- (void)pushViewController
{
    [self performSegueWithIdentifier:@"photoSegue" sender:self];
}

- (void)phoneNumberChangeFailWithMessage: (NSString *)message
{
    [UIComponentService showFailHudWithStatus:message];
}

- (void)phoneNumberChangeMessageVerificationSuccessWithMessage: (NSString *)message
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
    
    if (self.oldPhoneNumberTextField == textField)
    {
        if ([toBeString length] > 11) {
            textField.text = [toBeString substringToIndex:11];
            return NO;
        }
    }
    if (self.phoneNumberNewTextField == textField)
    {
        if ([toBeString length] > 11) {
            textField.text = [toBeString substringToIndex:11];
            return NO;
        }
    }
    if (self.confirmNewPhoneNumberTextField == textField)
    {
        if ([toBeString length] > 11) {
            textField.text = [toBeString substringToIndex:11];
            return NO;
        }
    }
    return YES;
}

@end
