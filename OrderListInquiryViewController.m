//
//  OrderListInquiryViewController.m
//  BusinessPay
//
//  Created by Tears on 14-4-17.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "OrderListInquiryViewController.h"

@interface OrderListInquiryViewController ()
- (IBAction)orderListInquiryAction:(id)sender;

- (IBAction)orderDetailAction:(id)sender;

@end

@implementation OrderListInquiryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.ta.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.registerTable.bounds.size.width, 0.01f)];

}


- (IBAction)orderListInquiryAction:(id)sender {
    
    OrderInquiryDO * orderInquiryDO = [[OrderInquiryDO alloc] init];
    orderInquiryDO.trancode = kTrancode_OrderList ;
    orderInquiryDO.phoneNumber = [User shareUser].phoneNumber;
    orderInquiryDO.currentPage = @"1";
    orderInquiryDO.accountPerPage = @"500";
    orderInquiryDO.startDataTime = @"20140416";
    orderInquiryDO.endDataTime = @"20140417";
    [orderInquiryDO orderListInquiryRequest];
}

- (IBAction)orderDetailAction:(id)sender {
    OrderDetailDO * orderDetailDO = [[OrderDetailDO alloc] init];
    orderDetailDO.phoneNumber = [User shareUser].phoneNumber;
    orderDetailDO.trancode = kTrancode_OrderDetail ;
    orderDetailDO.orderCode = @"2014121514110000372";
    orderDetailDO.orderDataTime = @"20140417194925";
    [orderDetailDO orderDetailRequest];
}



@end
