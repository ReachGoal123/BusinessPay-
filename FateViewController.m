//
//  FateViewController.m
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-2.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "FateViewController.h"
#import "FateListViewController.h"

@interface FateViewController ()

@property(nonatomic,strong) IBOutlet UILabel *fateLabel;

@property (nonatomic,strong) FateListDO *fateListDO;

-(IBAction)buyFate:(id)sender;

@end

@implementation FateViewController


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([segue.identifier isEqualToString:@"feilvshengjSegue"]) {
//        FateListViewController *fatelistViewController=(FateListViewController *)segue.destinationViewController;
//        fatelistViewController.temArr=_fateListDO.temArr;
//    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fateLabel.text=[NSString stringWithFormat:@"%@%%",[User shareUser].nocCardFeeRete];
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"费率"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buyFate:(id)sender
{
    if ([[User shareUser].nocCardFeeRete isEqualToString:@"0.49"]) {
        [self showWarmingWithMessage:@"当前费率不可升级"];
        return;
    }else{
        [self performSegueWithIdentifier:@"fateupgradeSegue" sender:self];}
//    if ([User shareUser].status==0) {
//        if ([[User shareUser].nocCardFeeRete isEqualToString:@"0.49"]) {
//            [self showWarmingWithMessage:@"当前费率不可升级"];
//            return;
//        }
//        [UIComponentService showHudWithStatus:kPleaseWait];
//        [self performSelector:@selector(fateListRequest) withObject:nil afterDelay:kDelayTime];
//        //[self performSegueWithIdentifier:@"pushToWithDrawSegue" sender:self];
//    }else if ([User shareUser].status==1)
//    {
////        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您的资料正在审核中，请待审核通过后再试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
////        [alertView show];
//        [UIComponentService showMessageAlertView:@"提示" message:@"您的资料正在审核中，请待审核通过后再试"];
//        
//    }else if ([User shareUser].status==2)
//    {
//        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"为了您账户安全！请补全资料进行实名认证再进行操作" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [alertView show];
//        
//    }else if ([User shareUser].status==4)
//    {
//        [UIComponentService showMessageAlertView:@"提示" message:@"变更手机号码申请正在审核中，请稍后再试"];
//    }else if ([User shareUser].status==3)
//    {
//        [UIComponentService showMessageAlertView:@"提示" message:@"变更银行卡申请正在审核中，请稍后再试"];
//    }else if([User shareUser].status==-1)
//    {
//        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您的资料审核未通过，请重新补全资料" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [alertView show];
//        
//    }

}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self performSegueWithIdentifier:@"fateToRealNameSegue" sender:self];
}


//-(void) fateListRequest
//{
//    
//    _fateListDO=[[FateListDO alloc] init];
//    _fateListDO.delegate=self;
//    _fateListDO.trancode =kTrancode_FateList;
//    
//    _fateListDO.phoneNumber=[User shareUser].phoneNumber;
//    
//    [_fateListDO fateListInquaryRequest];
//    
//}

//-(void)fateListInquarySuccessWithMessage:(NSString *)message
//{
//    [UIComponentService showSuccessHudWithStatus:message];
//    [self performSegueWithIdentifier:@"feilvshengjSegue" sender:self];
//    
//}
//
//-(void)fateListInquaryFieldWithMessage:(NSString *)message
//{
//    [UIComponentService showFailHudWithStatus:message];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
