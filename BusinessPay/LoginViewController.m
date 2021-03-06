//
//  LoginViewController.m
//  BusinessPay
//
//  Created by Tears on 14-4-9.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "LoginViewController.h"
#import "PayViewController.h"
#import "MyAccountViewController.h"


@interface LoginViewController ()
{
    NSInteger   selectedTextFieldTag;
    BOOL       setPasswordCanSee;
}

@property (weak, nonatomic) IBOutlet UITextField *userID;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (copy,nonatomic) LoginDO *loginDO;




- (IBAction)loginAction:(id)sender;
- (IBAction)isSeePassword:(id)sender;

@end

@implementation LoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setKeyBoard];
    
    [self performSelector:@selector(updateRequset) withObject:nil afterDelay:kDelayTime];
    
}

-(void) updateRequset
{
    UpdateVersionDO *updateVersionDO=[[UpdateVersionDO alloc] init];
    
    updateVersionDO.trancode=@"199000";
    updateVersionDO.delegate=self;
    
    [updateVersionDO updateRequest];
    
    
}

#pragma mark - updateDelegate


-(void)updateSuccessWithMessage:(NSString *)message withUpdateVersion:(UpdateVersionDO *)updateDO
{
    //PhoneNOAndName=[[User shareUser].phoneNumber stringByAppendingString:[User shareUser].userName]
    if ([updateDO.isUpdate isEqualToString:@"1"]) {
        NSString *appUrl=[@"itms-services://?action=download-manifest&url=" stringByAppendingString:updateDO.updateUrl];
        
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-services://?action=download-manifest&url=https://download.qhno1.com/ios/qhpay.plist"]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appUrl]];
        
    }else
    {
        return;
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    self.userID.text=[User shareUser].phoneNumber;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toGestureSegue"]) {
        LLLockViewController *llLockVC=(LLLockViewController *)segue.destinationViewController;
        
        // llLockVC.lockVc.nLockViewType=lockViewtype;
        llLockVC.nLockViewType=lockViewtype;
        llLockVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
    }
    
    
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    NSString * phoneNumber = [ud objectForKey:@"phoneNumber"];
    //NSString * password=[ud objectForKey:@"password"];
    if (textField.tag==101 && ![self.userID.text isEqualToString:phoneNumber]) {
        [self savePhoneNumber:nil andPassword:nil];
    }
}

-(void)isSeePassword:(id)sender
{
    if(setPasswordCanSee)
    {
        self.passWord.secureTextEntry=YES;
        setPasswordCanSee=NO;
    }else
    {
        self.passWord.secureTextEntry=NO;
        setPasswordCanSee=YES;
    }
}

//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex==1) {
//        self.passWord.secureTextEntry=NO;
//    }else
//    {
//        self.passWord.secureTextEntry=YES;
//    }
//}

- (void)setKeyBoard
{
    NSArray *tfArr = [NSArray arrayWithObjects:self.userID,self.passWord, nil];
    
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
#pragma mark

- (void)loginSuccessWithMessage:(NSString *)message
{
    
   
    
    [UIComponentService showSuccessHudWithStatus:@"欢迎登陆钱海钱包"];
    NSString *psw=[LLLockPassword loadLockPassword];
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    NSString * phoneNumber = [ud objectForKey:@"phoneNumber"];
    NSString * password=[ud objectForKey:@"password"];

   
    if([User shareUser].loginNum==0)
    {
        if ([User shareUser].verificationStatus==0) {
        [self performSegueWithIdentifier:@"setPayPasswordSegue" sender:self];
        }else
        {
               [self performSegueWithIdentifier:@"loginSegue" sender:self];
        }
    }
    else{
        if ([self.identifying isEqualToString:@"1"]) {
            if (psw && [phoneNumber isEqualToString:self.userID.text] &&[password isEqualToString:self.passWord.text]) {
                
                [self performSegueWithIdentifier:@"loginSegue" sender:self];
            }else{
                
                [self savePhoneNumber:nil andPassword:nil];
                
                [self savePhoneNumber:self.userID.text andPassword:self.passWord.text];
                
                lockViewtype=LLLockViewTypeCreate;
                [self performSegueWithIdentifier:@"toGestureSegue" sender:self];
            
           
            }
        }else{
            
            
            if (psw && [phoneNumber isEqualToString:self.userID.text] &&[password isEqualToString:self.passWord.text]) {
                
                //lockViewtype=LLLockViewTypeCheck;
                [self performSegueWithIdentifier:@"loginSegue" sender:self];
            }else
            {
                [self savePhoneNumber:nil andPassword:nil];
                [self savePhoneNumber:self.userID.text andPassword:self.passWord.text];
                [LLLockPassword saveLockPassword:nil];
                lockViewtype=LLLockViewTypeCreate;
                [self performSegueWithIdentifier:@"toGestureSegue" sender:self];
            }
        }
    
        
    }
    
    if (![self.identifying isEqualToString:@"1"]) {     //不是从点击账户登录后进入的
        [self savePhoneNumber:self.userID.text andPassword:self.passWord.text];
    }
}


- (void)loginFildWithMessage: (NSString *)message
{
    if (_loginDO.error) {
        //[ showWarmingWithMessage:@"网络请求失败"];
        [UIComponentService showFailHudWithStatus:@"网络请求失败"];
        return;
    }
    else
    {
        [UIComponentService showFailHudWithStatus:message];
   }
}


- (IBAction)loginAction:(id)sender {
    
    BOOL isPhoneNumber = [BaseModel isValidPhone:self.userID.text];
    if (!isPhoneNumber) {
        [self showWarmingWithMessage:@"手机号有误"];
        return;
    }
    if (self.passWord.text.length == kTextLengthZero) {
        [self showWarmingWithMessage:@"密码有误"];
        return;
    }
    
    [UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(loginRequest) withObject:nil afterDelay:kDelayTime];
    
}

- (void)loginRequest
{
    _loginDO = [[LoginDO alloc] init];
    _loginDO.delegate = self;
    _loginDO.userNamePhoneNumber = self.userID.text;
    _loginDO.passWord            = self.passWord.text;
    
    _loginDO.trancode            = kTrancode_Login ;
    _loginDO.termno              = kNil;
    _loginDO.SIMNumber           = kSIMNumber ;
    _loginDO.appType             = kAppType ;
    [_loginDO loginRequest];
}


-(void) savePhoneNumber:(NSString *) phoneNumber andPassword:(NSString *)passwrod
{
    
    [[NSUserDefaults standardUserDefaults] setObject:phoneNumber forKey:@"phoneNumber"];
    [[NSUserDefaults standardUserDefaults] setObject:passwrod forKey:@"password"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.passWord == textField)
    {
        if ([toBeString length] > 15) {
            textField.text = [toBeString substringToIndex:15];
            return NO;
        }
    }
    if (self.userID == textField)
    {
        if ([toBeString length] > 11) {
            textField.text = [toBeString substringToIndex:11];
            return NO;
        }
    }
    
    return YES;
}



@end
