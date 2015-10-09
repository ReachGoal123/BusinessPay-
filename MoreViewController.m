//
//  MoreViewController.m
//  BusinessPay
//
//  Created by SHANGYITONG on 15-1-7.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "MoreViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AAActivityAction.h"
#import "AAActivity.h"
#import "LoginViewController.h"
#import "LLLockViewController.h"

@interface MoreViewController()

@property (nonatomic,strong) LoginViewController *loginVC;

@end

@implementation MoreViewController




-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title"] forBarMetrics:UIBarMetricsDefault];
    
    
    UIImage *title_bg = [UIImage imageNamed:@"titleNew.png"];  //获取图片
    CGSize titleSize = self.navigationController.navigationBar.bounds.size;  //获取Navigation Bar的位置和大小
    title_bg = [self scaleToSize:title_bg size:titleSize];//设置图片的大小与Navigation Bar相同
    [self.navigationController.navigationBar
     setBackgroundImage:title_bg
     forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = YES;
}
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


-(void)viewDidLoad
{
    [super viewDidLoad] ;
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH,20)];
    imageView.image = [UIImage imageNamed:@"titleNew.png"];
    [self.view addSubview:imageView];
    
//    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 20)];
//    imageView.image = [UIImage imageNamed:@"navbackground"];
//    [self.view addSubview:imageView];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleNew.png"] forBarMetrics:UIBarMetricsDefault];
    
    _dataTitleArr= [[NSMutableArray alloc] initWithObjects:
                    @"客户服务",
                    @"关于资质",
                    @"关于钱包",
                    @"意见反馈",nil];
    _dataImageArr = [[NSMutableArray alloc] initWithObjects:
                           @"customer_img",
                           @"sort_by_price",
                           @"aboutWallet",
                           @"feed_img",nil];
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
     self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
//    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 5)];
//    view.backgroundColor = [UIColor clearColor];

    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"帮  助"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    
}


- (void)viewDidUnload {
    [self setIconSizeSetting:nil];
    [super viewDidUnload];
}
-(void)shareAction:(id)sender
{
//  
//    AAImageSize imageSize = [self iconSizeSetting].selectedSegmentIndex == 0 ? AAImageSizeSmall : AAImageSizeNormal;
//    UIImage *image = [UIImage imageNamed:(imageSize == AAImageSizeSmall ? @"Safari-Small.png" : @"Safari.png")];
//    NSMutableArray *array = [NSMutableArray array];
//    
//    for (int i=0; i<8; i++) {
//        AAActivity *activity = [[AAActivity alloc] initWithTitle:@"Safari"
//                                                           image:image
//                                                     actionBlock:^(AAActivity *activity, NSArray *activityItems) {
//                                                         NSLog(@"doing activity = %@, activityItems = %@", activity, activityItems);
//                                                         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[activityItems objectAtIndex:0]]];
//                                                     }];
//        [array addObject:activity];
//    }
//    
//    AAActivityAction *aa = [[AAActivityAction alloc] initWithActivityItems:@[@"http://www.apple.com/"]
//                                                     applicationActivities:array
//                                                                 imageSize:imageSize];
//    //aa.title = @"sample title";
//    [aa show];
    [self showWarmingWithMessage:@"暂无消息"];

}

-(void)getOutAction:(id)sender
{
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil message:@"确定退出?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    
}


#pragma mark - alertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        return;
    }else{
        
//        [LLLockPassword saveLockPassword:nil];
//        [self.loginVC savePhoneNumber:nil andPassword:nil];
        
    [self performSegueWithIdentifier:@"moreToLoginSegue" sender:self];
    }
}

-(void)softWarInformationAction:(id)sender
{
    [self performSegueWithIdentifier:@"softwarVersionSegue" sender:self];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataTitleArr.count;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            cell.imageView.image=[UIImage imageNamed:[_dataImageArr objectAtIndex:indexPath.section]];
            cell.textLabel.text=[_dataTitleArr objectAtIndex:indexPath.section];
            
            break;
        case 1:
            cell.imageView.image=[UIImage imageNamed:[_dataImageArr objectAtIndex:indexPath.section]];
            cell.textLabel.text=[_dataTitleArr objectAtIndex:indexPath.section];
            
            break;
            
        case 2:
            cell.imageView.image=[UIImage imageNamed:[_dataImageArr objectAtIndex:indexPath.section]];
            cell.textLabel.text=[_dataTitleArr objectAtIndex:indexPath.section];
            break;
        case 3:
            cell.imageView.image=[UIImage imageNamed:[_dataImageArr objectAtIndex:indexPath.section]];
            cell.textLabel.text=[_dataTitleArr objectAtIndex:indexPath.section];
            break;
//        case 4:
//            cell.imageView.image=[UIImage imageNamed:[_dataImageArr objectAtIndex:indexPath.section]];
//            cell.textLabel.text=[_dataTitleArr objectAtIndex:indexPath.section];
//            break;
            
        default:
            break;
    }
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        [self performSegueWithIdentifier:@"helpPhoneSegue" sender:self];
    }else if (indexPath.section==1) {
        [self performSegueWithIdentifier:@"bookSegue" sender:self];
    }else if (indexPath.section==2)
    {
        [self performSegueWithIdentifier:@"accountSegue" sender:self];
    }else if (indexPath.section==3)
    {
        //[self performSegueWithIdentifier:@"pushToFeedBackSegue" sender:self];
        [self showWarmingWithMessage:@"暂未开通"];
    }
    
    
    
}


@end
