//
//  MyCircleViewController.m
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-17.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "MyCircleViewController.h"
#import "MyCircleTableViewCell.h"
#import "MyCircleDO.h"


@interface MyCircleViewController ()

@end

//@synthesize array=_array;

@implementation MyCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.temArr=[NSMutableArray arrayWithCapacity:2048];
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"我推荐的好友"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleNew.png"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"titleNew.png"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:225/255.f green:225/255.f blue:225/255.f alpha:1]];
    
    _mycircle = [[MyCircleDO alloc]init];
    _fenrunStr = _mycircle.FenRunEarnings;
    if (_fenrunStr == nil) {
        _fenrunimage.image = [UIImage imageNamed:@"duang2.png"];
    }else{
        
        _fenrunimage.image = [UIImage imageNamed:@"duang1.png"];
        
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.temArr.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCircleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    
    MyCircleDO * myCircleDO=[self.temArr objectAtIndex:indexPath.row];
    
//    cell.imageView.layer.masksToBounds = YES;
//    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    cell.merchantNameLabel.text=myCircleDO.merchantName;
    cell.merchantPhoneNumberLabel.text=myCircleDO.merPhoneNumber;
    
    cell.imageIV.image = [UIImage imageNamed:@"cell3.png"];
    
    if (myCircleDO.applyDate.length<=8) {
//         cell.createTimeLabel.text        = [NSString stringWithFormat:@"%@-%@-%@",[myCircleDO.applyDate substringWithRange:NSMakeRange(0, 4)],[myCircleDO.applyDate substringWithRange:NSMakeRange(4, 2)],[myCircleDO.applyDate substringWithRange:NSMakeRange(6, 2)]];
    }
    else
    {
//    
//      cell.createTimeLabel.text = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",[myCircleDO.applyDate substringWithRange:NSMakeRange(0, 4)],[myCircleDO.applyDate substringWithRange:NSMakeRange(4, 2)],[myCircleDO.applyDate substringWithRange:NSMakeRange(6, 2)],[myCircleDO.applyDate substringWithRange:NSMakeRange(8, 2)],[myCircleDO.applyDate substringWithRange:NSMakeRange(10, 2)],[myCircleDO.applyDate substringWithRange:NSMakeRange(12, 2)]];
    }
    
    return cell;
    //cell.createTimeLabel.text=myCircleDO.applyDate;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
