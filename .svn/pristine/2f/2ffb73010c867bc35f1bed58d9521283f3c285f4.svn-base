//
//  RechangeViewController.m
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-18.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "RechangeViewController.h"
#import "ReChangeStatusViewController.h"
#import "DataBase+PhoneProvider.h"
#import "PhoneNumberInfo.h"
//#import "PhoneNumberManager.h"


@implementation RechangeViewController


-(void) initAYHCustomComboBox
{
    
    isVisibleSex=NO;
    isVisibleNation=YES;
    
    
    ////通过消息通知来获得数据的改变
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectComboBoxTitleWithSex) name:@"AYHComboBoxSexChanged" object:nil];
    
    items= [[[DataBase alloc] init] getAllPhoneNumber];
    
    
    _ccbSex = [[AYHCustomComboBox alloc] initWithFrame:CGRectMake(8, 43, self.phoneNumberTextFeild.frame.size.width, 112) DataCount:(int)items.count NotificationName:@"AYHComboBoxSexChanged"];
    [_ccbSex setTag:200];
    [_ccbSex setDelegate:self];
    
    [_ccbSex addItemsData:items];
    
   
    //[items release];
    [_ccbSex flushData];
    
    
    
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    

    phoneInfo=[[PhoneNumberInfo alloc] init];
    
    phoneInfo.phoneNumber=[User shareUser].phoneNumber;
    phoneNumberManager=[[PhoneNumberManager alloc] init];
    //NSError *error;
    //[phoneNumberManager addContact:phoneInfo error:&error];
    
    
    //[UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(accountRequest) withObject:nil afterDelay:kDelayTime];
    
    //[self initAYHCustomComboBox];
    
    self.phoneNumberTextFeild.text=[User shareUser].phoneNumber;
    
    [self judgePhoneNUmber];
    
    _payPhonemoneyDO=[self.temArr objectAtIndex:0];
    
    float money = [ _payPhonemoneyDO.proParValue floatValue]/100.f;
    self.mayLabel.text=[NSString stringWithFormat:@"%.f元",money];
    
    //float money1= [payPhonemoneyDO.]
    self.actualLabel.text=[NSString stringWithFormat:@"售价:%@ >",_payPhonemoneyDO.proName];
    
    //self.moneyTextFeild.userInteractionEnabled=NO;
    [self setKeyBoard];
    
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"手机充值"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleNew.png"] forBarMetrics:UIBarMetricsDefault];

    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"reChangeStatusSegue"]) {
        
        ReChangeStatusViewController *reChangeVC=(ReChangeStatusViewController *)segue.destinationViewController;
        reChangeVC.status=self.status;
    }
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








- (void)setKeyBoard
{
    NSArray *tfArr = [NSArray arrayWithObjects:_phoneNumberTextFeild,_moneyTextFeild,nil];
    
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


#pragma  mark - accountDelegate

-(void)accountResponseSuccessWithMessage:(NSString *)message withAccount:(AccountDO *)accountDO
{
    //[UIComponentService showSuccessHudWithStatus:message];
    
    float money=[accountDO.avidAccount integerValue]/100.0f;
    self.accountLabel.text=[NSString stringWithFormat:@"可用余额：%.2f",money];
    self.accountDO=accountDO;
    

    
}

-(void)accountFieldWithMessage:(NSString *)message{
    if ([_accountDO.responseCode isEqualToString:@"02042"]) {
        [UIComponentService showFailHudWithStatus:nil];
        self.accountLabel.text=[NSString stringWithFormat:@"可用余额：0.0元"];
        
    }else{
        [UIComponentService showFailHudWithStatus:message];
    }


}

-(void)judgePhoneNUmber
{
    self.mobileArr=[NSArray arrayWithObjects:@"134",@"135",@"136",@"137",@"138",@"139",@"147",@"150",@"151",@"152",@"157",@"158",@"159",@"182",@"183",@"184",@"187",@"188",nil];   //移动号码的前三位
    self.telecomArr=[NSArray arrayWithObjects:@"133",@"153",@"180",@"181",@"189",@"170",@"177", nil];  //电信号码的前三位
    self.unicomArr=[NSArray arrayWithObjects:@"130",@"131",@"132",@"155",@"156",@"185",@"186",@"145",@"176", nil];// 联通号码的前三位

    NSString *BPNO=[self.phoneNumberTextFeild.text substringToIndex:3];
    for(int i=0;i<self.mobileArr.count;i++)
    {
        if ([BPNO isEqualToString:self.mobileArr[i]]) {
            self.operatorsLabel.text =@"中国移动";
        }
        
    }
    for (int i=0; i<self.telecomArr.count; i++) {
        if ([BPNO isEqualToString:self.telecomArr[i]]) {
            self.operatorsLabel.text= @"中国电信";
        }
    }
    for (int i=0; i<self.unicomArr.count; i++) {
        if ([BPNO isEqualToString:self.unicomArr[i]]) {
            self.operatorsLabel.text=@"中国联通";
        }
    }
    

    
    
}


#pragma mark - UITextFeild

//-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    
////    for (int i=0; i<self.temArr.count; i++) {
////        
////    }
//    if (textField.tag==102 ) {
//        
//   
//           }
//    
//}

-(void)selectMoneyAction:(id)sender
{
//    for (int i=0; i<self.temArr.count; i++) {
//        _payPhonemoneyDO=[self.temArr objectAtIndex:i];
//    }
    
    
    _moneyAlert=[[UIAlertView alloc] initWithTitle:@"请输入充值面额" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"20元",@"30元",@"50元",@"100元", nil];
    [_moneyAlert show];

    
}



-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    BOOL isPhoneNumber =[BaseModel isValidPhone:self.phoneNumberTextFeild.text];
    if (textField.tag==101) {
        if(!isPhoneNumber)
        {
            [self showWarmingWithMessage:@"请输入正确的手机号"];
            [self.operatorsLabel setAlpha:0.0f];
            return;
        }
    }
    
    if (textField.tag==101 && ![self.phoneNumberTextFeild.text isEqualToString:@""]) {
        [self judgePhoneNUmber];
        [self.operatorsLabel setAlpha:1.0f];
    }else
    {
        [self.operatorsLabel setAlpha:0.0f];
    }
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
//    if (isVisibleSex==NO)
//    {
//        [self.view addSubview:_ccbSex];
//        isVisibleSex = YES;
//    }
}


#pragma mark - AYHCustomComboBoxDelegate

- (void) CustomComboBoxChanged:(id) sender SelectedItem:(NSString *)selectedItem
{
    self.phoneNumberTextFeild.text=selectedItem;
    [_ccbSex removeFromSuperview];
    isVisibleSex = NO;
}
-(void)selectBookAction:(id)sender
{
    if (!picker) {
        picker=[[ABPeoplePickerNavigationController alloc] init ];
        picker.peoplePickerDelegate=self;
    }
    
    [self presentViewController:picker animated:YES completion:nil];

}

-(void)reChangeAction:(id)sender
{
    if ([self.phoneNumberTextFeild.text isEqualToString:@""])
    {
        [self showWarmingWithMessage:@"请输入手机号"];
        return;
    }
     float money=[self.accountDO.avidAccount integerValue]/100.f;
    
//    if ([_payPhonemoneyDO.proName floatValue]>money) {
//        
//        
//        [self showWarmingWithMessage:@"超出可用金额"];
//        return;
//    }
    _alert=[[UIAlertView alloc] initWithTitle:@"手机充值" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
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
    if (alertView==_alert) {
        if (buttonIndex==1) {
            
        NSString *payPassword=[alertView textFieldAtIndex:0].text;
        //[UIComponentService showHudWithStatus:kPleaseWait];
        [self performSelector:@selector(rechangeRequesWithPassword:) withObject:payPassword afterDelay:kDelayTime];
   
        }

    }
    if(alertView==_moneyAlert)
    {
        switch (buttonIndex) {
            case 0:
                self.mayLabel.text=@"20元";
                break;
            case 1:
                self.mayLabel.text=@"30元";
                break;
            case 2:
                self.mayLabel.text=@"50元";
                break;
            case 3:
                self.mayLabel.text=@"100";
                break;
            default:
                break;
        }
    }
    
    if ([self.mayLabel.text isEqualToString:@"20元"]) {
        _payPhonemoneyDO=[self.temArr objectAtIndex:0];
    
    }else if ([self.mayLabel.text isEqualToString:@"30元"])
    {
        _payPhonemoneyDO=[self.temArr objectAtIndex:1];
    }else if ([self.mayLabel.text isEqualToString:@"50元"])
    {
        _payPhonemoneyDO=[self.temArr objectAtIndex:2];
    }else 
    {
        _payPhonemoneyDO=[self.temArr objectAtIndex:3];
    }
    float money=[_payPhonemoneyDO.proAmt floatValue]/100.f;
    self.actualLabel.text=[NSString stringWithFormat:@"售价:%.2f元 >",money];
}



-(void) rechangeRequesWithPassword:(NSString *)payPassword
{
    _rechargePhoneDO=[[RechargePhoneDO alloc] init];
    _rechargePhoneDO.delegate=self;
    _rechargePhoneDO.trancode=kTrancode_Rechange;
   // if(self.)
    
    _rechargePhoneDO.merchantNum=[User shareUser].merchantNum;
    _rechargePhoneDO.proID=_payPhonemoneyDO.proID;
    _rechargePhoneDO.proType=_payPhonemoneyDO.proType;
    _rechargePhoneDO.oppositePhoneNumber=self.phoneNumberTextFeild.text;
    if ([self.operatorsLabel.text isEqualToString:@"中国移动"]) {
        _rechargePhoneDO.reQoperators=@"10";
    }else if([self.operatorsLabel.text isEqualToString:@"中国电信"])
    {
        _rechargePhoneDO.reQoperators=@"30";
    }else
    {
        _rechargePhoneDO.reQoperators=@"20";
    }
    
    _rechargePhoneDO.payPassword=payPassword;
    
    [_rechargePhoneDO rechangePhoneRequest];
    
    
}


#pragma  mark - ABdelegate
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    if (property==kABPersonPhoneProperty) {
        ABMutableMultiValueRef phoneMulti=ABRecordCopyValue(person, property);
        int index=ABMultiValueGetIndexForIdentifier(phoneMulti,identifier);
        NSString *phone=(__bridge NSString*)ABMultiValueCopyValueAtIndex(phoneMulti, index);
        
        NSString *phoneNew;
        
        if([phone rangeOfString:@"+"].location!=NSNotFound)
        {
            phoneNew=[phone substringWithRange:NSMakeRange(0, 3)];
            phoneNew=[phoneNew stringByReplacingOccurrencesOfString:@"-" withString:@""];
        }else
        {
            phoneNew=[phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
        }
    
        self.phoneNumberTextFeild.text=phoneNew;
        [self judgePhoneNUmber];
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
        }
        
        
        
        self.phoneNumberTextFeild.text=phoneNew;
        
        
        [self judgePhoneNUmber];
        
       // [self performSelector:@selector(merchantRequestWithPhoneNumber:) withObject:phoneNew afterDelay:0.0f];
        
        
        
        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    }
    
    
    return NO;
    
}

-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}



#pragma mark - reChangeDelegate

-(void)rechangePhoneSuccessWithMessage:(NSString *)message
{
    [UIComponentService showSuccessHudWithStatus:message];
    //[self.navigationController popToRootViewControllerAnimated:YES];
    self.status=0;
    [self performSegueWithIdentifier:@"reChangeStatusSegue" sender:self];
    
}



-(void)rechangePhoneFeildWithMessage:(NSString *)message
{
    if ([_rechargePhoneDO.responseCode isEqualToString:@"000088"]) {
        return;
    }else{
    [UIComponentService showFailHudWithStatus:message];
    }
    self.status=1;
    [self performSegueWithIdentifier:@"reChangeStatusSegue" sender:self];
}


//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    if(textField==self.moneyTextFeild)
//    {
//        return NO;
//    }
//    return YES;
//}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.phoneNumberTextFeild == textField)
    {
        if ([toBeString length] > 11) {
            textField.text = [toBeString substringToIndex:11];
            return NO;
        }
    }
    
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
