//
//  AccountManagementViewController.m
//  BusinessPay
//
//  Created by Tears on 14-4-21.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "AccountManagementViewController.h"
#import "BankCardInformationChangeViewController.h"
#import "LLLockViewController.h"

@interface AccountManagementViewController ()
{
    NSMutableArray * _dataSourceTitleArr;
    NSMutableArray * _dataSourceImageArr;
    LLLockViewType lockViewtype;
}


@property (nonatomic,strong) UIAlertView *phoneNumberChangeAlterView;
@property (nonatomic,strong) UIAlertView *bankCardChangeAlterView;
@property (nonatomic,strong) UIAlertView *myAlterView;
@property (nonatomic,strong) UIAlertView *clearAlertView;



@end

@implementation AccountManagementViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"bankInformationChangePassedSegue"]) {
        BankCardInformationChangeViewController * bankCardChange = (BankCardInformationChangeViewController *)segue.destinationViewController ;
        bankCardChange.changeType = BankCardChangeType_Application;
    }
    if ([segue.identifier isEqualToString:@"bankInformationChangeSegue"]) {
        BankCardInformationChangeViewController * bankCardChange = (BankCardInformationChangeViewController *)segue.destinationViewController ;
        bankCardChange.changeType = BankCardChangeType_Modify;
    }
    if ([segue.identifier isEqualToString:@"presentToLockViewSegue"]) {
        LLLockViewController *lockVC=(LLLockViewController *)segue.destinationViewController;
        lockVC.nLockViewType=lockViewtype;
    }
}


-(void)viewDidLayoutSubviews
{
    [self.tableView setScrollEnabled:YES];
    self.tableView.contentSize = CGSizeMake(self.view.frame.size.width, 500);
    self.tableView.showsHorizontalScrollIndicator=NO;
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleNew.png"] forBarMetrics:UIBarMetricsDefault];
    //[self.tableView setScrollEnabled:YES];
    
    
    if ([User shareUser].verificationStatus != VerificationStatusType_Passed) {
        _dataSourceTitleArr = [[NSMutableArray alloc] initWithObjects:
                               @"用户信息",
                               @"开户信息修改",
                               @"资料补全",
                               @"修改登录密码",
                               @"修改支付密码",
                               @"找回支付密码",
                               @"重置手势图案密码",
                               @"用户注销",nil];
        _dataSourceImageArr = [[NSMutableArray alloc] initWithObjects:
                               @"string",
                               @"string",
                               @"string",
                               @"string",
                               @"string",
                               @"string",
                               @"string",
                               @"string",
                               nil];
    } else {
        _dataSourceTitleArr = [[NSMutableArray alloc] initWithObjects:
                               @"用户信息",
                               @"手机号码更改申请",
                               @"银行卡信息变更申请",
                               @"修改登录密码",
                               @"修改支付密码",
                               @"找回支付密码",
                               @"重置手势图案密码",
                               @"用户注销",nil];
        _dataSourceImageArr = [[NSMutableArray alloc] initWithObjects:
                               @"informationinquiry",
                               @"phonenumberchange",
                               @"bankcardmessagechange",
                               @"changepassword",
                               @"changepassword",
                               @"changepassword",
                               @"gestures_img",
                               @"shut_down",nil];
        
    }
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundView = nil;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 5)];
    view.backgroundColor = [UIColor clearColor];
    //[self.tableView setTableFooterView:view];
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"账户管理"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
    }else{
        return 3;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.textLabel.text = [_dataSourceTitleArr objectAtIndex:0];
            cell.imageView.image=[UIImage imageNamed: [_dataSourceImageArr objectAtIndex:0]];
            //cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }else if(indexPath.row==1)
        {
            cell.textLabel.text=[_dataSourceTitleArr objectAtIndex:1];
            cell.imageView.image=[UIImage imageNamed: [_dataSourceImageArr objectAtIndex:1]];
            //cell.selectionStyle = UITableViewCellSelectionStyleGray;;
        }else if(indexPath.row==2)
        {
            cell.textLabel.text=[_dataSourceTitleArr objectAtIndex:2];
            cell.imageView.image=[UIImage imageNamed: [_dataSourceImageArr objectAtIndex:2]];
            //cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
    }else if(indexPath.section==1)
    {
        if (indexPath.row==0) {
            cell.textLabel.text=[_dataSourceTitleArr objectAtIndex:3];
            cell.imageView.image=[UIImage imageNamed: [_dataSourceImageArr objectAtIndex:3]];
            //cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }else if (indexPath.row==1)
        {
            cell.textLabel.text=[_dataSourceTitleArr objectAtIndex:4];
            cell.imageView.image=[UIImage imageNamed: [_dataSourceImageArr objectAtIndex:4]];
            //cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }else
        {
            cell.imageView.image=[UIImage imageNamed: [_dataSourceImageArr objectAtIndex:5]];
            cell.textLabel.text=[_dataSourceTitleArr objectAtIndex:5];
            //cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    changePasswordSegue  bankInformationChangeSegue  phoneNumberChangeSegue  merchantMessageSegue
    
    //    bankInformationChangePassedSegue
    
    //int selectIndex = indexPath.section;
    if ([User shareUser].verificationStatus != VerificationStatusType_Passed) {
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                [self performSegueWithIdentifier:@"merchantMessageSegue" sender:self];
            }
            else if (indexPath.row==1){
                [self showWarmingWithMessage:@"用户权限，请补全资料审核通过后再试"];
            }else
            {
                [self performSegueWithIdentifier:@"realNameSegue" sender:self];
            }
        }else if (indexPath.section==1)
        {
            [self showWarmingWithMessage:@"用户权限，请补全资料审核通过后再试"];
            
        }else
        {
            [self showWarmingWithMessage:@"未设手势密码"];
        }
        
        
    } else {
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                
                
                [self performSegueWithIdentifier:@"merchantMessageSegue" sender:self];
            }else if(indexPath.row==1)
            {
                self.phoneNumberChangeAlterView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"手机号码变更申请需要审核，未审核通过前不允许使用任何功能，请知悉" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [self.phoneNumberChangeAlterView show];
                
                
            }else
            {
                self.bankCardChangeAlterView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"银行卡信息变更申请需要审核，未审核通过前不允许使用提现功能，请知悉" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [self.bankCardChangeAlterView show];
                
            }
        }else if (indexPath.section==1)
        {
            if (indexPath.row==0) {
                [self performSegueWithIdentifier:@"changePasswordSegue" sender:self];
            }else if (indexPath.row==1)
            {
                [self performSegueWithIdentifier:@"changePayPasswordSegue" sender:self];
            }
            else{
                [self performSegueWithIdentifier:@"findPayPassWordSegue" sender:self];
            }
        }    }
}




-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView==self.phoneNumberChangeAlterView) {
        if (buttonIndex==0) {
            return;
        }else
        {
            [self performSegueWithIdentifier:@"phoneNumberChangeSegue" sender:self];
        }
    }
    else if (alertView==self.bankCardChangeAlterView)
    {
        if (buttonIndex==0) {
            return;
        }else
        {
            if([User shareUser].status==4){
                [UIComponentService showMessageAlertView:nil message:@"变更手机号码申请正在审核中，请稍后再试"];
                return;
            }else{
            
            [self performSegueWithIdentifier:@"bankInformationChangePassedSegue" sender:self];
            }
        }
    }
}

@end
