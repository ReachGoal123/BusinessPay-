//
//  MyAccountViewController.m
//  BusinessPay
//
//  Created by SHANGYITONG on 14-12-19.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "MyAccountViewController.h"
#import "LoginDO.h"
#import "MerchantInfo.h"
#import "AccountDetailViewController.h"
#import "ChangePayPasswordViewController.h"
#import "TranferAccountViewController.h"
#import "OrderPayViewController.h"
#import "WithDrawViewController.h"


@interface MyAccountViewController ()


@property(nonatomic,weak) IBOutlet UILabel *totalMoneyLabel;
@property(nonatomic,weak) IBOutlet UILabel *incomeLabel;

@property(nonatomic,weak) IBOutlet UIView *firstView;
@property(nonatomic,weak) IBOutlet UIView *secondView;

-(IBAction)pushToOrderPay:(id)sender;
-(IBAction)pushToWithDraw:(id)sender;
-(IBAction)pushToTranfer:(id)sender;



@end

@implementation MyAccountViewController

- (IBAction)clickon:(id)sender {
    
    [self performSegueWithIdentifier:@"accountDetailsegue" sender:sender];
}









-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"accountDetailsegue"])
    {
        AccountDetailViewController *_accountDetailVC=(AccountDetailViewController *)segue.destinationViewController;
        
        _accountDetailVC.accountDO=self.accountDO;
        
    }

    if ([segue.identifier isEqualToString:@"pushToWithDrawSegue"]) {
        WithDrawViewController *withDrawVC=(WithDrawViewController *)segue.destinationViewController;
        withDrawVC.accountDO=self.accountDO;
    }
    if ([segue.identifier isEqualToString:@"pushToTranferSegue"]) {
        TranferAccountViewController *tranferVC=(TranferAccountViewController *)segue.destinationViewController;
        tranferVC.accountDO=self.accountDO;
    
    }

}


- (void)viewDidLoad {
    [super viewDidLoad];
    [UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(accountRequest) withObject:nil afterDelay:kDelayTime];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleNew.png"] forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"titleNew.png"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:225/255.f green:225/255.f blue:225/255.f alpha:1]];
    
    //[self.firstView setTintColor:[UIColor colorWithRed:47/255.f green:120/255.f blue:175/255.f alpha:1]];
    [self.firstView setBackgroundColor:[UIColor colorWithRed:47/255.f green:120/255.f blue:175/255.f alpha:1]];
    

    UITapGestureRecognizer *ges=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToDetailVC:)];
    ges.numberOfTapsRequired=1;
    ges.numberOfTouchesRequired=1;
    [self.secondView addGestureRecognizer:ges];

    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"钱  包"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
 
    
    
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

-(void)pushToOrderPay:(id)sender
{
   
    [self performSegueWithIdentifier:@"pushToOrderPaySegue" sender:self];
}

-(void)pushToTranfer:(id)sender
{
   
    if ([User shareUser].status==0) {
         [self performSegueWithIdentifier:@"pushToTranferSegue" sender:self];
    }else if ([User shareUser].status==1)
    {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您的资料正在审核中，请待审核通过后再试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        
    }else if ([User shareUser].status==2)
    {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"为了您账户安全！请补全资料进行实名认证再进行操作" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        
    }else if ([User shareUser].status==4)
    {
        [UIComponentService showMessageAlertView:@"提示" message:@"变更手机号码申请正在审核中，请稍后再试"];
    }else if ([User shareUser].status==3)
    {
        [UIComponentService showMessageAlertView:@"提示" message:@"变更银行卡申请正在审核中，请稍后再试"];
    }
    
}

-(void)pushToWithDraw:(id)sender
{
     if ([User shareUser].status==0) {
         [self performSegueWithIdentifier:@"pushToWithDrawSegue" sender:self];
     }else if ([User shareUser].status==1)
     {
         UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您的资料正在审核中，请待审核通过后再试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
         [alertView show];
         
     }else if ([User shareUser].status==2)
     {
         UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"为了您账户安全！请补全资料进行实名认证再进行操作" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
         [alertView show];
         
     }else if ([User shareUser].status==4)
     {
         [UIComponentService showMessageAlertView:@"提示" message:@"变更手机号码申请正在审核中，请稍后再试"];
     }else if ([User shareUser].status==3)
     {
         [UIComponentService showMessageAlertView:@"提示" message:@"变更银行卡申请正在审核中，请稍后再试"];
     }

}

-(void) pushToDetailVC:(id)sender
{
    [self performSegueWithIdentifier:@"accountDetailsegue" sender:self];
}


#pragma mark - accountDelegate


-(void)accountResponseSuccessWithMessage:(NSString *)message withAccount:(AccountDO *)accountDO
{
    [UIComponentService showSuccessHudWithStatus:message];
    
    float money=[accountDO.totalAccount integerValue]/100.0f;
    self.totalMoneyLabel.text=[NSString stringWithFormat:@"%.2f",money];
    
    float money1=[accountDO.accumulatedIncome integerValue]/100.f;
    self.incomeLabel.text=[NSString stringWithFormat:@"%.2f",money1];
    
    self.accountDO=accountDO;
    
}

-(void)accountFieldWithMessage:(NSString *)message
{
    if ([_accountDO.responseCode isEqualToString:@"02042"]) {
        [UIComponentService showFailHudWithStatus:nil];
        self.totalMoneyLabel.text=@"0.0";
        self.incomeLabel.text=@"0.0";
        
    }else{
        [UIComponentService showFailHudWithStatus:message];
    }
}



#pragma mark - UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self performSegueWithIdentifier:@"myAccountToRealNameSegue" sender:self];
}

@end
