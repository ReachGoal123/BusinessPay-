//
//  OrderListTableViewController.m
//  BusinessPay
//
//  Created by Tears on 14-4-24.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "OrderListTableViewController.h"
#import "OrderInquiryDO.h"
#import "MyTableViewCell.h"
#import "OrderDetailViewController.h"
#import "RadingParticularViewController.h"


@interface OrderListTableViewController ()
{
    OrderPayInquiryDO * _orderDO;
    
}

@property (nonatomic,strong) NSString *algNo;


@end

@implementation OrderListTableViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        RadingParticularViewController *radingVC=(RadingParticularViewController *)segue.destinationViewController;
        radingVC.algno=self.algNo;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"交易记录"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    
    self.tableView.backgroundView = nil;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 10)];
    view.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setTableFooterView:view];
    NSLog(@"datasourse=%lu",(unsigned long)self.dataSourceArr.count);
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArr.count;
    //NSLog(@"datasourse=%i",self.dataSourceArr.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (self.dataSourceArr.count ==0) {
        [self showWarmingWithMessage:@"无交易数据"];
    }else {
    
    OrderInquiryDO * orderDO = [self.dataSourceArr objectAtIndex:indexPath.row];
    if([orderDO.orderType isEqualToString:@"0"])
    {
        if([orderDO.orderStype isEqualToString:@"01"])
        {
        cell.orderType.text=@"充值";
        }else if ([orderDO.orderStype isEqualToString:@"02"])
        {
            cell.orderType.text=[NSString stringWithFormat:@"转入<——%@",orderDO.outActName];
        }else if ([orderDO.orderStype isEqualToString:@"03"])
        {
            cell.orderType.text=@"充值";
        }else
        {
            cell.orderType.text=@"收益";
        }
        
    }else if([orderDO.orderType isEqualToString:@"2"])
    {
        if ([orderDO.orderStype isEqualToString:@"22"]||[orderDO.orderStype isEqualToString:@"23"])
        {
            if ([orderDO.payActName isEqualToString:nil]) {
                cell.orderType.text=@"转账";
            }else{
            cell.orderType.text =[NSString stringWithFormat:@"转账——> %@",orderDO.payActName];
            }
        }else if([orderDO.orderStype isEqualToString:@"24"])
        {
            NSString *number=[orderDO.recNumber substringWithRange:NSMakeRange(orderDO.recNumber.length-4, 4)];
            cell.orderType.text =[NSString stringWithFormat:@"手机充值-尾号:%@",number];
        }else if([orderDO.orderStype isEqualToString:@"25"])
        {
            cell.orderType.text =@"服务购买";
        }else if([orderDO.orderStype isEqualToString:@"27"]) {
            NSString *number=[orderDO.cardNo substringWithRange:NSMakeRange(orderDO.cardNo.length-4,4)];
            cell.orderType.text=[NSString stringWithFormat:@"信用卡还款-尾号:%@",number];
        }else if([orderDO.orderStype isEqualToString:@"21"])
        {
            cell.orderType.text=@"提现";
        }else
        {
            cell.orderType.text=@"闪电提现";
        }
    }
    
    if([orderDO.payStatus isEqualToString:@"0"])
    {
       cell.statusLab.text         = @"失败";
    }else if([orderDO.payStatus isEqualToString:@"1"])
    {
        cell.statusLab.text        = @"成功";
    }else{
        cell.statusLab.text        = @"处理中";
    }
    float money = [orderDO.totalOrderMoney integerValue]/100.f;
    cell.moneyLab.text          = [NSString stringWithFormat:@"￥%.2f",money];
    cell.payTimeLab.text        = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",[orderDO.payTime substringWithRange:NSMakeRange(0, 4)],[orderDO.payTime substringWithRange:NSMakeRange(4, 2)],[orderDO.payTime substringWithRange:NSMakeRange(6, 2)],[orderDO.payTime substringWithRange:NSMakeRange(8, 2)],[orderDO.payTime substringWithRange:NSMakeRange(10, 2)]];
    //NSString *orderNum=[orderDO.payOrderNumber substringFromIndex:11];
    cell.orderNumberLab.text    = orderDO.orderNum;
    
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    OrderInquiryDO * orderDO = [self.dataSourceArr objectAtIndex:indexPath.row];
    
    self.algNo=orderDO.payOrderNumber;
    
    //NSLog(@"orderNumber=%@",orderDO.payOrderNumber);
    
   [self performSegueWithIdentifier:@"detailSegue" sender:self];
    
    
    
}



@end
