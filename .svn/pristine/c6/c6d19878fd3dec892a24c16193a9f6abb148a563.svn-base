//
//  HelpViewController.m
//  BusinessPay
//
//  Created by SHANGYITONG on 15-1-6.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "HelpViewController.h"

@implementation HelpViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH,20)];
    imageView.image = [UIImage imageNamed:@"titleNew.png"];
    [self.view addSubview:imageView];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleNew.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"帮  助"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
}



-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    if(indexPath.section==0)
    {
        //cell.imageView.image=[UIImage imageNamed:@""]
        cell.textLabel.text=@"客服电话";
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (indexPath.section==1)
    {
        cell.textLabel.text=@"软件版本";
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
    }else if (indexPath.section==2)
    {
        cell.textLabel.text=@"资质证书";
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
    }else
    {
        cell.textLabel.text=@"钱包简介";
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return  cell;
    
        
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        [self performSegueWithIdentifier:@"helpPhoneSegue" sender:self];
    }
    
    if(indexPath.section==1)
    {
         [self performSegueWithIdentifier:@"softwarVersionSegue" sender:self];
    }
    
    if(indexPath.section==2)
    {
        [self performSegueWithIdentifier:@"bookSegue" sender:self];
    }
    if (indexPath.section==3) {
        
        [self performSegueWithIdentifier:@"accountSegue" sender:self];
    }

}

@end
