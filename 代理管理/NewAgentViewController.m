//
//  NewAgentViewController.m
//  BusinessPay
//
//  Created by zm on 29/4/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "NewAgentViewController.h"
#import "UserUpgradeToAgent.h"

@interface NewAgentViewController ()

@end

@implementation NewAgentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.PhoneNum.keyboardType = UIKeyboardTypeNumberPad;
    
    User *user = [User shareUser];
    self.fateLabel.text =[NSString stringWithFormat:@"%@%%", user.minimumRate];
    
    
    
    [self setKeyBoard];
    
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"新建代理商"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    
}


- (void)setKeyBoard
{
    NSArray *tfArr = [NSArray arrayWithObjects:_PhoneNum, nil];
    
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


//输入完成后调用此方法验证号码
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    [self phoneNumberValidation];
    
}


//点击代理商费率修改费率
-(IBAction)fateNumChange:(id)sender{
    
    _fateAlertArr = [[NSMutableArray alloc]init];

    _fateAlertView = [[UIAlertView alloc] initWithTitle:@"修改费率" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    User *user = [User shareUser];
    NSString *minFate = user.minimumRate;
    int fate = [minFate floatValue]*100;
    NSLog(@"fate---%d",fate);
    int fateBetween = (49-fate);
    if (fateBetween == 0) {
        float fatefloat = 0.49;
        [_fateAlertArr addObject:[NSString stringWithFormat:@"%.2f",fatefloat]];
        [_fateAlertView addButtonWithTitle:[NSString stringWithFormat:@"%.2f",fatefloat]];
    }else{
    
        for (int i= 0; i <= fateBetween; i++) {
            int fateint = [minFate floatValue]*100;
            int newfateint =(fateint+i);
            float fatefloat = newfateint/100.0;
            
            [_fateAlertArr addObject:[NSString stringWithFormat:@"%.2f", fatefloat]];
            
            [_fateAlertView addButtonWithTitle:[NSString stringWithFormat:@"%.2f", fatefloat]];
            
        }
    
    }
    
    
    [_fateAlertView show];

    
    //添加手势
    UITapGestureRecognizer *recognizerTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                            action:@selector(handleTapBehind:)];
    [recognizerTap setNumberOfTapsRequired:1];
    recognizerTap.cancelsTouchesInView = NO;
    [_fateAlertView.window addGestureRecognizer:recognizerTap];
}


//alertview显示时，点击屏幕灰色区域alertview消失
- (void)handleTapBehind:(UITapGestureRecognizer *)sender{
    if (sender.state == UIGestureRecognizerStateEnded){
        CGPoint location = [sender locationInView:nil];
        if (![_fateAlertView pointInside:[_fateAlertView convertPoint:location fromView:_fateAlertView.window] withEvent:nil]){
            [_fateAlertView.window removeGestureRecognizer:sender];
            [_fateAlertView dismissWithClickedButtonIndex:0
                                        animated:YES];
        }
    }
}




-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
     User *user = [User shareUser];

    if (alertView == self.fateAlertView) {
//        if (buttonIndex == 1) {
//            return;
//        }else{
            int num =(int) buttonIndex;
            
            NSString *fatestr = [self.fateAlertArr objectAtIndex:num];
            
            self.fateLabel.text = [NSString stringWithFormat:@"%@%%",fatestr];
        
//        }
    }

}


//点击确定
-(IBAction)sureUpgradeAction:(id)sender{
    
    [self.PhoneNum resignFirstResponder];
    UserUpgradeToAgent *usertoagent = [[UserUpgradeToAgent alloc]init];
    usertoagent.delegate = self;
    usertoagent.trancode = @"701191";  //交易码
    
    NSString *fatestr = self.fateLabel.text;
    
//    NSLog(@"fatestr-----%@",fatestr);
    
    usertoagent.fateNum = fatestr;  //费率
    
    NSUserDefaults *us = [NSUserDefaults standardUserDefaults];
    NSString *lognumstr = [us objectForKey:@"phoneNumber"];  //得到电话号码
    usertoagent.LoginPhoneNum = lognumstr;
    
    usertoagent.toVerifiedNum = self.BeVerifiedNum;
    
    [usertoagent sureUpgradeRequest];
    
    
}

- (void)UserToAgentSuccessWithMessage: (NSString *)message{
    [UIComponentService showSuccessHudWithStatus:message];
    
}

- (void)UserToAgentFildWithMessage: (NSString *)message{
    [UIComponentService showFailHudWithStatus:message];
    
}



//点击号码选择
-(IBAction)telePhoneNumChange:(id)sender{
    
    if (!_picker) {
        _picker=[[ABPeoplePickerNavigationController alloc] init ];
        _picker.peoplePickerDelegate=self;
    }
    
    [self presentViewController:_picker animated:YES completion:nil];
    
}


#pragma  mark - ABdelegate


- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    if (property==kABPersonPhoneProperty) {
        ABMutableMultiValueRef phoneMulti=ABRecordCopyValue(person, property);
        int index=(int) ABMultiValueGetIndexForIdentifier(phoneMulti,identifier);
        NSString *phone=(__bridge NSString*)ABMultiValueCopyValueAtIndex(phoneMulti, index);
        
        if([phone rangeOfString:@"+"].location!=NSNotFound)
        {
            _BeVerifiedNum=[phone substringWithRange:NSMakeRange(0, 3)];
            _BeVerifiedNum=[_BeVerifiedNum stringByReplacingOccurrencesOfString:@"-" withString:@""];
        }else
        {
            _BeVerifiedNum=[phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
            //NSLog(@"phoneNew=%@",phoneNew);
        }
        
        
        
        self.PhoneNum.text=_BeVerifiedNum;
        
        //        [UIComponentService showHudWithStatus:ValidationPhoneNow];
        
        
        [self performSelector:@selector(phoneNumberValidation) withObject:nil afterDelay:0.0f];
        
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
        int index= (int)ABMultiValueGetIndexForIdentifier(phoneMulti,identifier);
        NSString *phone=(__bridge NSString*)ABMultiValueCopyValueAtIndex(phoneMulti, index);
        
        
        if([phone rangeOfString:@"+"].location!=NSNotFound)
        {
            _BeVerifiedNum=[phone substringWithRange:NSMakeRange(0, 3)];
            _BeVerifiedNum=[_BeVerifiedNum stringByReplacingOccurrencesOfString:@"-" withString:@""];
        }else
        {
            _BeVerifiedNum=[phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
            //NSLog(@"号码是：%@",phoneNew);
        }
        
        
        
        self.PhoneNum.text=_BeVerifiedNum;
        
        
        [self performSelector:@selector(phoneNumberValidation) withObject:nil afterDelay:0.0f];
        
        
        
        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    }
    
    
    return NO;
    
}

-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [_picker dismissViewControllerAnimated:YES completion:nil];
    
}





//手机号验证
- (void)phoneNumberValidation
{
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    
    NSString * currentPhoneNumber = [ud objectForKey:@"phoneNumber"];  //得到电话号码
    
    self.BeVerifiedNum = [_PhoneNum text];
    
    NSLog(@"currentPhoneNumber----%@",currentPhoneNumber);
    
    PhoneNumValidation * phoneValidation = [[PhoneNumValidation alloc] init];
    phoneValidation.delegate = self;
    
    NSLog(@"self.BeVerifiedNum---%@",self.BeVerifiedNum);
    
    phoneValidation.trancode = kTrancode_PhoneNumValidation;
    phoneValidation.VerifiedNum = self.BeVerifiedNum;
    phoneValidation.CurrentLoginPhoneNum = currentPhoneNumber;
    [phoneValidation phoneNumValidationRequest];
}

- (void)NumberValidationSuccessWithMessage: (NSString *)message{
    
    [UIComponentService showSuccessHudWithStatus:@"号码可以使用!"];
    
}



- (void)NumberValidationFildWithMessage: (NSString *)message
{
    if (_phonevalidation.error) {
        
        [UIComponentService showFailHudWithStatus:@"网络请求失败"];
        return;
    }
    else
    {
        [UIComponentService showFailHudWithStatus:message];
        self.PhoneNum.text = @"";
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
        if (self.PhoneNum == textField)
    {
        if ([toBeString length] > 11) {
            textField.text = [toBeString substringToIndex:11];
            return NO;
        }
    }
    
    return YES;
}



@end
