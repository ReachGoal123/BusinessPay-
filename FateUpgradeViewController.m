//
//  FateUpgradeViewController.m
//  BusinessPay
//
//  Created by zm on 8/5/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "FateUpgradeViewController.h"

@interface FateUpgradeViewController ()

@end

@implementation FateUpgradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
        //        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您的资料正在审核中，请待审核通过后再试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        //        [alertView show];
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

@end
