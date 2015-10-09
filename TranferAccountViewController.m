//
//  TranferAccountViewController.m
//  BusinessPay
//
//  Created by SHANGYITONG on 15-1-27.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "TranferAccountViewController.h"

@interface TranferAccountViewController ()
{
    ABPeoplePickerNavigationController *picker;
}

@end

@implementation TranferAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setKeyBoard];
    
    self.textView.editable=NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleNew.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    //[UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(accountRequest) withObject:nil afterDelay:kDelayTime];
    
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"转  账"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)selectAddressBook:(id)sender
{
    if (!picker) {
        picker=[[ABPeoplePickerNavigationController alloc] init ];
        picker.peoplePickerDelegate=self;
    }
    
    [self presentViewController:picker animated:YES completion:nil];
}



#pragma  mark - ABdelegate


- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    if (property==kABPersonPhoneProperty) {
        ABMutableMultiValueRef phoneMulti=ABRecordCopyValue(person, property);
        int index= ABMultiValueGetIndexForIdentifier(phoneMulti,identifier);
        NSString *phone=(__bridge NSString*)ABMultiValueCopyValueAtIndex(phoneMulti, index);
        
        NSString *phoneNew;
        
        if([phone rangeOfString:@"+"].location!=NSNotFound)
        {
            phoneNew=[phone substringWithRange:NSMakeRange(0, 3)];
            phoneNew=[phoneNew stringByReplacingOccurrencesOfString:@"-" withString:@""];
        }else
        {
            phoneNew=[phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
            //NSLog(@"phoneNew=%@",phoneNew);
        }
        
        
        
        self.oppositePhoneTextField.text=phoneNew;
        
        
        [self performSelector:@selector(merchantRequestWithPhoneNumber:) withObject:phoneNew afterDelay:0.0f];
        
        
        
        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    }

}


-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    return YES;
    
}

-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    if (property==kABPersonPhoneProperty) {
        ABMutableMultiValueRef phoneMulti=ABRecordCopyValue(person, property);
        int index= ABMultiValueGetIndexForIdentifier(phoneMulti,identifier);
        NSString *phone=(__bridge NSString*)ABMultiValueCopyValueAtIndex(phoneMulti, index);
        
        NSString *phoneNew;
        
        if([phone rangeOfString:@"+"].location!=NSNotFound)
        {
            phoneNew=[phone substringWithRange:NSMakeRange(0, 3)];
            phoneNew=[phoneNew stringByReplacingOccurrencesOfString:@"-" withString:@""];
        }else
        {
            phoneNew=[phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
            //NSLog(@"号码是：%@",phoneNew);
        }
        
        
        
        self.oppositePhoneTextField.text=phoneNew;
        
        
        [self performSelector:@selector(merchantRequestWithPhoneNumber:) withObject:phoneNew afterDelay:0.0f];
        
        
        
        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    }
    
    
    return NO;
    
}

-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


-(void) accountRequest
{
    _accountDO=[[AccountDO alloc] init];
    _accountDO.delegate=self;
    _accountDO.phoneNumber=[User shareUser].phoneNumber;
    _accountDO.trancode=kTrancode_AccountMessage;
    
    [_accountDO accountRequest];
    NSLog(@"account.card=%@",_accountDO.bindCard);
}

- (void)merchantRequestWithPhoneNumber:(NSString *)phoneNumber
{
    MerchantDO * merchantDO = [[MerchantDO alloc] init];
    merchantDO.delegate = self;
    merchantDO.termno = [User shareUser].termno;
    merchantDO.termType = kTermType;
    merchantDO.phoneNumber = phoneNumber;
    merchantDO.trancode = kTrancode_MerchantData;
    [merchantDO merchantInformationInquiryRequest];
}


#pragma mark - merchantDelegate

-(void)merchantInformationInquirySuccessWithMessage:(NSString *)message andMerchantDO:(MerchantDO *)merchantDO{
    
    self.nameTextField.text=merchantDO.merchantName;
    
    
}


-(void)merchantInformationInquiryFieldWithMessage:(NSString *)message
{
    [self showWarmingWithMessage:@"此账户不存在"];
    self.oppositePhoneTextField.text=nil;
    
}

#pragma mark - accountDelegate

-(void)accountResponseSuccessWithMessage:(NSString *)message withAccount:(AccountDO *)accountDO
{
    //[UIComponentService showSuccessHudWithStatus:message];
    float money=[accountDO.avidAccount integerValue]/100.f;
    self.totalAccountLabel.text=[NSString stringWithFormat:@"￥%.2f",money];
    self.accountDO=accountDO;
    
}

-(void)accountFieldWithMessage:(NSString *)message
{
    if ([_accountDO.responseCode isEqualToString:@"02042"]) {
        //[UIComponentService showFailHudWithStatus:nil];
        self.totalAccountLabel.text=@"￥0.0";
        //self.incomeLabel.text=@"￥0.0";
        
    }else{
        [UIComponentService showFailHudWithStatus:message];
    }

}

- (void)setKeyBoard
{
    NSArray *tfArr = [NSArray arrayWithObjects:_oppositePhoneTextField,_nameTextField,_moneyTextField,_payPasswordTextField, nil];
    
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


- (BOOL)isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}




- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    selectedTextFieldTag=textField.tag;
    BOOL isPhoneNumber =[BaseModel isValidPhone:self.oppositePhoneTextField.text];
    
    if (selectedTextFieldTag==101 && self.moneyTextField.text.length==kTextLengthZero) {
        [self showWarmingWithMessage:@"请输入收款金额！"];
        return;
    }
    
    //    if ([self isPureFloat:self.moneyTextField.text]) {
    //        [self showWarmingWithMessage:@"输入金额有误，请重新输入！"];
    //        self.moneyTextField.text=nil;
    //    }
    
    float money=[self.accountDO.avidAccount integerValue]/100.f;
    
    if(selectedTextFieldTag==101 && [self.moneyTextField.text floatValue]>money)
    {
        [self showWarmingWithMessage:@"超出可用金额"];
        return;
    }
    
    if (selectedTextFieldTag==101 && [self.moneyTextField.text floatValue]==kTextLengthZero) {
        [self showWarmingWithMessage:@"金额不能为0"];
        return;
    }
    if (selectedTextFieldTag==101 && [self.moneyTextField.text floatValue]>1000) {
        [self showWarmingWithMessage:@"单日转账金额不可超过1000元"];
        return;
    }
    if (selectedTextFieldTag==102) {
        
        if(!isPhoneNumber)
        {
            [self showWarmingWithMessage:@"请输入正确的手机号"];
            return;
        }else
        {
            [self merchantRequestWithPhoneNumber:self.oppositePhoneTextField.text];
        }
    }    if (selectedTextFieldTag==103 && self.moneyTextField.text.length==kTextLengthZero) {
        [self showWarmingWithMessage:@"请输入用户姓名！"];
        return;
    }
    //    if (selectedTextFieldTag==104&& self.payPasswordTextField.text.length==kTextLengthZero) {
    //        [self showWarmingWithMessage:@"请输入支付密码!"];
    //        return;
    //    }
}


-(void)tranferAction:(id)sender
{
   [self.oppositePhoneTextField resignFirstResponder];
      [self.nameTextField resignFirstResponder];
    if (self.moneyTextField.text.length==kTextLengthZero) {
        [self showWarmingWithMessage:@"请输入收款金额！"];
        return;
    }
    
    
    float money=[self.accountDO.avidAccount integerValue]/100.f;
    
    if([self.moneyTextField.text floatValue]>money)
    {
        [self showWarmingWithMessage:@"超出可转账金额"];
        return;
    }
    
    if ([self.moneyTextField.text floatValue]==kTextLengthZero) {
        [self showWarmingWithMessage:@"金额不能为0"];
        return;
    }
    
    if (self.oppositePhoneTextField.text.length==kTextLengthZero) {
        [self showWarmingWithMessage:@"请输入手机号码！"];
        return;
    }
    
    BOOL isPhoneNumber=[BaseModel isValidPhone:self.oppositePhoneTextField.text];
    if (!isPhoneNumber) {
        [self showWarmingWithMessage:@"手机号有误！"];
        return;
        
    }
        
    _alert=[[UIAlertView alloc] initWithTitle:@"转账" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    UITextField * txt = [[UITextField alloc] init];
    txt.backgroundColor = [UIColor whiteColor];
    txt.frame = CGRectMake(_alert.center.x+65,_alert.center.y, 150,23);
    _alert.alertViewStyle = UIAlertViewStyleSecureTextInput;//看这里。。可以这样用
    [_alert textFieldAtIndex:0].keyboardType = UIKeyboardTypeNumberPad;
    [_alert textFieldAtIndex:0].placeholder=@"请输入支付密码";
    [_alert textFieldAtIndex:0].delegate = self;
    [_alert addSubview:txt];
    [_alert show];
    
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        
        
        NSString *payPassword=[alertView textFieldAtIndex:0].text;
        //[UIComponentService showHudWithStatus:kPleaseWait];
        [self performSelector:@selector(tranferRequestWithPassword:) withObject:payPassword afterDelay:kDelayTime];
    }
}



-(void) tranferRequestWithPassword:(NSString *)password
{
    _transferAccountDO=[[TransferAccountDO alloc] init];
    
    _transferAccountDO.trancode=kTrancode_TranferAccount;
    _transferAccountDO.phoneNumber=[User shareUser].phoneNumber;
    _transferAccountDO.oppositePhone=self.oppositePhoneTextField.text;
    _transferAccountDO.type=@"02";
    _transferAccountDO.delegate=self;
    _transferAccountDO.money=[NSString stringWithFormat:@"%d", (int)([self.moneyTextField.text floatValue]*100.f)];
    //
    _transferAccountDO.name=self.nameTextField.text;
    _transferAccountDO.password=password;
    
    [_transferAccountDO TranferaccountRequest];
    
    
}




#pragma mark - TranferAccount delegate

-(void)TranferaccountResponseSuccessWithMessage:(NSString *)message
{
    [UIComponentService showSuccessHudWithStatus:@"转账成功！"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)TranferaccountFieldWithMessage:(NSString *)message
{
    if ([_transferAccountDO.responeCode isEqualToString:@"000088"]) {
        //[UIComponentService showFailHudWithStatus:nil];
        return;
    }
    
    [UIComponentService showFailHudWithStatus:message];
}


#pragma mark  - ABPeoplePickerNavigationControllerDelegate


//-(void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];

    
    
    if (self.oppositePhoneTextField==textField) {
        //[textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([toBeString length]>11) {
            textField.text=[toBeString substringToIndex:11];
            return NO;
        }
    }
    
    if (textField==self.moneyTextField) {
        
        
        if ([self.moneyTextField.text rangeOfString:@"."].location==NSNotFound) {
            isHaveDian=NO;
        }
        if ([string length]>0)
        {
            unichar single=[string characterAtIndex:0];//当前输入的字符
            if ((single >='0' && single<='9') || single=='.')//数据格式正确
            {
                //首字母不能为0和小数点
                if([self.moneyTextField.text length]==0){
                    if(single == '.'){
                        //[self showWarmingWithMessage:@"亲，第一个数字不能为小数点"];
                        [self.moneyTextField.text stringByReplacingCharactersInRange:range withString:@"0."];
                        return NO;
                    }
                }
                if (single=='.')
                {
                    if(!isHaveDian)//text中还没有小数点
                    {
                        isHaveDian=YES;
                        return YES;
                    }else
                    {
                        //[self alertView:@"亲，您已经输入过小数点了"];
                        [self showWarmingWithMessage:@"输入格式错误"];
                        [self.moneyTextField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                else
                {
                    if (isHaveDian==YES)//存在小数点
                    {
                        //判断小数点的位数
                        NSRange ran=[self.moneyTextField.text rangeOfString:@"."];
                        int tt=range.location-ran.location;
                        if (tt <= 2){
                            return YES;
                        }else{
                            //[self alertView:@"亲，您最多输入两位小数"];
                            return NO;
                        }
                    }
                    else
                    {
                        return YES;
                    }
                }
            }else{//输入的数据格式不正确
                [self showWarmingWithMessage:@"输入格式不正确"];
                [self.moneyTextField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }
        else
        {
            return YES;
        }
        
    }
   // NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([self.alert textFieldAtIndex:0]  == textField)
    {
        if ([toBeString length] > 6) {
            textField.text = [toBeString substringToIndex:6];
            return NO;
        }
    }
    return YES;
}




@end
