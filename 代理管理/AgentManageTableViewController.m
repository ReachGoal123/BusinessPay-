//
//  AgentManageTableViewController.m
//  BusinessPay
//
//  Created by zm on 29/4/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "AgentManageTableViewController.h"
#import "AgentCell.h"
#import "childAgentQuery.h"




@interface AgentManageTableViewController ()

@end

@implementation AgentManageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if ([_isfromjihuomaview isEqualToString:@"YES"]){
    
        self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
        UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
        [lable setText:@"下属代理商列表"];
        lable.font = [UIFont boldSystemFontOfSize:20];
        [lable setTextColor:[UIColor whiteColor]];
        [lable setTextAlignment:NSTextAlignmentCenter];

    }else{
    
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"下属代理商管理"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSLog(@"numberOfSectionsInTableView");
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@" self.temArr.count----%lu", (unsigned long)self.AgentTemArr.count);
    
    return [self.AgentTemArr count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    AgentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AgentCELL" forIndexPath:indexPath];
    AgentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AgentCELL"];
    
    _child=[self.AgentTemArr objectAtIndex:indexPath.row];
    NSLog(@"myCircleDO.childAgentName--%@",_child.childAgentName);
    NSLog(@"myCircleDO.costRate--%@",_child.costRate);
    NSLog(@"myCircleDO.pickGoodsNumber--%@",_child.pickGoodsNumber);
    
    cell.agentName.text=_child.childAgentName;
    cell.costFate.text=[NSString stringWithFormat:@"%@%%",_child.costRate ];
    cell.numbers.text=_child.pickGoodsNumber;
    cell.agentPhoneNum.text = _child.childPhoneNum;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//     _fateAlertArr = [[NSMutableArray alloc]init];
//    
//    _fateAlert = [[UIAlertView  alloc] initWithTitle:@"请选择费率" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    User *user = [User shareUser];
    NSString *minFate = user.minimumRate;
    int fate = [minFate floatValue]*100;
    NSLog(@"fate---%d",fate);
    int fateBetween = (49-fate);

    
    
    //int i = (int)indexPath.row;
    _child=[self.AgentTemArr objectAtIndex:indexPath.row];
    
    _childAgentNum = _child.childAgentNumber;
    
    
     NSLog(@"_childAgentNum----%@",_childAgentNum);
    
    if ([_isfromjihuomaview isEqualToString:@"YES"]) {
        _jihuomaNumView  = [[UIAlertView alloc] initWithTitle:@"请输入需要划拨的数量" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        _jihuomaNumfield = [[UITextField alloc] init];
        _jihuomaNumfield.backgroundColor = [UIColor whiteColor];
        _jihuomaNumfield.frame = CGRectMake(self.jihuomaNumView.center.x+65,self.jihuomaNumView.center.y, 150,23);
        self.jihuomaNumView.alertViewStyle = UIAlertViewStylePlainTextInput;//看这里。。可以这样用
        //[alert textFieldAtIndex:0].keyboardType = UIKeyboardTypeDefault;
        [self.jihuomaNumView textFieldAtIndex:0].placeholder=[NSString stringWithFormat:@"您当前最多可划拨%@个激活码",self.codehuaboNum];
        [self.jihuomaNumView textFieldAtIndex:0].keyboardType=UIKeyboardTypeNumberPad;
        [self.jihuomaNumView textFieldAtIndex:0].delegate = self;
        [self.jihuomaNumView addSubview:_jihuomaNumfield];
        [self.jihuomaNumView show];

        
        
    }else{
        if (fateBetween == 0) {
            float fatefloat = 0.49;
            [_fateAlertArr addObject:[NSString stringWithFormat:@"%.2f",fatefloat]];
            [_fateAlert addButtonWithTitle:[NSString stringWithFormat:@"%.2f", fatefloat]];
        }else{
            
            for (int i= 0; i <= fateBetween; i++) {
                int fateint = [minFate floatValue]*100;
                int newfateint =(fateint+i);
                float fatefloat = newfateint/100.0;
                
                [_fateAlertArr addObject:[NSString stringWithFormat:@"%.2f", fatefloat]];
                
                [_fateAlert addButtonWithTitle:[NSString stringWithFormat:@"%.2f", fatefloat]];
                
                NSLog(@"_fateAlertArr----%@",_fateAlertArr);
                
            }
        }
        [_fateAlert show];
        
        //添加手势
        UITapGestureRecognizer *recognizerTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(handleTapBehind1:)];
        [recognizerTap setNumberOfTapsRequired:1];
        recognizerTap.cancelsTouchesInView = NO;
        [_fateAlert.window addGestureRecognizer:recognizerTap];

    }
}


//alertview显示时，点击屏幕灰色区域alertview消失
- (void)handleTapBehind1:(UITapGestureRecognizer *)sender{
    
    NSLog(@"handleTapBehind1");
    if (sender.state == UIGestureRecognizerStateEnded){
        CGPoint location = [sender locationInView:nil];
        if (![_fateAlert pointInside:[_fateAlert convertPoint:location fromView:_fateAlert.window] withEvent:nil]){
            [_fateAlert.window removeGestureRecognizer:sender];
            [_fateAlert dismissWithClickedButtonIndex:0
                                                 animated:YES];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView == self.fateAlert) {
        int num =(int) buttonIndex;
         NSString *fatestrarr = [self.fateAlertArr objectAtIndex:num];
        
        NSLog(@"fatestr---%@",fatestrarr);
        
        _fateStr = [NSString stringWithFormat:@"%@",fatestrarr];
        
        
        
        NSLog(@"_fateStr----%@",_fateStr);
        
        _suerAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定修改此代理商的费率吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [_suerAlertView show];
        
    }else if (alertView == self.suerAlertView){
        if (buttonIndex==1) {
            
            [self fatechangeactiov];
            
            
        }else{
            return;
        }
    }else if (alertView == self.jihuomaNumView){
    
        if (buttonIndex==1) {
            
            NSLog(@"3333333333");
            
             NSString *jihuonum=[alertView textFieldAtIndex:0].text;
             if ([jihuonum isEqualToString:@""]) {
                [self showWarmingWithMessage:@"请输入划拨数量"];
                return;
             }else if([jihuonum intValue] > [self.codehuaboNum intValue]){
                [self.jihuomaNumView textFieldAtIndex:0].placeholder = @"您输入的激活码数量超限";
                 
                UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您输入的激活码数量超限,请重新输入!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
                 [alertview show];
             }
                 
             else{
                 _jihuomahuaboNum = jihuonum ;
                 
//                 [self setKeyBoard];
                 
                 _jihuomaPassWordView = [[UIAlertView alloc] initWithTitle:@"请输入支付密码" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
                 _jihuomaPassWordfield = [[UITextField alloc] init];
                 _jihuomaPassWordfield.backgroundColor = [UIColor whiteColor];
                 _jihuomaPassWordfield.frame = CGRectMake(self.jihuomaPassWordView.center.x+65,self.jihuomaPassWordView.center.y, 150,23);
                 self.jihuomaPassWordView.alertViewStyle = UIAlertViewStyleSecureTextInput;//看这里。。可以这样用
                 //[alert textFieldAtIndex:0].keyboardType = UIKeyboardTypeDefault;
                 [self.jihuomaPassWordView textFieldAtIndex:0].placeholder=@"请输入支付密码";
                 [self.jihuomaPassWordView textFieldAtIndex:0].keyboardType=UIKeyboardTypeNumberPad;
                 [self.jihuomaPassWordView textFieldAtIndex:0].delegate = self;
                 [self.jihuomaPassWordView addSubview:_jihuomaPassWordfield];
                 [self.jihuomaPassWordView show];
             }
      
        }else{
            return;
        }
    }else if (alertView == self.jihuomaPassWordView){
    
        if (buttonIndex==1) {
            NSString *payPassword=[alertView textFieldAtIndex:0].text;
            if ([payPassword isEqualToString:@""]) {
                [self showWarmingWithMessage:@"请输入支付密码"];
                return;
            }else{
                self.payPassWordStr = payPassword;
                [self jihuomahuaboaction];
          }
            
        }else
        {
            return;
        }
    }else if (alertView == self.jihuomachenggongView){  //激活码划拨成功后返回上一界面并查询数据
        
        
        
        if (buttonIndex==0) {
            
            NSLog(@"buttonIndex==0");
            
            User *user = [User shareUser];
            ActivationCodeManagement *activatcode = [[ActivationCodeManagement alloc]init];
            activatcode.delegate = self;
            
            activatcode.trancode = @"701194";
            activatcode.LoginPhoneNum = user.phoneNumber;
            activatcode.currentAgentNumber = user.agentNumber;
            [activatcode ActivationCodeManagementRequest];
        }
    }
}

//激活码划拨成功调用次代理
- (void)ActivationCodeSuccessWithMessage: (NSString *)message{
    
    [UIComponentService showSuccessHudWithStatus:@"激活码划拨成功!"];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)ActivationCodeFildWithMessage: (NSString *)message{
    
    [UIComponentService showFailHudWithStatus:message];
}



//激活码划拨
-(void)jihuomahuaboaction{

    User *user = [User shareUser];
    ActivationCodeTransfer *activation = [[ActivationCodeTransfer alloc]init];
    activation .delegate = self;
    activation.trancode = @"701196";
    activation.huoBoNumber = self.jihuomahuaboNum;
    activation.payPassWord = self.payPassWordStr;
    activation.LoginPhoneNum = user.phoneNumber;
    activation.targetAgentNum = self.childAgentNum;
    activation.currentAgentNumber = user.agentNumber;
    [activation ActivationCodeTransferRequest];

}



- (void)ActivationCodeTransferSuccessWithMessage: (NSString *)message{

    NSLog(@"ActivationCodeSuccessWithMessage");
    
    _jihuomachenggongView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
    [_jihuomachenggongView show];


}

- (void)ActivationCodeTransferFildWithMessage: (NSString *)message{

    [UIComponentService showFailHudWithStatus:message];
}



//激活码修改
-(void)fatechangeactiov{

    User *user = [User shareUser];
    FateChange *fatechange = [[FateChange alloc]init];
    fatechange.delegate = self;
    fatechange.phoneNumstr = user.phoneNumber;
    fatechange.trancode = @"701193";
    fatechange.childAgengNum = self.childAgentNum;
    fatechange.childFate = self.fateStr;
    [fatechange FateChangeRequest];
}

//费率码修改成功调用代理
- (void)FateChangeSuccessWithMessage:(NSString *)message{
    
    
    [UIComponentService showSuccessHudWithStatus:message];
    [self.navigationController popViewControllerAnimated:YES];

}

//激活码修改失败调用代理
- (void)FateChangeFildWithMessage:(NSString *)message{
    
   [UIComponentService showFailHudWithStatus:message];
    [self.navigationController popViewControllerAnimated:YES];

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    
    
    if ([self.jihuomaPassWordView textFieldAtIndex:0] == textField) {
        
        NSLog(@"self.jihuomaPassWordfield == textField");
        
        if ([toBeString length ]> 6) {
            textField.text = [toBeString substringToIndex:6];
            return NO;
        }
    }
    
    return YES;
}

- (void)setKeyBoard
{
    NSArray *tfArr = [NSArray arrayWithObjects:_jihuomaPassWordfield, nil];
    
    [IQKeyboardManager sharedManager];
    
    for (int i = 0; i < tfArr.count; i++) {
        UITextField *tf = (UITextField *)[tfArr objectAtIndex:i];
        tf.delegate = self;
        [tf addPreviousNextDoneOnKeyboardWithTarget:self
                                     previousAction:@selector(previousClicked:)
                                         nextAction:@selector(nextClicked:)
                                         doneAction:@selector(doneClicked:)];
        
        if (i == 0)
        {
            [tf setEnablePrevious:NO next:YES];
        }
        
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




@end
