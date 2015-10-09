//
//  MyCircleViewController.h
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-17.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseViewController.h"
#import "MyCircleDO.h"

@interface MyCircleViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    //NSMutableArray *temArr;
}


//@property (nonatomic,strong) NSMutableArray *temArr;

@property (nonatomic,strong) NSMutableArray *temArr;
@property (nonatomic,strong) IBOutlet UITableView *tableView;

@property (nonatomic,strong) IBOutlet UIImageView *fenrunimage; //显示的图片
@property (nonatomic,strong)  NSString *fenrunStr;
@property(nonatomic,strong)MyCircleDO *mycircle;

@end
