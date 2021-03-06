//
//  YiBaoNextViewController.m
//  BusinessPay
//
//  Created by SHANGYINTONG on 15/4/28.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "YiBaoNextViewController.h"
#import "OrderPayViewController.h"

@interface YiBaoNextViewController ()
{
    IBOutlet UIButton *l_timeButton; 
    
    NSInteger   selectedTextFieldTag;
}


@property (nonatomic,weak) IBOutlet UIView *myView;
@property (nonatomic,weak) IBOutlet UILabel *phoneNumberLabel;
@property (nonatomic,weak) IBOutlet UILabel *nameLabel;
@property (nonatomic,weak) IBOutlet UITextField *securityCodeTextFeild;

-(IBAction)getMessageAction:(id)sender;
-(IBAction)verifiAction:(id)sender;

@end

@implementation YiBaoNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"充  值"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    [self setKeyBoard];
    self.myView.backgroundColor=[UIColor colorWithWhite:0.95f alpha:1.0f];
    NSString *firstName;
    NSString *lastName;
    
    if(self.name.length==3)
    {
        firstName= [self.name substringToIndex:self.name.length-2];
        lastName= [self.name substringFromIndex:2];
        self.nameLabel.text   = [NSString stringWithFormat:@"%@*%@",firstName,lastName];
        
    }else if (self.name.length==4)
    {
        firstName=[self.name substringToIndex:self.name.length-3];
        lastName=[self.name substringFromIndex:3];
        self.nameLabel.text   = [NSString stringWithFormat:@"%@**%@",firstName,lastName];
    }else if (self.name.length==2)
    {
        firstName=[self.name substringToIndex:self.name.length-1];
        //merchantLastName=nil;
        self.nameLabel.text   = [NSString stringWithFormat:@"%@*",firstName];
    }
    
    NSString *phoneNumberFirst=[self.phoneNumber substringToIndex:3];
    NSString *phoneNumberLast=[self.phoneNumber substringFromIndex:self.phoneNumber.length-4];
    
    self.phoneNumberLabel.text  = [NSString stringWithFormat:@"%@****%@",phoneNumberFirst,phoneNumberLast];


    
}

- (void)setKeyBoard
{
    NSArray *tfArr = [NSArray arrayWithObjects:_securityCodeTextFeild,nil];
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)getMessageAction:(id)sender
{
//    [UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(getMessage) withObject:nil afterDelay:kDelayTime];
}

-(void) getMessage{
   
    __block int timeout=90; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [l_timeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
                l_timeButton.userInteractionEnabled = YES;
                
                YiBaoPayChannelDO *yibaoPaychannelDO=[[YiBaoPayChannelDO alloc] init];
                yibaoPaychannelDO.trancode=kTrancode_YibaoGetMessage;
                yibaoPaychannelDO.delegate=self;
                yibaoPaychannelDO.clslogNO=self.clsno;
                yibaoPaychannelDO.cardTel=self.phoneNumber;
                
                [yibaoPaychannelDO sendMessageRequest];
                
                
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 160;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
                [l_timeButton setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                l_timeButton.titleLabel.font = [UIFont systemFontOfSize:10];
                l_timeButton.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}


-(void)verifiAction:(id)sender
{
    [UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(verifiMessage) withObject:nil afterDelay:kDelayTime];
    
}


-(void) verifiMessage
{
    YiBaoPayChannelDO *yibaoPayChannelDO=[[YiBaoPayChannelDO alloc] init];
    yibaoPayChannelDO.trancode=kTrancode_YibaoVerMessage;
    yibaoPayChannelDO.delegate=self;
    yibaoPayChannelDO.clslogNO=self.clsno;
    yibaoPayChannelDO.vierifyCode=self.securityCodeTextFeild.text;
    
    
    [yibaoPayChannelDO vierifyMessageRequest];

}








#pragma mark  - yibaopay delegate



-(void)sendMessageRequestWithSuccess:(NSString *)message
{
    [UIComponentService showSuccessHudWithStatus:message];
}

-(void)sendMessageRequestWithFail:(NSString *)message
{
    [UIComponentService showFailHudWithStatus:message];
}


-(void)vierifyMessageRequestWithSuccess:(NSString *)message
{
    [UIComponentService showSuccessHudWithStatus:message];
    if ([User shareUser].reChangeStutas==1) {
        UIAlertView  *alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"为了您的账户安全，请先实名认证" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        
    }else{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

-(void)vierifyMessageRequestWithFail:(NSString *)message
{
    [UIComponentService showFailHudWithStatus:message];
    //OrderPayViewController *oderPayVC=[[OrderPayViewController alloc] init];
    
    //[self.navigationController popToViewController:oderPayVC animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [self performSegueWithIdentifier:@"pushToRealNameSegue" sender:self];
    
}

@end
