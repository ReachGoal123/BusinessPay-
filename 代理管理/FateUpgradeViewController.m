//
//  FateUpgradeViewController.m
//  BusinessPay
//
//  Created by zm on 8/5/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "FateUpgradeViewController.h"
#import "FateListViewController.h"

@interface FateUpgradeViewController ()

@end

@implementation FateUpgradeViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        if ([segue.identifier isEqualToString:@"fateListSegue"]) {
            FateListViewController *fatelistViewController=(FateListViewController *)segue.destinationViewController;
            fatelistViewController.temArr=self.fateArr;
        }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.accountShengji.enabled = NO;
    UIBarButtonItem *backbtn = [[UIBarButtonItem alloc]init];
    backbtn.title = @"返回";
    self.navigationItem.backBarButtonItem = backbtn;
    
    
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"费率升级"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    
    float fate = [[User shareUser].nocCardFeeRete floatValue];
    
    self.currentFateLabel.text = [NSString stringWithFormat:@"%.2f%%",fate];
    
}

-(IBAction)selectorUpgradeButton:(id)sender{
    
    if ([User shareUser].status==0) {
        if ([[User shareUser].nocCardFeeRete isEqualToString:@"0.49"]) {
            [self showWarmingWithMessage:@"当前费率不可升级"];
            return;
        }
        [UIComponentService showHudWithStatus:kPleaseWait];
        [self performSelector:@selector(fateListRequest) withObject:nil afterDelay:kDelayTime];
        //[self performSegueWithIdentifier:@"pushToWithDrawSegue" sender:self];
    }else if ([User shareUser].status==1)
    {
        [UIComponentService showMessageAlertView:@"提示" message:@"您的资料正在审核中，请待审核通过后再试"];
        
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
    }else if([User shareUser].status==-1)
    {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您的资料审核未通过，请重新补全资料" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        
    }
    
}


-(void) fateListRequest
{
    _fateListDO=[[FateListDO alloc] init];
    _fateListDO.delegate=self;
    _fateListDO.trancode =kTrancode_FateList;
    
    _fateListDO.phoneNumber=[User shareUser].phoneNumber;
    
    [_fateListDO fateListInquaryRequest];
    
}

- (void)fateListInquarySuccessWithMessage:(NSString *)message andArr:(NSMutableArray*)arr
{
    self.fateArr = arr;
    [UIComponentService showSuccessHudWithStatus:message];
    [self performSegueWithIdentifier:@"fateListSegue" sender:self];
    
}

-(void)fateListInquaryFieldWithMessage:(NSString *)message
{
    [UIComponentService showFailHudWithStatus:message];
}

@end
