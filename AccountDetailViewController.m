//
//  AccountDetailViewController.m
//  BusinessPay
//
//  Created by SHANGYITONG on 14-12-24.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "AccountDetailViewController.h"
#import "WithDrawViewController.h"

@implementation AccountDetailViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
////    if([segue.identifier isEqualToString:@"withDrawsegue"])
////    {
////        WithDrawViewController *withDrawVC=(WithDrawViewController *)segue.destinationViewController;
////     withDrawVC.accountDO=self.accountDO;
////    }
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.tableView.dataSource=self;
//    self.tableView.delegate=self;
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"交易明细" style:(UIBarButtonItemStyleDone) target:self action:@selector(buttonAction:)];
    
//    _arrayImage=[[NSMutableArray alloc]initWithObjects:
//                            @"money",
//                            @"money",
//                            @"money",
//                            @"money",
//                            @"money",
//                            @"money",nil];
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"收益明细"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    
    [self accountResponseSuccess];
    
}

-(void)buttonAction:(id)sender
{
    [self performSegueWithIdentifier:@"orderInquirySegue" sender:self];
}


//-(void) accountRequest
//{
//    _accountDO=[[AccountDO alloc] init];
//    _accountDO.delegate=self;
//    _accountDO.phoneNumber=[User shareUser].phoneNumber;
//    _accountDO.trancode=kTrancode_AccountMessage;
//    
//    [_accountDO accountRequest];
//    NSLog(@"account.card=%@",_accountDO.bindCard);
//}


-(void)accountResponseSuccess{
{
    
   
    
    float money=[self.accountDO.totalAccount integerValue]/100.0f;
    self.totalAccount.text=[NSString stringWithFormat:@"￥%.2f",money];
    
    float money2=[self.accountDO.accumulatedIncome integerValue]/100.0f;
    self.totalIncome.text=[NSString stringWithFormat:@"￥%.2f",money2];
    
    float money3=[self.accountDO.yestedayIncome integerValue]/100.0f;
    self.yestodayIncome.text=[NSString stringWithFormat:@"￥%.2f",money3];
    
    float money4=[self.accountDO.weekIncome integerValue]/100.0f;
    self.weekIncome.text=[NSString stringWithFormat:@"￥%.2f",money4];
    
    float money5=[self.accountDO.monthIncome integerValue]/100.0f;
    self.monthIncome.text=[NSString stringWithFormat:@"￥%.2f",money5];
    
   
    
    
}
}
@end

//-(void)accountFieldWithMessage:(NSString *)message
//{
//    if ([_accountDO.responseCode isEqualToString:@"02042"]) {
//        [UIComponentService showFailHudWithStatus:nil];
//        self.totalAccount.text=@"￥0.0";
//        self.totalIncome.text=@"￥0.0";
//        
//    }else{
//        [UIComponentService showFailHudWithStatus:message];
//    }
//}









//-(IBAction)clickButton:(id)sender
//{
//    //[self performSegueWithIdentifier:@"resetPayPasswordSuegue" sender:self];
//
//   // [self performSegueWithIdentifier:@"withDrawsegue" sender:self];
//    
//}
//



//#pragma mark - datasourse
//
//
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 5;
//}
//
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 1;
//}
//
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
//    
//    if (indexPath.section==0) {
//        
//        //cell.imageView.image=[UIImage imageNamed:[_arrayImage objectAtIndex:indexPath.section]];
//        cell.textLabel.text=@"账户总余额";
//        float money=[self.accountDO.totalAccount integerValue]/100.f;
//        
//        NSLog(@"%f",money);
//        cell.detailTextLabel.text=[NSString stringWithFormat:@"￥%.2f",money];
//        
////        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(280, 10, 20, 10)];
////        [btn setTitle:@"账单" forState:(UIControlStateNormal)];
////        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
////        
////        [cell addSubview:btn];
////        
////         //cell.accessoryType=[[UIBarButtonItem alloc]initWithTitle:@"账单" style:(UIBarButtonItemStylePlain) target:self action:@selector(buttonAction:)];
////        
//        
//    }
//    else if (indexPath.section==1)
//    {
//        //cell.imageView.image=[UIImage imageNamed:[_arrayImage objectAtIndex:indexPath.section]];
//        cell.textLabel.text=@"总收益";
//        float money=[self.accountDO.accumulatedIncome integerValue]/100.f;
//        cell.detailTextLabel.text=[NSString stringWithFormat:@"￥%.2f",money];
//    }else if (indexPath.section==2)
//    {
//        //cell.imageView.image=[UIImage imageNamed:[_arrayImage objectAtIndex:indexPath.section]];
//        cell.textLabel.text=@"昨日收益";
//        float money=[self.accountDO.yestedayIncome integerValue]/100.f;
//        cell.detailTextLabel.text=[NSString stringWithFormat:@"￥%.2f",money];
//    }else if (indexPath.section==3)
//    {
//        //cell.imageView.image=[UIImage imageNamed:[_arrayImage objectAtIndex:indexPath.section]];
//        cell.textLabel.text=@"近一周收益";
//        float money=[self.accountDO.weekIncome integerValue]/100.f;
//        cell.detailTextLabel.text=[NSString stringWithFormat:@"￥%.2f",money];
//    }
//    else
//    {
//        //cell.imageView.image=[UIImage imageNamed:[_arrayImage objectAtIndex:indexPath.section]];
//        cell.textLabel.text=@"近一月收益";
//        float money=[self.accountDO.monthIncome integerValue]/100.f;
//        cell.detailTextLabel.text=[NSString stringWithFormat:@"￥%.2f",money];
//    }
//    
//    return  cell;
//}
//
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 10;
//}




