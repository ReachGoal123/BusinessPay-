//
//  OrderPayViewController.m
//  BusinessPay
//
//  Created by Tears on 14-4-17.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "OrderPayViewController.h"
#import "OrderDetailViewController.h"
#import "OrderListTableViewController.h"
#import "AnotherPayViewController.h"
#import "OrderPayInquiryViewController.h"
#import "ChooseBankViewController.h"
#import "YiBaoChannelViewController.h"
#import "BindCardViewController.h"

//#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface OrderPayViewController ()
{
    
    NSInteger   selectedTextFieldTag;
}

@property (nonatomic,strong) UIView *myView;


@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (weak, nonatomic) IBOutlet UILabel *fateLabel;
@property (weak, nonatomic) IBOutlet UILabel *realMoney;

@property (weak, nonatomic) IBOutlet UITextField *orderTextField;
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;
@property (weak, nonatomic) IBOutlet UITextField *settlementMethodLab;
@property (assign, nonatomic) int selectIndex;
@property (copy, nonatomic) NSString * billingCycleStr;

- (IBAction)settlementMethod:(id)sender;
- (IBAction)submitOrderimmediatelyAction:(id)sender;
- (IBAction)orderListSubmit:(id)sender;

-(void) dismissAction:(id)sender;
-(void) payAction:(id)sender;

@property (nonatomic,strong) UIColor *color;

@property (nonatomic,strong) NSMutableArray *arr;


@end

@implementation OrderPayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setKeyBoard];
    
    [self.fateLabel setAlpha:0.0f];
    [self.realMoney setAlpha:0.0f];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleNew.png"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:225/255.f green:225/255.f blue:225/255.f alpha:1]];
    //[self performSelector:@selector(textFieldbecomeFirstResponder:) withObject:self.moneyTextField afterDelay:kDelayTime];
    
    self.color=self.view.backgroundColor;
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"充  值"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    
    if ([User shareUser].reChangeStutas==1) {
        self.navigationItem.rightBarButtonItem=nil;
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toChooseBankSegue"]) {
        ChooseBankViewController *chooseBankVC=(ChooseBankViewController *)segue.destinationViewController;
        
        chooseBankVC.money=self.moneyTextField.text;
    }
    
    if ([segue.identifier isEqualToString:@"pushToYibaoSugue"]) {
        YiBaoChannelViewController *yibaoChannelVC=(YiBaoChannelViewController *)segue.destinationViewController;
        yibaoChannelVC.money=self.moneyTextField.text;
    }
    if ([segue.identifier isEqualToString:@"pushToBindCardSegue"]) {
        BindCardViewController *bindCardVC=(BindCardViewController *)segue.destinationViewController;
        bindCardVC.arr=self.arr;
        bindCardVC.money=self.moneyTextField.text;
        
    }
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag==102&&( self.moneyTextField.text.length == kTextLengthZero || [self.moneyTextField.text isEqualToString:kZeroPointZero])) {
        [self showWarmingWithMessage:@"输入金额有误"];
        return;
    }
    
    if(textField.tag==102 &&[self.moneyTextField.text floatValue]>20000)
    {
        [UIComponentService showMessageAlertView:nil message:@"金额不能大于2万，请重新输入"];
        self.moneyTextField.text=nil;
        return;
    }
    //if(textField.tag==101)
    if(textField.tag==102 &&[self.moneyTextField.text floatValue]<2)
    {
        [UIComponentService showMessageAlertView:nil message:@"金额不能小于2元，请重新输入"];
        self.moneyTextField.text=nil;
        return;
    }
    if (textField.tag==102 && ![self.moneyTextField.text isEqualToString:nil]) {
        
        self.fateLabel.text=[NSString stringWithFormat:@"费率：%@%%",[User shareUser].nocCardFeeRete];
        self.realMoney.text=[NSString stringWithFormat:@"实际入账金额:%.2lf元",[self.moneyTextField.text floatValue]-[self.moneyTextField.text floatValue]*([[User shareUser].nocCardFeeRete floatValue]/100.f)];
        [self.fateLabel setAlpha:1.0f];
        [self.realMoney setAlpha:1.0f];
    }
    else
    {
        [self.fateLabel setAlpha:0.0f];
        [self.realMoney setAlpha:0.0f];
        
    }
    
}

- (void)setKeyBoard
{
    NSArray *tfArr = [NSArray arrayWithObjects:_moneyTextField, nil];
    
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


-(void)orderListSubmit:(id)sender
{
    [self performSegueWithIdentifier:@"orderInquirySegue" sender:self];
}


-(void)submitHaveCardAction:(id)sender
{
    [self showWarmingWithMessage:@"暂未开通!"];
}

-(void)submitOrderlatishAction:(id)sender
{
    if (self.moneyTextField.text.length == kTextLengthZero || [self.moneyTextField.text isEqualToString:kZeroPointZero]) {
        [self showWarmingWithMessage:@"输入金额有误"];
        return;
    }
    if ([self.settlementMethodLab.text isEqualToString:@"请选择结算方式"]) {
        [self showWarmingWithMessage:@"请选择结算方式"];
        return;
    }
    switch (self.selectIndex) {
        case 0:
            self.billingCycleStr = @"0";
            break;
        case 1:
            self.billingCycleStr = @"1";
            break;
        case 2:
            self.billingCycleStr = @"5";
            break;
        default:
            break;
    }
    
    [self.view endEditing:YES];
    [UIComponentService showHudWithStatus:kPleaseWait];
    //[self performSelector:@selector(orderRequest) withObject:nil afterDelay:kDelayTime];
    
    
    
}

- (BOOL)isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

- (IBAction)submitOrderimmediatelyAction:(id)sender {
    if (self.moneyTextField.text.length == kTextLengthZero || [self.moneyTextField.text isEqualToString:kZeroPointZero]) {
        [self showWarmingWithMessage:@"输入金额有误"];
        return;
    }
    if ([self.moneyTextField.text floatValue]<2) {
        [self showWarmingWithMessage:@"金额需大于2.00元，请重新输入"];
        NSLog(@"money=%i",(int)([self.moneyTextField.text floatValue]));
        self.moneyTextField.text=nil;
        return;
    }
    if([self.moneyTextField.text floatValue]>20000)
    {
        [UIComponentService showMessageAlertView:nil message:@"单笔金额需小于2万，请重新输入"];
        self.moneyTextField.text=nil;
        return;
    }
    if(![self isPureFloat:self.moneyTextField.text])
    {
        [UIComponentService showMessageAlertView:nil message:@"输入金额有误，请重新输入"];
        self.moneyTextField.text=nil;
        return;
    }
    
    if ([User shareUser].status==0) {
        [UIComponentService showHudWithStatus:kPleaseWait];
        [self performSelector:@selector(bindCardRequest) withObject:nil afterDelay:kDelayTime];

    }else{
    
    _myView=[[UIView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH/2, kSCREEN_HEIGHT/2, 2 , 2)];
    
    
    //[self.view setAlpha:0.5f];
    self.view.backgroundColor=[UIColor colorWithWhite:0.95f alpha:0.9f];
    
    UITextView *textView=[[UITextView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH, kSCREEN_HEIGHT/2, 0, 0)];
    
    textView.text=@"请使用本人信用卡，若误刷他人信用卡，需持卡人提供具有法律效力的相关文件，方可生效!";
    
    textView.font=[UIFont systemFontOfSize:18.0f];
    
    textView.editable=NO;
    
    textView.backgroundColor=[UIColor clearColor];
    
    textView.textColor=[UIColor whiteColor];
    
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH/2, 180, 2, 2)];
    label.text=@"如仍有疑问,";
    label.textColor=[UIColor whiteColor];
    
    label.font=[UIFont systemFontOfSize:15.0f];
    
    
    
    UILabel *labelXian=[[UILabel alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH/2, 220, 2, 2)];
    labelXian.text=@"请咨询客服电话：4008719668。";
    labelXian.textColor=[UIColor whiteColor];
    
    labelXian.font=[UIFont systemFontOfSize:15.0f];
    
    
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH/2, kSCREEN_HEIGHT/2, 0, 0)];
    
    imageView.image=[UIImage imageNamed:@"action.png"];
    
    [imageView setUserInteractionEnabled:YES];
    
    
    
    UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH/2, 180, 100, 40)];
    [button setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
    
    UIButton *button2=[[UIButton alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH/2, 180, 100, 40)];
    [button2 setTitle:@"取消" forState:UIControlStateNormal];
    
    [button2 setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [button2 addTarget:self action:@selector(dismissAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //    [button setTintColor:[UIColor blackColor]];
    //    [button2 setTintColor:[UIColor blackColor]];
    [button setTitleColor:[UIColor colorWithRed:11/225.f green:107/225.f blue:202/225.f alpha:1.0f] forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor colorWithRed:11/225.f green:107/225.f blue:202/225.f alpha:1.0f] forState:UIControlStateNormal];
    
    
    CGRect imageViewFrame=CGRectMake(10, 10, kSCREEN_WIDTH-40, kSCREEN_HEIGHT-100);
    
    
    CGRect  textViewFrame=CGRectMake(20, 130, kSCREEN_WIDTH-60, 130);
    CGRect  labelFrame= CGRectMake(20, textViewFrame.origin.y+textViewFrame.size
                                   .height+20, kSCREEN_WIDTH-60, 30);
    
    CGRect  labelXiaFrame=CGRectMake(20, labelFrame.origin.y+labelFrame.size.height-8, kSCREEN_WIDTH-60, 30);
    
    CGRect  leftButtonFrame= CGRectMake(20, labelXiaFrame.origin.y+labelXiaFrame.size.height, 100, 40);
    CGRect  rightButtonFrame= CGRectMake(imageViewFrame.size.width-120, labelXiaFrame.origin.y+labelXiaFrame.size.height, 100, 40);
    
    
    
    _myView.frame = CGRectMake(10, 10, kSCREEN_WIDTH-20, kSCREEN_HEIGHT-20);
    imageView.frame=imageViewFrame;
    textView.frame=textViewFrame;
    label.frame=labelFrame;
    labelXian.frame=labelXiaFrame;
    
    button.frame=leftButtonFrame;
    button2.frame=rightButtonFrame;
    
    [_myView addSubview:imageView];
    [self.view addSubview:_myView];
    [imageView addSubview:textView];
    [imageView addSubview:label];
    [imageView addSubview:labelXian];
    
    [imageView addSubview:button];
    [imageView addSubview:button2];
    }
}




-(void)dismissAction:(id)sender{
    [_myView removeFromSuperview];
    
}


-(void)payAction:(id)sender
{
    //[self.view endEditing:YES];
    [_myView removeFromSuperview];
    //[self performSegueWithIdentifier:@"toChooseBankSegue" sender:self];
   // [self performSegueWithIdentifier:@"pushToYibaoSugue" sender:self];
    [UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(bindCardRequest) withObject:nil afterDelay:kDelayTime];
    
    
}



-(void) bindCardRequest
{
    BindCardDO *bindCardDO=[[BindCardDO alloc] init];
    bindCardDO.trancode=kTrancode_BindCard;
    bindCardDO.delegate=self;
    bindCardDO.phoneNumber=[User shareUser].phoneNumber;
    
    
    [bindCardDO bindCardRequest];
    
}

#pragma mark  -bindCard deelegate

-(void)bindCardRequestSuccessWithMessage:(NSString *)message andBindCardDOArr:(NSMutableArray *)temArr
{
    [UIComponentService showSuccessHudWithStatus:message];
    
    self.arr=temArr;
    [self performSegueWithIdentifier:@"pushToBindCardSegue" sender:self];
    
    
}


-(void)bindCardRequestFeildWithMessage:(NSString *)message
{
    [UIComponentService showFailHudWithStatus:message];
    //[self performSegueWithIdentifier:@"pushToBindCardSegue" sender:self];
}

//-(void)orderCreateFailWithMessage:(NSString *)message
//{
//    
//    [UIComponentService showFailHudWithStatus:message];
//}



- (IBAction)settlementMethod:(id)sender {
    [self.view endEditing:YES];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"网购", @"贷款",@"其他", nil];
    
    //actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    
    [alertView show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.selectIndex = buttonIndex;
    switch (buttonIndex) {
        case 0:
            self.settlementMethodLab.text = @"网购";
            break;
        case 1:
            self.settlementMethodLab.text = @"贷款";
            break;
        case 2:
            self.settlementMethodLab.text = @"其他";
            break;
        default:
            break;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    
    if (self.moneyTextField.text.length == kTextLengthZero && [string isEqualToString:kZero]) {
        self.moneyTextField.text = kZeroPoint;
        return NO;
    }
    
    if ([self.moneyTextField.text hasSuffix:kZeroPointZero] && [string isEqualToString:kZero]) {
        self.moneyTextField.text = kZeroPointZero;
        return NO;
    }
    
    if ([self.moneyTextField.text isEqualToString:kZero]) {
        self.moneyTextField.text = string;
        return NO;
    }
    if ([string isEqualToString:@"\n"])
    {
        return YES;
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
    
    return YES;
}


@end
