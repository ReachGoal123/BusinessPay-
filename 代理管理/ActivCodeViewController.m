//
//  ActivCodeViewController.m
//  BusinessPay
//
//  Created by zm on 29/4/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "ActivCodeViewController.h"
#import "User.h"
#import "CodeNotUserImformationQuery.h"
#import "AgentManageTableViewController.h"

@interface ActivCodeViewController ()



@end

@implementation ActivCodeViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"jihuomaTochildSegueg"]) {
        AgentManageTableViewController *AgentManage=(AgentManageTableViewController *)segue.destinationViewController;
        
        AgentManage.codehuaboNum = self.weiShengCheng.text;
        
        AgentManage.AgentTemArr = self.temArrchild;
        
        AgentManage.isfromjihuomaview = self.isfromjihuomahuabo;
    }
  
    if ([segue.identifier isEqualToString:@"shengchengcodeSegue"]) {
        CodeListTableViewController *codelist = (CodeListTableViewController*)segue.destinationViewController;
        codelist.codeArr = self.temArr;
        
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"代理商激活码管理"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    
    _createCode.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;  //button 字体左对齐
    _createCode.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    _transferCode.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;  //button 字体左对齐
    _transferCode.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    User *user = [User shareUser];
    
    self.yihuabo.text = user.yihuabo;
    self.yiJiHuoWeiShengC.text = user.yishengcheng;
    self.weiShengCheng.text = user.weishengcheng;
    
    UITapGestureRecognizer *tapImageLeftGes=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageLeft:)];
    
    tapImageLeftGes.numberOfTapsRequired=1;
    [_imageview setUserInteractionEnabled:YES];
    [_imageview addGestureRecognizer:tapImageLeftGes];
    
    
    _activityIndicator = [[UIActivityIndicatorView alloc]
                         initWithActivityIndicatorStyle:
                         UIActivityIndicatorViewStyleWhiteLarge];
    
    _activityIndicator.center =self.view.center;
    _activityIndicator.hidden =YES;
    [self.view addSubview:_activityIndicator];
    

}


//手势事件
-(void) tapImageLeft:(UITapGestureRecognizer *)gesture
{
 
    [_activityIndicator startAnimating];
//    [NSThread detachNewThreadSelector:@selector(PostStockData2:)
//                             toTarget:self withObject:nil];
    User *user = [User shareUser];
    CodeNotUserImformationQuery *codeqquer = [[CodeNotUserImformationQuery alloc]init];
    
    codeqquer.delegate = self;
    codeqquer.phongeNumberCode = user.phoneNumber;
    codeqquer.agentNumber = user.agentNumber;
    codeqquer.trancode = @"701198";
    [codeqquer CodeNotUserImformationQueryRequest];
    
}


//点击激活码生成按钮
-(IBAction)createCodeAction:(id)sender{
    
    
    _codeNumAlert = [[UIAlertView  alloc] initWithTitle:@"请选择生成激活码数量" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"1个", @"2个",@"3个",@"4个",@"5个", nil];
    [_codeNumAlert show];
    
}


//激活码生成
-(void)activationCodeGenerated{
    
    User *user = [User shareUser];
    CreateActivationCode *createactivat = [[CreateActivationCode alloc]init];
    createactivat.delegate = self;
    createactivat.trancode = @"701195";  //交易码
    createactivat.LoginPhoneNum = user.phoneNumber;  //代理商手机号
    createactivat.currentAgentNumber = user.agentNumber;  //代理商编号
    
    createactivat.codeNum = self.CodeNum;   //激活码数量
    createactivat.PayPassword = self.payPassWord;  //支付密码
    [createactivat CreateActivationCodeRequest];
    
}


- (void)testActionSheetDynamic {
    
    NSLog(@"testActionSheetDynamic======");
  
    _alert = [[UIAlertView alloc]initWithTitle:@"已生成激活码"
                         
                                                  message:nil
                         
                                                 delegate:self
                         
                                        cancelButtonTitle:nil
                         
                                        otherButtonTitles:nil];
    
        for (int i = 0; i < _creatCodeNumber.count; i++) {
    
            CreateActivationCode *createcode =  [_creatCodeNumber objectAtIndex:i];
    
            NSLog(@"createcode.creatCodeNum---%@",createcode.creatCodeNum);
            [_alert addButtonWithTitle:createcode.creatCodeNum];
        }
    
        _alert.cancelButtonIndex = _alert.numberOfButtons-1;
    
    [_alert show];
    
    UITapGestureRecognizer *recognizerTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(handleTapBehind:)];
    [recognizerTap setNumberOfTapsRequired:1];
    recognizerTap.cancelsTouchesInView = NO;
    [_alert.window addGestureRecognizer:recognizerTap];

    
}


//alertview显示时，点击屏幕灰色区域alertview消失
- (void)handleTapBehind:(UITapGestureRecognizer *)sender{
    if (sender.state == UIGestureRecognizerStateEnded){
        CGPoint location = [sender locationInView:nil];
        if (![_alert pointInside:[_alert convertPoint:location fromView:_alert.window] withEvent:nil]){
            [_alert.window removeGestureRecognizer:sender];
            [_alert dismissWithClickedButtonIndex:0
                                                 animated:YES];
        }
    }
}

//激活码生成成功调用的代理
- (void)CreateActivationCodeSuccessWithMessage: (NSString *)message andArr:(NSMutableArray*)codeArr{
    
    [UIComponentService showSuccessHudWithStatus:message];
    
    self.creatCodeNumber = codeArr;
    
    [self testActionSheetDynamic];
    
    
    User *user = [User shareUser];
    ActivationCodeManagement *activatcode = [[ActivationCodeManagement alloc]init];
    activatcode.delegate = self;
    
    activatcode.trancode = @"701194";
    activatcode.LoginPhoneNum = user.phoneNumber;
    activatcode.currentAgentNumber = user.agentNumber;
    [activatcode ActivationCodeManagementRequest];

    
}


- (void)ActivationCodeSuccessWithMessage: (NSString *)message{

    User *user = [User shareUser];
    
    self.yihuabo.text = user.yihuabo;
    self.yiJiHuoWeiShengC.text = user.yishengcheng;
    self.weiShengCheng.text = user.weishengcheng;
}


- (void)ActivationCodeFildWithMessage: (NSString *)message{

   [UIComponentService showFailHudWithStatus:message];
}

- (void)CreateActivationCodeFildWithMessage: (NSString *)message{
    
    [UIComponentService showFailHudWithStatus:message];
    
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView == self.codeNumAlert) {
        
        if (buttonIndex == 0) {
            
            NSLog(@"11111111111");
        
            return;
        }else{
        int num = (int)buttonIndex;
            NSLog(@"num---%d",num);
        
        _CodeNum= [ NSString stringWithFormat:@"%d",num ];
            
      
        
        self.payPassWordAlert =[[UIAlertView alloc] initWithTitle:@"请输入支付密码" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        _payPassWordField = [[UITextField alloc] init];
        _payPassWordField.backgroundColor = [UIColor whiteColor];
        _payPassWordField.frame = CGRectMake(self.payPassWordAlert.center.x+65,self.payPassWordAlert.center.y, 150,23);
        self.payPassWordAlert.alertViewStyle = UIAlertViewStyleSecureTextInput;//看这里。。可以这样用
        [self.payPassWordAlert textFieldAtIndex:0].placeholder=@"请输入支付密码";
        [self.payPassWordAlert textFieldAtIndex:0].keyboardType=UIKeyboardTypeNumberPad;
        [self.payPassWordAlert textFieldAtIndex:0].delegate = self;
        [self.payPassWordAlert addSubview:_payPassWordField];
        [self.payPassWordAlert show];
        }
            
        
    }else if(alertView == self.payPassWordAlert){
        
        if (buttonIndex==1) {
            NSString *payPassword=[alertView textFieldAtIndex:0].text;
            if ([payPassword isEqualToString:@""]) {
                [self showWarmingWithMessage:@"请输入支付密码"];
                return;
            }else{
                self.payPassWord = payPassword;
                [self activationCodeGenerated];
                
            }
            
            
        }else
        {
            return;
        }
        
    }else if(alertView == self.codeNumAlert2){
        
        if (buttonIndex==1){
            NSString *codeNum=[alertView textFieldAtIndex:0].text;
            if ([codeNum isEqualToString:@""]) {
                [self showWarmingWithMessage:@"请输入划拨的数量"];
                return;
            }else{
                
                self.CodeNumStr = codeNum;
                
                self.payPassWordAlert2 =[[UIAlertView alloc] initWithTitle:@"请输入支付密码" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
                _huoBoPayPassWord = [[UITextField alloc] init];
                _huoBoPayPassWord.backgroundColor = [UIColor whiteColor];
                _huoBoPayPassWord.frame = CGRectMake(self.payPassWordAlert2.center.x+65,self.payPassWordAlert2.center.y, 150,23);
                self.payPassWordAlert2.alertViewStyle = UIAlertViewStyleSecureTextInput;//看这里。。可以这样用
                [self.payPassWordAlert2 textFieldAtIndex:0].keyboardType = UIKeyboardTypeDefault;
                [self.payPassWordAlert2 textFieldAtIndex:0].placeholder=@"请输入支付密码";
                [self.payPassWordAlert2 textFieldAtIndex:0].keyboardType=UIKeyboardTypeNumberPad;
                [self.payPassWordAlert2 textFieldAtIndex:0].delegate = self;
                [self.payPassWordAlert2 addSubview:_huoBoPayPassWord];
                [self.payPassWordAlert2 show];
                
            }
        }
        
    }else if(alertView == self.payPassWordAlert2){
        
        if (buttonIndex==1) {
            NSString *paypassword=[alertView textFieldAtIndex:0].text;
            if ([paypassword isEqualToString:@""]) {
                [self showWarmingWithMessage:@"请输入支付密码"];
                return;
            }else{
                
                self.huaBoPayPassWord = paypassword;
                [self ActivationCodeTransfer];
            }
        }else
        {
            return;
        }
        
    }
    
    
}

//点击激活码划拨按钮
-(IBAction)transferCodeAction:(id)sender{
    
    User *user = [User shareUser];
    
    NSLog(@"user.agentNumber----%@",user.agentNumber);
    childAgentQuery *childquery = [[childAgentQuery alloc]init];
    childquery.delegate = self;
    
    childquery.trancode = @"701192";
    childquery.LoginPhoneNum = user.phoneNumber;
    childquery.currentAgentNumber = user.agentNumber;
    [childquery childAgentQueryRequest];
    
    _isfromjihuomahuabo = @"YES";
    
    [self performSegueWithIdentifier:@"jihuomaTochildSegueg" sender:self];
    
}

- (void)childAgentQuerySuccessWithMessage:(NSString *)message andArr:(NSMutableArray *)arr{
    
    NSLog(@"arr----%@",arr);
    
    [UIComponentService showSuccessHudWithStatus:message];
    _temArrchild=arr;

}

- (void)childAgentQueryFildWithMessage: (NSString *)message{
    [UIComponentService showFailHudWithStatus:message];
    
}


-(void)ActivationCodeTransfer{
    
    User *user = [User shareUser];
    ActivationCodeTransfer *activation = [[ActivationCodeTransfer alloc]init];
    activation .delegate = self;
    activation.trancode = @"701196";
    activation.huoBoNumber = self.CodeNumStr;
    activation.payPassWord = self.huaBoPayPassWord;
    activation.LoginPhoneNum = user.phoneNumber;
    activation.currentAgentNumber = user.agentNumber;
    [activation ActivationCodeTransferRequest];
    
}



//已生成为激活查询成功调用此代理

- (void)CodeNotUserImformationQuerySuccessWithMessage:(NSString *)message andArr:(NSMutableArray *)arr{
    
    _temArr=arr;
    
    [_activityIndicator stopAnimating];
    
    [self performSegueWithIdentifier:@"shengchengcodeSegue" sender:self];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"viewWillAppear");
     User *user = [User shareUser];
    self.yihuabo.text = user.yihuabo;
    self.yiJiHuoWeiShengC.text = user.yishengcheng;
    self.weiShengCheng.text = user.weishengcheng;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    
    if (([_payPassWordAlert2 textFieldAtIndex:0]  == textField)  || ([self.payPassWordAlert textFieldAtIndex:0]  == textField))
    {
        if ([toBeString length] > 6) {
            textField.text = [toBeString substringToIndex:6];
            return NO;
        }
    }

    if (_huoBoPayPassWord == textField) {
        
        NSLog(@"if (_huoBoPayPassWord == textField)");
        if ([toBeString length ]> 6) {
            textField.text = [toBeString substringToIndex:6];
            return NO;
        }
    }
    
    return YES;
}


@end
