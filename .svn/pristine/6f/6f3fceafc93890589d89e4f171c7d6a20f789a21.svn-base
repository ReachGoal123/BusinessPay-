//
//  OrderPayLIstTableViewController.h
//  BusinessPay
//
//  Created by SHANGYITONG on 15-1-13.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderPayInquiryDO.h"
#import "OrderPayDO.h"

@interface OrderPayLIstTableViewController : UITableViewController<OrderPayDelegate,UIAlertViewDelegate>


@property (nonatomic, strong) OrderPayDO *orderPayDO;
@property (nonatomic,strong) NSMutableArray *dataSourceArr;

@property (nonatomic,strong) NSString *startTime;
@property (nonatomic,strong) NSString *endTime;

@property (nonatomic,strong) IBOutlet UISegmentedControl *segmentControl;

-(IBAction)segmentControlValueChange:(id)sender;

@end
