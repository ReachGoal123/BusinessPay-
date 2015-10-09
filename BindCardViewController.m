//
//  BindCardViewController.m
//  BusinessPay
//
//  Created by SHANGYINTONG on 15/4/29.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BindCardViewController.h"
#import "YiBaoNextViewController.h"
#import "YiBaoChannelViewController.h"
#import "TakeBankCardPhotoViewController.h"

@interface BindCardViewController ()

@property (nonatomic,weak) IBOutlet UITableView *tableView;

//-(IBAction)<#selector#>:(id)sender

@property (nonatomic,strong) YiBaoPayChannelDO *yibaoPayChannelDO;
@property (nonatomic,strong) NSString *cardName;
@property (nonatomic,strong) NSString *cardNumber;

@property (nonatomic,assign) NSInteger integer;

@end

@implementation BindCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor=[UIColor colorWithWhite:0.95f alpha:0.95f];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"充  值"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    
   // self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(addCard)];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toYibaoNextSegue"]) {
        YiBaoNextViewController *yibaoNextVC=(YiBaoNextViewController *)segue.destinationViewController;
        yibaoNextVC.clsno=self.yibaoPayChannelDO.clslogNO;
        yibaoNextVC.name=self.cardName;
        yibaoNextVC.phoneNumber=self.cardTel;
    }
    if ([segue.identifier isEqualToString:@"pushToyibaoChannelSegue"]) {
        YiBaoChannelViewController *yibaoChanVC=(YiBaoChannelViewController *)segue.destinationViewController;
        yibaoChanVC.money=self.money;
        yibaoChanVC.name=self.cardName;
        yibaoChanVC.IDCard=self.cardNumber;
    }
    if ([segue.identifier isEqualToString:@"pushToUpLoadSegue"]) {
        TakeBankCardPhotoViewController *takePhotoVC=(TakeBankCardPhotoViewController *)segue.destinationViewController;
        takePhotoVC.money=self.money;
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.arr.count+1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSLog(@"%i",self.arr.count);
    
    BindCardDO *bindCardDO;
    NSString *identity=@"CELL";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identity forIndexPath:indexPath];
    
    
    if (indexPath.section!=self.arr.count) {
        bindCardDO=[self.arr objectAtIndex:indexPath.section];
    }
    if (self.arr.count==0) {
        cell.imageView.image=[UIImage imageNamed:@"Add.png"];
        cell.textLabel.text=@"添加信用卡";
        cell.detailTextLabel.text=nil;
    }else
    {
        if (indexPath.section==self.arr.count) {
            cell.imageView.image=[UIImage imageNamed:@"Add.png"];
            cell.textLabel.text=@"添加信用卡";
            cell.detailTextLabel.text=nil;
        
        }else
        {
            cell.textLabel.text=bindCardDO.issuer;
            
            
            //NSLog(@"")
            NSString *cardString=[bindCardDO.cardCode substringWithRange:NSMakeRange(bindCardDO.cardCode.length-4, 4)];
            cell.detailTextLabel.text=[NSString stringWithFormat:@"尾号:%@",cardString];
            if ([bindCardDO.ferID isEqualToString:@"ABCCREDIT"]) {
                cell.imageView.image=[UIImage imageNamed:@"ps_abc.png"];
            }else if([bindCardDO.ferID isEqualToString:@"BCCBCREDIT"])
            {
                cell.imageView.image=[UIImage imageNamed:@"ps_bjb.png"];
            }else if ([bindCardDO.ferID isEqualToString:@"BOCCREDIT"])
            {
                cell.imageView.image=[UIImage imageNamed:@"ps_boc.png"];
            }else if ([bindCardDO.ferID isEqualToString:@"CCBCREDIT"])
            {
                cell.imageView.image=[UIImage imageNamed:@"ps_ccb.png"];
            }else if ([bindCardDO.ferID isEqualToString:@"EVERBRIGHTCREDIT"])
            {
                cell.imageView.image=[UIImage imageNamed:@"ps_cebb.png"];
            }else if( [bindCardDO.ferID isEqualToString:@"CIBCREDIT"])
            {
                cell.imageView.image=[UIImage imageNamed:@"ps_cib.png"];
            }else if( [bindCardDO.ferID isEqualToString:@"ECITICCREDIT"])
            {
                cell.imageView.image=[UIImage imageNamed:@"ps_citic.png"];
            }else if( [bindCardDO.ferID isEqualToString:@"CMBCHINACREDIT"])
            {
                cell.imageView.image=[UIImage imageNamed:@"ps_cmb.png"];
            }else if( [bindCardDO.ferID isEqualToString:@"CMBCCREDIT"])
            {
                cell.imageView.image=[UIImage imageNamed:@"ps_cmbc.png"];
            }else if( [bindCardDO.ferID isEqualToString:@"GDBCREDIT"])
            {
                cell.imageView.image=[UIImage imageNamed:@"ps_gdb.png"];
            }else if( [bindCardDO.ferID isEqualToString:@"HXBCREDIT"])
            {
                cell.imageView.image=[UIImage imageNamed:@"ps_hxb.png"];
            }else if( [bindCardDO.ferID isEqualToString:@"ICBCCREDIT"])
            {
                cell.imageView.image=[UIImage imageNamed:@"ps_icbc.png"];
            }else if( [bindCardDO.ferID isEqualToString:@"PSBCCREDIT"])
            {
                cell.imageView.image=[UIImage imageNamed:@"ps_psbc.png"];
            }else if( [bindCardDO.ferID isEqualToString:@"PINGANCREDIT"])
            {
                cell.imageView.image=[UIImage imageNamed:@"ps_spa.png"];
            }else if( [bindCardDO.ferID isEqualToString:@"SPDBCREDIT"])
            {
                cell.imageView.image=[UIImage imageNamed:@"ps_spdb.png"];
            }
            else if( [bindCardDO.ferID isEqualToString:@"SDBCREDIT"])
            {
                cell.imageView.image=[UIImage imageNamed:@"ps_spa.png"];
            }else if( [bindCardDO.ferID isEqualToString:@"BSBCREDIT"])
            {
                cell.imageView.image=[UIImage imageNamed:@"ps_bsb.png"];
            }else if( [bindCardDO.ferID isEqualToString:@"BOSHCREDIT"])
            {
                cell.imageView.image=[UIImage imageNamed:@"ps_sh.png"];
            }

       }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    return cell;
    
}


#pragma mark - tableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BindCardDO *bindCardDO;
    
    if (indexPath.section!=self.arr.count) {
        bindCardDO=[self.arr objectAtIndex:indexPath.section];
    }

    
    if (self.arr.count==0) {
        if ([User shareUser].reChangeStutas==0) {
            [self performSegueWithIdentifier:@"pushToyibaoChannelSegue" sender:self];
        }else{
            [self performSegueWithIdentifier:@"pushToUpLoadSegue" sender:self];
        }
        
    }else
    {
        if (indexPath.section==self.arr.count) {
            [self performSegueWithIdentifier:@"pushToyibaoChannelSegue" sender:self];
        }
        else
        {
            self.cardName=bindCardDO.cardName;
            self.cardNumber=bindCardDO.cardNumber;
            self.cardTel=bindCardDO.cardTel;
            [UIComponentService showHudWithStatus:kPleaseWait];
            [self performSelector:@selector(yiBaoPayChannelRequestWithBindCardDO:) withObject:bindCardDO afterDelay:kDelayTime];
        }
    }
    
    
}

//-(void) addCard
//{
//    [self performSegueWithIdentifier:@"pushToyibaoChannelSegue" sender:self];
//}


//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;//默认没有编辑风格
//    if ([tableView isEqual:self.tableView]) {
//        result = UITableViewCellEditingStyleDelete;//设置编辑风格为删除风格
//    }
//    return result;
//}
//
//-(void)setEditing:(BOOL)editing animated:(BOOL)animated{//设置是否显示一个可编辑视图的视图控制器。
//    [super setEditing:editing animated:animated];
//    [self.tableView setEditing:editing animated:animated];//切换接收者的进入和退出编辑模式。
//}
//
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{//请求数据源提交的插入或删除指定行接收者。
//    if (editingStyle ==UITableViewCellEditingStyleDelete) {//如果编辑样式为删除样式
//        if (indexPath.row<[self.arr count]) {
//            //[self.arryOfRows removeObjectAtIndex:indexPath.row];//移除数据源的数据
//            //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];//移除tableView中的数据
//            UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles: nil];
//            [actionSheet showInView:self.view];
//            self.integer=indexPath.row;
//        }
//    }
//}

//-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
 //   if (buttonIndex==1) {
//        return;
 //   }else
 //   {
 //       [self.arr removeObjectAtIndex:self.integer];
//        [self.tableView reloadData];
 //   }
//}


-(void) yiBaoPayChannelRequestWithBindCardDO:(BindCardDO *)bindCardDO
{
    YiBaoPayChannelDO *yibaoChannelDO=[[YiBaoPayChannelDO alloc] init];
    
    yibaoChannelDO.trancode=kTrancode_YibaoPay;
    yibaoChannelDO.delegate=self;
    yibaoChannelDO.phoneNumber=[User shareUser].phoneNumber;
    yibaoChannelDO.merType=@"02";
    yibaoChannelDO.cardWay=@"3";    //易宝信用卡为 3，   易宝借记卡为 2  网上有名信用卡 1
    yibaoChannelDO.orderAmt=[NSString stringWithFormat:@"%d",(int)([self.money doubleValue]*100.f)];
    NSLog(@"money=%@",yibaoChannelDO.orderAmt);
    yibaoChannelDO.cardTel=bindCardDO.cardTel;
    yibaoChannelDO.cardType=bindCardDO.cardType;
    yibaoChannelDO.cardNumber=bindCardDO.cardNumber;
    yibaoChannelDO.cardName=bindCardDO.cardName;
    yibaoChannelDO.cardCode=bindCardDO.cardCode;
    self.cardName=bindCardDO.cardName;
    self.cardNumber=bindCardDO.cardNumber;
    
    yibaoChannelDO.ferID=bindCardDO.ferID;
    yibaoChannelDO.expireYear=bindCardDO.expireYear;
    yibaoChannelDO.expireMonth=bindCardDO.expireMonth;
    yibaoChannelDO.cvv=bindCardDO.cvv;
    yibaoChannelDO.issuer=bindCardDO.issuer;       //发卡行
    yibaoChannelDO.isBind=@"0";
    //yibaoChannelDO.issuer=self.bankName;
    [yibaoChannelDO payRequest];
}


#pragma mark -yibaoPayDelegate

-(void)payRequestWithSuccess:(NSString *)message andYibaoPay:(YiBaoPayChannelDO *)yibaoPayChannelDO
{
    [UIComponentService showSuccessHudWithStatus:message];
    self.yibaoPayChannelDO=yibaoPayChannelDO;
    
    
    [self performSegueWithIdentifier:@"toYibaoNextSegue" sender:self];
    
}

-(void)payRequestWithFail:(NSString *)message
{
    [UIComponentService showFailHudWithStatus:message];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end