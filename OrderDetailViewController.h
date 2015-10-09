//
//  OrderDetailViewController.h
//  BusinessPay
//
//  Created by Tears on 14-4-25.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderPayInquiryDO.h"
#import "OrderInquiryDO.h"
#import "OrderDetailDO.h"
#import "OrderCreateDO.h"
#import "OrderPayDO.h"

@interface OrderDetailViewController : BaseViewController <OrderDetailDelegate,OrderPayDelegate>

@property (nonatomic, strong)OrderPayInquiryDO * orderDO;
@property (nonatomic, strong)OrderCreateDO *orderCreateDO;

@property (nonatomic, strong) OrderPayDO *orderPayDO;

//@property (nonatomic, strong)OrderDetailDO *orderDetailDO;
@end
