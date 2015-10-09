//
//  OrderPayInquiryViewController.h
//  BusinessPay
//
//  Created by SHANGYITONG on 15-1-13.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderPayInquiryDO.h"
#import "OrderDetailDO.h"

@interface OrderPayInquiryViewController : UITableViewController<OrderPayInquiryDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataSourceArr;

//@property (nonatomic,strong) UITableView *tableView;


@end
