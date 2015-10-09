//
//  ChooseBankViewController.m
//  BusinessPay
//
//  Created by SHANGYINTONG on 15/4/24.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "ChooseBankViewController.h"
#import "AnotherPayViewController.h"
#import "YiBaoChannelViewController.h"


@interface ChooseBankViewController ()
{
    OrderCreateDO *_orderCreateDO;
    BOOL _isCreditCard;                      //判断是否为信用卡
}

@property (nonatomic,assign) NSInteger buttonIndex;

@property (nonatomic,strong)  UIImageView *imageViewLeft;
@property (nonatomic,strong)  UIImageView *imageViewRight;
@property (nonatomic,strong)  UIImageView *cellImageView;

@property (nonatomic,strong)  UITableView *tableView;

@property (nonatomic,strong)  UIAlertView *payChannelAlertView;     //选择支付通道弹出框
@property (nonatomic,strong)  UIAlertView *bankNameAlertView;       //选择银行弹出框
@property (nonatomic,strong)  UITableView *downTableView;


@property (nonatomic,strong) UILabel *payTrannelLabel;
@property (nonatomic,strong) UILabel *bankLabel;


@property (nonatomic,strong) NSArray *imageArr;
@property (nonatomic,strong) NSArray *bankNameArr;
@property (nonatomic,strong) NSArray *payChannelArr;

@property (nonatomic,strong) UIView *myView;


@property (nonatomic,strong) NSString *cardWay;
//@property (nonatomic,strong) NSString *

@property (nonatomic,assign) float cellContentViewHeight;




@end

@implementation ChooseBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"充  值"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    _isCreditCard=YES;
    
    self.imageViewLeft=[[UIImageView alloc] initWithFrame:CGRectMake(8, 4, (kSCREEN_WIDTH-16)/2, 51*kSCREEN_HEIGHT/600.f)];
    self.imageViewRight=[[UIImageView alloc] initWithFrame:CGRectMake(self.imageViewLeft.frame.origin.x+self.imageViewLeft.frame.size.width, 4, self.imageViewLeft.frame.size.width, 51*kSCREEN_HEIGHT/600.f)];
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, self.imageViewLeft.frame.size.height+self.imageViewLeft.frame.origin.y+4, kSCREEN_WIDTH, 500*kSCREEN_HEIGHT/600.f)];
    
    self.imageViewLeft.image=[UIImage imageNamed:@"creditCardPress.png"];
    self.imageViewRight.image=[UIImage imageNamed:@"debitCard.png"];
    
    self.cellImageView=[[UIImageView alloc] init];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    
    UITapGestureRecognizer *tapImageLeftGes=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageLeft)];
    UITapGestureRecognizer *tapImageRightGes=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageRight)];
    
    [self.imageViewLeft setUserInteractionEnabled:YES];
    [self.imageViewRight setUserInteractionEnabled:YES];
    
    [self.imageViewLeft addGestureRecognizer:tapImageLeftGes];
    [self.imageViewRight addGestureRecognizer:tapImageRightGes];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.imageViewLeft];
    [self.view addSubview:self.imageViewRight];
    [self.view addSubview:self.tableView];
    
    
    
    self.imageArr=[NSArray arrayWithObjects:@"ps_abc.png",@"ps_bjb.png",@"ps_boc.png",@"ps_ccb.png",@"ps_cebb.png",@"ps_cib.png",@"ps_citic.png",@"ps_cmb.png",@"ps_cmbc.png",@"ps_gdb.png",@"ps_hxb.png",@"ps_icbc.png",@"ps_psbc.png",@"ps_spa.png",@"ps_spdb.png",@"ps_spa.png",@"ps_bsb.png",@"ps_sh.png",nil];
    
    self.bankNameArr=[NSArray arrayWithObjects:@"农业银行",@"北京银行",@"中国银行",@"建设银行",@"光大银行",@"兴业银行",@"中信银行",@"招商银行",@"民生银行",@"广东发展银行",@"华夏银行",@"工商银行",@"邮政储蓄银行",@"平安银行",@"浦东发展银行",@"深圳发展银行",@"包商银行",@"上海银行", nil];
    
   // if(_isCreditCard){
        self.payChannelArr=[NSArray arrayWithObjects:@"易宝支付", nil];

    //}else
    //{
        //self.payChannelArr=[NSArray arrayWithObjects:@"易宝支付", nil];
    //}
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"yibaoSegue"]) {
        YiBaoChannelViewController *yibaoChannelVC=(YiBaoChannelViewController *)segue.destinationViewController;
        yibaoChannelVC.index=self.buttonIndex;
        yibaoChannelVC.money=self.money;
        yibaoChannelVC.cardWay=self.cardWay;
        
    }
    if ([segue.identifier isEqualToString:@"pushToAnotherSegue"]) {
        AnotherPayViewController * anotherPayVC =(AnotherPayViewController *)segue.destinationViewController;
        anotherPayVC.link=_orderCreateDO.reUrl;
    }
}

-(void) tapImageLeft
{
    self.imageViewLeft.image=[UIImage imageNamed:@"creditCardPress.png"];
    self.imageViewRight.image=[UIImage imageNamed:@"debitCard.png"];
    self.payTrannelLabel.text=@"请选择支付通道";
    _isCreditCard=YES;
    //[self.tableView reloadData];
    
}

-(void) tapImageRight
{
    self.imageViewLeft.image=[UIImage imageNamed:@"creditCard.png"];
    self.imageViewRight.image=[UIImage imageNamed:@"debitCardPress.png"];
    self.payTrannelLabel.text=@"请选择支付通道";
    _isCreditCard=NO;
    //[self.tableView reloadData];
    
    
    
}

#pragma mark - tableView datasourse


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (_isCreditCard) {
        if (tableView==self.tableView) {
            return 2;
        }else if(tableView==self.downTableView)
        {
            return self.bankNameArr.count;
        }
        
    }else
    {
        return 1;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    NSString *identity=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identity];
    if(!cell)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identity];
    }
    if(tableView==self.tableView){
        if(indexPath.row==0)
        {
            self.payTrannelLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, cell.contentView.frame.origin.y, 200, cell.contentView.frame.size.height)];
            [cell.contentView addSubview:self.payTrannelLabel];
            self.payTrannelLabel.text=@"请选择支付通道";
            cell.detailTextLabel.text=[NSString stringWithFormat:@"%.2f元",[self.money floatValue]];
         }else if (indexPath.row==1)
         {
            
            self.bankLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, cell.contentView.frame.origin.y, 200, cell.contentView.frame.size.height)];
             self.cellContentViewHeight=self.bankLabel.frame.size.height;
            self.bankLabel.text=@"选择银行";
            [cell.contentView addSubview:self.bankLabel];
         }
      }else if (tableView==self.downTableView)
      {
          cell.imageView.image=[UIImage imageNamed:[self.imageArr objectAtIndex:indexPath.row]];
          cell.textLabel.text=[self.bankNameArr objectAtIndex:indexPath.row];
      }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}



#pragma  mark - tableViewDleegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_isCreditCard) {
        if(tableView==self.tableView){
            if (indexPath.row==0) {
                
                self.payChannelAlertView=[[UIAlertView alloc] initWithTitle:@"请选择支付通道" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"易宝支付",nil];
                
                [self.payChannelAlertView show];
                
            }else
            {
                self.downTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, self.tableView.frame.origin.y+self.cellContentViewHeight*2, kSCREEN_WIDTH,360*kSCREEN_HEIGHT/600.f)];
                self.downTableView.delegate=self;
                self.downTableView.dataSource=self;
                [self.view addSubview:self.downTableView];
                
               
            }
            
        }
        else if (tableView==self.downTableView)
        {
            //self.bankLabel=[self.bankNameArr objectAtIndex:indexPath.row];
            self.bankLabel.text=[self.bankNameArr objectAtIndex:indexPath.row];
            [self.downTableView removeFromSuperview];
            if ([self.payTrannelLabel.text isEqualToString:@"请选择支付通道"]) {
                [self showWarmingWithMessage:@"请选择支付通道"];
                return;
            }
            if ([self.payTrannelLabel.text isEqualToString:@"山东网上有名"]) {
                     self.cardWay=@"1";
                [UIComponentService showHudWithStatus:kPleaseWait];
                [self performSelector:@selector(orderRequest) withObject:nil afterDelay:kDelayTime];
            
            }else
            {
                
                    self.buttonIndex=indexPath.row;
                    self.cardWay=@"3";
                    [self performSegueWithIdentifier:@"yibaoSegue" sender:self];
                            
            }
            
            
        }
    }
    else
    {
        if (indexPath.row==0) {
            self.payChannelAlertView=[[UIAlertView alloc] initWithTitle:@"请选择支付通道" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"易宝支付", nil];
            
            [self.payChannelAlertView show];
        }else
        {
            return;
        }
        
    }
    
    
    
    
}



#pragma  mark - alertView Delegate


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView==self.payChannelAlertView) {
        self.payTrannelLabel.text=[self.payChannelArr objectAtIndex:buttonIndex];
    }
//    else
//    {
//        self.bankLabel.text=[self.bankNameArr objectAtIndex:buttonIndex];
//        
//        if (_isCreditCard) {
//            if ([self.payTrannelLabel.text isEqualToString:@"请选择支付通道"]) {
//                [self showWarmingWithMessage:@"请选择支付通道"];
//                return;
//            }
//            if ([self.payTrannelLabel.text isEqualToString:@"山东网上有名"]) {
//                self.cardWay=@"01";
//                [UIComponentService showHudWithStatus:kPleaseWait];
//                [self performSelector:@selector(orderRequest) withObject:nil afterDelay:kDelayTime];
//                
//            }else
//            {
//                self.buttonIndex=buttonIndex;
//                self.cardWay=@"3";
//                [self performSegueWithIdentifier:@"yibaoSegue" sender:self];
//                
//            }
//        }else
//        {
//            self.cardWay=@"2";
//        }
//
    
}




- (void)orderRequest
{
    
    
    _orderCreateDO =[[OrderCreateDO alloc] init];
    _orderCreateDO.trancode       =kTrancode_OrderCreate;
    _orderCreateDO.phoneNumber    =[User shareUser].phoneNumber;
    //orderCreateDO.
    _orderCreateDO.payType        = @"0302";
    _orderCreateDO.commodityPrice = [NSString stringWithFormat:@"%d",(int)([self.money doubleValue]*100.f)];
    
    _orderCreateDO.commddityName   = @"付款";
    _orderCreateDO.UrlType         = @"1";
    _orderCreateDO.merType         = @"02";
    
    //orderCreateDO.commodityPrice   = self.moneyTextField.text;
    //    orderPayDO.quantity         = @"1";
    //    orderPayDO.billingCycle     = @"1";
    //_orderCreateDO.termno           = [User shareUser].termno;
    _orderCreateDO.delegate         = self;
    
    
    [_orderCreateDO submitOrderCreateRequest];
    
    
    
    //NSLog(@"订单号=%@",_orderCreateDO.merchantNO);
}


-(void)orderCreateSuccessWithMessage:(NSString *)message andMerchantId:(NSString *)merchantID andMerchantDate:(NSString *)merchantDate{
    [UIComponentService showSuccessHudWithStatus:@"请付款"];
    [self performSegueWithIdentifier:@"pushToAnotherSegue" sender:self];
    
}
-(void)orderCreateFailWithMessage:(NSString *)message
{
    
    [UIComponentService showFailHudWithStatus:message];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
