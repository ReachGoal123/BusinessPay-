//
//  ManagementViewController.m
//  BusinessPay
//
//  Created by zm on 28/4/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "ManagementViewController.h"
#import "User.h"
#import "AgentManageTableViewController.h"

@interface ManagementViewController ()

@end

@implementation ManagementViewController


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"childSegue"]) {
        AgentManageTableViewController *AgentManage=(AgentManageTableViewController *)segue.destinationViewController;
        
        AgentManage.AgentTemArr=_temArr;
        AgentManage.child = self.childquery;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:249/255.f green:248/255.f blue:248/255.f alpha:1];
    
    //    self.view.background
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"代理管理"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    
    _nAgment.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;  //button 字体左对齐
    _nAgment.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    _agmentmanagement.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;  //button 字体左对齐
    _agmentmanagement.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    _activCode.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;  //button 字体左对齐
    _activCode.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    User *user = [User shareUser];
    
    NSLog(@"user.agentName;--%@",user.agentName);
    
    self.nameLabel.text = user.agentName;
//    self.userRankNobility.text = user.nocaragTeyp;
//    self.currentYield.text = user.currentYield;
//    self.totalRevenue.text = user.totalYield;
    self.hasActivaNum.text = user.numberHasUsed;
    
    if ([user.currentYield intValue] == 0) {
        self.currentYield.text = @"暂无收益";
    }else{
        self.currentYield.text = [NSString stringWithFormat:@"%.2f元",[user.currentYield floatValue]/100];
    }
    
    if ([user.totalYield intValue] == 0) {
        self.totalRevenue.text = @"暂无收益";
    }else{
        self.totalRevenue.text = [NSString stringWithFormat:@"%.2f元",[user.totalYield floatValue]/100];
    }

    
    NSLog(@"user.nocaragTeyp---%@",user.nocaragTeyp);
    
    if ([user.nocaragTeyp isEqualToString:@"普通"]) {
        self.userRankNobility.text = user.nocaragTeyp;
        self.userLevelLabel.text = @"LV0";
    }else if ([user.nocaragTeyp isEqualToString:@"男爵"]) {
        self.userRankNobility.text = user.nocaragTeyp;
        self.userLevelLabel.text = @"LV1";
    }else if ([user.nocaragTeyp isEqualToString:@"伯爵"]) {
        self.userRankNobility.text = user.nocaragTeyp;
        self.userLevelLabel.text = @"LV2";
    }else if ([user.nocaragTeyp isEqualToString:@"公爵"]) {
        self.userRankNobility.text = user.nocaragTeyp;
        self.userLevelLabel.text = @"LV3";
    }



    
    
}


-(IBAction)nAmentAction:(id)sender{
    
    
    
}


//点击代理商管理
-(IBAction)managementAction:(id)sender{
    
    User *user = [User shareUser];
    
    NSLog(@"user.agentNumber----%@",user.agentNumber);
    childAgentQuery *childquery = [[childAgentQuery alloc]init];
    childquery.delegate = self;
    
    childquery.trancode = @"701192";
    childquery.LoginPhoneNum = user.phoneNumber;
    childquery.currentAgentNumber = user.agentNumber;
    [childquery childAgentQueryRequest];
    
    
}


- (void)childAgentQuerySuccessWithMessage:(NSString *)message andArr:(NSMutableArray *)arr{
    
    NSLog(@"arr----%@",arr);
    
    [UIComponentService showSuccessHudWithStatus:message];
    _temArr=arr;
    //    [self performSegueWithIdentifier:@"childSegue" sender:self];
}

- (void)childAgentQueryFildWithMessage: (NSString *)message{
    [UIComponentService showFailHudWithStatus:message];
    
}


//点击激活码管理
-(IBAction)activCodeAction:(id)sender{
    
    User *user = [User shareUser];
    ActivationCodeManagement *activatcode = [[ActivationCodeManagement alloc]init];
    activatcode.delegate = self;
    
    activatcode.trancode = @"701194";
    activatcode.LoginPhoneNum = user.phoneNumber;
    activatcode.currentAgentNumber = user.agentNumber;
    [activatcode ActivationCodeManagementRequest];
    
}

- (void)ActivationCodeSuccessWithMessage: (NSString *)message{
    [UIComponentService showSuccessHudWithStatus:message];
    [self performSegueWithIdentifier:@"codeactiavSegue" sender:self];
    
}

- (void)ActivationCodeFildWithMessage: (NSString *)message{
    
    [UIComponentService showFailHudWithStatus:message];
}


-(void)viewWillAppear:(BOOL)animated{



}


@end
