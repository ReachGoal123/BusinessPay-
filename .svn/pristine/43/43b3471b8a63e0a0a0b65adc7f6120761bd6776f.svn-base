//
//  OrderListInquiryTableViewController.m
//  BusinessPay
//
//  Created by Tears on 14-4-22.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "OrderListInquiryTableViewController.h"
#import "OrderListTableViewController.h"

@interface OrderListInquiryTableViewController ()
{
    BOOL _hasChickStartTime;
    BOOL _hasChickEndTime;
}
@property (weak, nonatomic) IBOutlet UIView *datePickerBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *promptLab;
@property (weak, nonatomic) IBOutlet UILabel *startLab;
@property (weak, nonatomic) IBOutlet UILabel *endLab;

@property (weak, nonatomic) IBOutlet UILabel *settlementMethodLab;
@property (strong, nonatomic)  UIDatePicker *datepicker;
@property (strong, nonatomic)  UIDatePicker *datepickerEnd;
@property (copy, nonatomic) NSString * startTimeStr;
@property (copy, nonatomic) NSString * endTimeStr;
@property (assign, nonatomic) int selectIndex;
@property (strong, nonatomic) NSMutableArray * orderArr;


@property (strong,nonatomic) UIButton *buttonStart;
@property (strong,nonatomic) UIButton *buttonEnd;

-(void) selectStartTime:(id)sender;

-(void) selectEndTime:(id)sender;



- (IBAction)inquiryAction:(id)sender;


- (IBAction)settlementMethod:(id)sender;

@end

@implementation OrderListInquiryTableViewController

@synthesize orderArr = _orderArr;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"orderListSegue"]) {
        OrderListTableViewController * orderListVC = (OrderListTableViewController *)segue.destinationViewController;
        orderListVC.dataSourceArr = self.orderArr;
        
        //NSLog(@"orderListVC=%@",orderListVC);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"查询交易记录"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    self.orderArr=[NSMutableArray arrayWithCapacity:2048];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleNew.png"] forBarMetrics:UIBarMetricsDefault];
    self.tableView.scrollEnabled = NO;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 15.f)];
    //NSDate * date =[NSData ];
    NSDate *date=[NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年MM月dd日";
    NSString * dateString = [formatter stringFromDate:date];
    NSDateFormatter * formatterStr = [[NSDateFormatter alloc] init];
    formatterStr.dateFormat = @"yyyyMMdd";
    NSString * dateStr = [formatterStr stringFromDate:date];

    self.endLab.text=dateString;
    self.endTimeStr=dateStr;
    
    
    NSDate *dateStart=[NSDate dateWithTimeIntervalSinceNow:-(7*24*60*60)];
    NSString *dateStringStart=[formatter stringFromDate:dateStart];
    NSString *dateStrStart=[formatterStr stringFromDate:dateStart];
    
    self.startLab.text=dateStringStart;
    self.startTimeStr=dateStrStart;
    
    
    self.datepicker = [[UIDatePicker alloc] init];
    self.datepicker.datePickerMode = UIDatePickerModeDate;
    self.datepicker.minuteInterval = 30;
    //[self.datepicker addTarget:self action:@selector(chooseStartDate:) forControlEvents:UIControlEventValueChanged];

    self.datepickerEnd=[[UIDatePicker alloc] init];
    self.datepickerEnd.datePickerMode=UIDatePickerModeDate;
    self.datepickerEnd.minuteInterval=30;
    //[self.datepickerEnd addTarget:self action:@selector(chooseEndDate:) forControlEvents:UIControlEventValueChanged];
    
    
    self.buttonStart=[[UIButton alloc] init];
    [self.buttonStart setTitle:@"确定" forState:(UIControlStateNormal)];
    [self.buttonStart setBackgroundImage:[UIImage imageNamed:@"buttonbackground"] forState:(UIControlStateNormal)];
    
    [self.buttonStart addTarget:self action:@selector(selectStartTime:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    self.buttonEnd =[[UIButton alloc] init];
    [self.buttonEnd setTitle:@"确定" forState:(UIControlStateNormal)];
    [self.buttonEnd setBackgroundImage:[UIImage imageNamed:@"buttonbackground"] forState:(UIControlStateNormal)];
    [self.buttonEnd addTarget:self action:@selector(selectEndTime:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    //self.selectIndex = 0;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        if (self.datepickerEnd!=nil) {
            [self.datepickerEnd removeFromSuperview];
            [self.buttonEnd removeFromSuperview];
            
        }
        self.datepicker.frame = CGRectMake(0, kSCREEN_HEIGHT-200, kSCREEN_WIDTH, 200);
        self.buttonStart.frame=CGRectMake(kSCREEN_WIDTH-80, kSCREEN_HEIGHT-230, 60, 30);
        [self.view addSubview:self.datepicker];
        [self.view addSubview:self.buttonStart];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        //self.datepicker. -= self.datepicker.frame.size.height;
        [UIView commitAnimations];
    }else
    {
        if (self.datepicker!=nil) {
            [self.datepicker removeFromSuperview];
            [self.buttonStart removeFromSuperview];
            
        }
        self.datepickerEnd.frame = CGRectMake(0, kSCREEN_HEIGHT-240, kSCREEN_WIDTH, 216);
        self.buttonEnd.frame=CGRectMake(kSCREEN_WIDTH-80, kSCREEN_HEIGHT-260, 60, 30);
        [self.view addSubview:self.datepickerEnd];
        [self.view addSubview:self.buttonEnd];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        //self.datepicker. -= self.datepicker.frame.size.height;
        [UIView commitAnimations];
    }
}


-(void) selectStartTime:(id)sender{
    NSDate *selectedDate = [self.datepicker date];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
//    NSString *dateString = [formatter stringFromDate:selectedDate];
   // self.testTimeField.text = dateString;
    
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy年MM月dd日";
        NSString * dateString = [formatter stringFromDate:selectedDate];
        NSDateFormatter * formatterStr = [[NSDateFormatter alloc] init];
        formatterStr.dateFormat = @"yyyyMMdd";
        NSString * dateStr = [formatterStr stringFromDate:selectedDate];
    
        self.startLab.text=dateString;
        self.startTimeStr=dateStr;
    [self.buttonStart removeFromSuperview];
    [self.datepicker removeFromSuperview];
}

-(void) selectEndTime:(id)sender{
     NSDate *selectedDate = [self.datepickerEnd date];
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年MM月dd日";
    NSString * dateString = [formatter stringFromDate:selectedDate];
    NSDateFormatter * formatterStr = [[NSDateFormatter alloc] init];
    formatterStr.dateFormat = @"yyyyMMdd";
    NSString * dateStr = [formatterStr stringFromDate:selectedDate];
    
    self.endLab.text=dateString;
    self.endTimeStr=dateStr;
    [self.buttonEnd removeFromSuperview];
    [self.datepickerEnd removeFromSuperview];
}


- (IBAction)inquiryAction:(id)sender {
    
    if ([self.endTimeStr integerValue]<[self.startTimeStr integerValue]) {
        [self showWarmingWithMessage:@"起始日期有误"];
        return;
    }
    
    [UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(recordInquiry) withObject:nil afterDelay:kDelayTime];
}
- (void)recordInquiry
{
    OrderInquiryDO * orderInquiryDO = [[OrderInquiryDO alloc] init];
    orderInquiryDO.delegate         = self;
    orderInquiryDO.trancode         = @"701123";
    
    orderInquiryDO.phoneNumber      = [User shareUser].phoneNumber;
    orderInquiryDO.currentPage      = kInquiryCurrentPage;
    orderInquiryDO.accountPerPage   = kInquiryNumber;
    orderInquiryDO.startDataTime    = self.startTimeStr;
    orderInquiryDO.endDataTime      = self.endTimeStr;
    [orderInquiryDO orderListInquiryRequest];
}

- (IBAction)settlementMethod:(id)sender {
    [self.view endEditing:YES];
    UIAlertView *alertView = [[UIAlertView  alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"全部", @"充值",@"提现",@"收益",@"转入",@"转出",@"服务购买",@"闪电提现",@"手机充值", nil];
    //actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    //[actionSheet showInView:self.view];
    [alertView show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            self.settlementMethodLab.text=@"全部";
            break;
        case 1:
            self.settlementMethodLab.text=@"充值";
            break;
        case 2:
            self.settlementMethodLab.text=@"提现";
            break;
        case 3:
            self.settlementMethodLab.text=@"收益";
            break;
        case 4:
            self.settlementMethodLab.text=@"转入";
            break;
        case 5:
            self.settlementMethodLab.text=@"转出";
            break;
        case 6:
            self.settlementMethodLab.text=@"服务购买";
            break;
        case 7:
            self.settlementMethodLab.text=@"闪电提现";
            break;
        case 8:
            self.settlementMethodLab.text=@"手机充值";
            
        default:
            break;
    }
}

- (void)orderListInquiryResponseSuccessWithMessage: (NSString *)message andOrderInquiryDOArry:(NSMutableArray *)arr
{
        
    if([self.settlementMethodLab.text isEqualToString:@"全部"])
    {
        self.orderArr = arr;
    }else if ([self.settlementMethodLab.text isEqualToString:@"充值"])
    {
        [self.orderArr removeAllObjects];
        for (int i=0; i<arr.count; i++) {
            OrderInquiryDO * orderDO=arr[i];
            if ([orderDO.orderType isEqualToString:@"0"]) {
                
                if ( [orderDO.orderStype isEqualToString:@"01"]||[orderDO.orderStype isEqualToString:@"03"]) {
                    
                    [_orderArr addObject:orderDO];
                    
                }
            }
        }
        
    }else if ([self.settlementMethodLab.text isEqualToString:@"提现"])
    {
        [self.orderArr removeAllObjects];
        for (int i=0; i<arr.count; i++) {
            OrderInquiryDO * orderDO=arr[i];
            
            if ([orderDO.orderStype isEqualToString:@"21"]) {
                [_orderArr addObject:orderDO];
            }
        }
        
    }else if ([self.settlementMethodLab.text isEqualToString:@"收益"])
    {
        //self.orderArr=nil;
        [self.orderArr removeAllObjects];
        for (int i=0; i<arr.count; i++) {
            OrderInquiryDO * orderDO=arr[i];
            //NSLog(@"orderStype=%@",orderDO.orderStype);
            if ([orderDO.orderStype isEqualToString:@"04"]) {
                [_orderArr addObject:orderDO];
            }
        }
    }else if ([self.settlementMethodLab.text isEqualToString:@"转入"])
    {
        [self.orderArr removeAllObjects];
        for (int i=0; i<arr.count; i++) {
            
            OrderInquiryDO * orderDO=arr[i];
            if ([orderDO.payStatus isEqualToString:@"1"]) {
                if ([orderDO.orderStype isEqualToString:@"02"]) {
                    [self.orderArr addObject:orderDO];
                }
            }
            
        }
    }else if ([self.settlementMethodLab.text isEqualToString:@"转出"])
    {
        [self.orderArr removeAllObjects];
        for (int i=0; i<arr.count; i++) {
            OrderInquiryDO * orderDO=arr[i];
            if ([orderDO.orderStype isEqualToString:@"22"]||[orderDO.orderStype isEqualToString:@"23"]) {
                [self.orderArr addObject:orderDO];
            }
        }
        
    }else if ([self.settlementMethodLab.text isEqualToString:@"服务购买"])
    {
        [self.orderArr removeAllObjects];
        for (int i=0; i<arr.count; i++) {
            OrderInquiryDO * orderDO=arr[i];
            if ([orderDO.orderStype isEqualToString:@"25"]) {
                [self.orderArr addObject:orderDO];
            }
        }
    }else if ([self.settlementMethodLab.text isEqualToString:@"闪电提现"])
    {
        [self.orderArr removeAllObjects];
        for (int i=0; i<arr.count; i++) {
            OrderInquiryDO * orderDO=arr[i];
            if ([orderDO.orderStype isEqualToString:@"26"]||[orderDO.orderStype isEqualToString:@"28"] ) {
                [self.orderArr addObject:orderDO];
            }
        }
    }else if ([self.settlementMethodLab.text isEqualToString:@"手机充值"])
    {
        [self.orderArr removeAllObjects];
        for (int i=0; i<arr.count; i++) {
            OrderInquiryDO * orderDO=arr[i];
            if ([orderDO.orderStype isEqualToString:@"24"]) {
                [self.orderArr addObject:orderDO];
            }
        }
    }
    
    //NSLog(@"数组个数%i",self.orderArr.count);
    
    //self.orderArr = arr;
    [UIComponentService showSuccessHudWithStatus:@"查询成功"];
    [self performSegueWithIdentifier:@"orderListSegue" sender:self];
}

- (void)orderListInquiryResponseFailWithMessage: (NSString *)message
{
    [UIComponentService showFailHudWithStatus:message];
    
}

@end
