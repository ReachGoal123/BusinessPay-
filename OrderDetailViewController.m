//
//  OrderDetailViewController.m
//  BusinessPay
//
//  Created by Tears on 14-4-25.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "AnotherPayViewController.h"

@interface OrderDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *ordermoneyLab;
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLab;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLab;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
- (IBAction)payAction:(id)sender;

//response


@end

@implementation OrderDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.payBtn.hidden          = YES;
    self.orderPayDO=[[OrderPayDO alloc] init];
    [UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(orderRequest) withObject:nil afterDelay:kDelayTime];
}

- (void)orderRequest
{
    OrderDetailDO * orderDetailDO = [[OrderDetailDO alloc] init];
//    //self.orderCreateDO=[[OrderCreateDO alloc] init];
//    orderDetailDO.delegate = self ;
//    orderDetailDO.phoneNumber = [User shareUser].phoneNumber ;
//    orderDetailDO.trancode = kTrancode_OrderDetail ;
//    orderDetailDO.orderCode = self.orderCreateDO.merchantNO ;
//    NSLog(@"订单号=%@",self.orderCreateDO.merchantNO);
//    //NSLog(@"%@",orderDetailDO.orderCode);
//    orderDetailDO.orderDataTime = self.orderCreateDO.merchantDate ;
//    NSLog(@"订单时间=%@",self.orderCreateDO.merchantDate);
//    [orderDetailDO orderDetailRequest] ;
    orderDetailDO.delegate=self;
    orderDetailDO.phoneNumber=[User shareUser].phoneNumber;
    orderDetailDO.trancode=kTrancode_OrderDetail;
    orderDetailDO.orderCode =self.orderDO.orderNum;
    NSLog(@"%@",orderDetailDO.orderCode);
    orderDetailDO.orderDataTime=self.orderDO.payTime;
    orderDetailDO.urlType=@"1";
    [orderDetailDO orderDetailRequest];
    
    
}

-(void)orderDetailSuccessWithMessage:(NSString *)message andPhoneNumber:(NSString *)phoneNumber andMerorderStatus:(NSString *)merorderStatus
{
    

//- (void)orderDetailSuccessWithMessage: (NSString *)message andPhoneNumber:(NSString *)phoneNumber andMerorderStatus:(NSString *)merorderStatus

    [UIComponentService showSuccessHudWithStatus:message];
    float money = [self.orderDO.orderMoney integerValue]/100.f;
    self.ordermoneyLab.text     = [NSString stringWithFormat:@"%.2f",money];;
    self.orderNumberLab.text    = self.orderDO.orderNum;
    self.orderTimeLab.text      = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",[self.orderDO.payTime substringWithRange:NSMakeRange(0, 4)],[self.orderDO.payTime substringWithRange:NSMakeRange(4, 2)],[self.orderDO.payTime  substringWithRange:NSMakeRange(6, 2)],[self.orderDO.payTime  substringWithRange:NSMakeRange(8, 2)],[self.orderDO.payTime  substringWithRange:NSMakeRange(10, 2)]];
    //OrderDetailDO * orderDetailDO = [[OrderDetailDO alloc] init];
    self.orderStatusLab.text    = [BaseModel statusString:merorderStatus];
    self.phoneNumberLab.text    = phoneNumber;
    if ([self.orderStatusLab.text isEqualToString:@"付款成功"]) {
        self.payBtn.hidden          = YES;
    } else {
        self.payBtn.hidden          = NO;
    }
}

- (void)orderDetailFailWithMessage: (NSString *)message andPhoneNumber:(NSString *)phoneNumber andMerorderStatus:(NSString *)merorderStatus
{
    [UIComponentService showFailHudWithStatus:message];
    float money = [self.orderDO.orderMoney integerValue]/100.f;
    self.ordermoneyLab.text     = [NSString stringWithFormat:@"%.2f",money];;
    self.orderNumberLab.text    = self.orderDO.orderNum;
    self.orderTimeLab.text      = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",[self.orderDO.payTime substringWithRange:NSMakeRange(0, 4)],[self.orderDO.payTime substringWithRange:NSMakeRange(4, 2)],[self.orderDO.payTime  substringWithRange:NSMakeRange(6, 2)],[self.orderDO.payTime  substringWithRange:NSMakeRange(8, 2)],[self.orderDO.payTime  substringWithRange:NSMakeRange(10, 2)]];
    //OrderDetailDO * orderDetailDO = [[OrderDetailDO alloc] init];
    self.orderStatusLab.text    = [BaseModel statusString:merorderStatus];
    self.phoneNumberLab.text    = phoneNumber;
    if ([self.orderStatusLab.text isEqualToString:@"付款成功"]) {
        self.payBtn.hidden          = YES;
    } else {
        self.payBtn.hidden          = NO;
    }
}

- (IBAction)payAction:(id)sender {
    
    [UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(orderPayRequest) withObject:nil afterDelay:kDelayTime];
}



-(void)orderPayRequest
{
    //=[[OrderPayDO alloc] init];
    [self.orderPayDO setDelegate:self];
    self.orderPayDO.phoneNumber=[User shareUser].phoneNumber;
    self.orderPayDO.trancode=kTrancode_OrderPay;
    self.orderPayDO.menchantNO=self.orderDO.orderNum;
    self.orderPayDO.urlType=@"1";

    [self.orderPayDO submitOrderRequest];
}

-(void)orderPayScuessWithReurl:(NSString *)reurl andMessage:(NSString *)message
{
    [UIComponentService showSuccessHudWithStatus:@"请支付"];
    [self performSegueWithIdentifier:@"paytoanother" sender:self];
}

-(void)orderPayFailWithMessage:(NSString *)message
{
    [UIComponentService showFailHudWithStatus:message];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"paytoanother"])
    {
        AnotherPayViewController *anPayVC=(AnotherPayViewController *)segue.destinationViewController;
        anPayVC.link=self.orderPayDO.reURL;
    }
}

- (void)UPPayPluginResult:(NSString *)result
{
    NSLog(@"result == %@",result);
}

@end
