//
//  FateListViewController.m
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-2.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "FateListViewController.h"
#import "FateTableViewCell.h"

@interface FateListViewController ()

@property (nonatomic,strong) FateListDO *fateListDO;


@end

@implementation FateListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"费率列表"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
}





#pragma mark - tableViewDelegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"self.temArr.count--%lu",(unsigned long)self.temArr.count);
    return self.temArr.count;
   
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     FateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    _fateListDO=[self.temArr objectAtIndex:indexPath.row];
    
//    if (indexPath.row==0) {
//        //[cell.imageView removeFromSuperview];
//        cell.imageView.image=[UIImage imageNamed:@"checkbutton"];
//    }
    
    NSLog(@"_fateListDO.feeRate--%@",_fateListDO.feeRate);
     NSLog(@"_fateListDO.price--%@",_fateListDO.price);
    cell.fateLabel.text=[NSString stringWithFormat:@"费率：%@%%",_fateListDO.feeRate];
    
    float money=[_fateListDO.price integerValue]/100.f;
    
    cell.moneyLabel.text=[NSString stringWithFormat:@"%.2f元",money];
    
    return cell;
}






-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    _fateListDO=[self.temArr objectAtIndex:indexPath.row];
    
    float money = [_fateListDO.price integerValue]/100.f;
    
    NSString *priceStr = [NSString stringWithFormat:@"%.2f元",money ];
    
    NSLog(@"priceStr----%@",priceStr);
//    if (indexPath.row==0) {
//        return;
//    }
//    else{

    self.alertView=[[UIAlertView alloc] initWithTitle:@"费率升级" message:priceStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    UITextField * txt = [[UITextField alloc] init];
    txt.backgroundColor = [UIColor whiteColor];
    txt.frame = CGRectMake(self.alertView.center.x+65,self.alertView.center.y, 150,23);
    self.alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;//看这里。。可以这样用
    [self.alertView textFieldAtIndex:0].keyboardType =UIKeyboardTypeNumberPad;
    [self.alertView textFieldAtIndex:0].placeholder=@"请输入支付密码";
    [self.alertView textFieldAtIndex:0].delegate = self;
    [self.alertView addSubview:txt];
    [self.alertView show];
//    }
    
    
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        
        
        NSString *payPassword=[alertView textFieldAtIndex:0].text;
        [UIComponentService showHudWithStatus:kPleaseWait];
     
        [self performSelector:@selector(buyFateRequest:andPayPassword:) withObject:_fateListDO.feeRateNO withObject:payPassword];
    }
}


-(void)buyFateRequest:(NSString *) feedID andPayPassword:(NSString *)payPassword
{
    BuyFateDO *buyFateDO=[[BuyFateDO alloc] init];
    buyFateDO.trancode=kTrancode_FateBuy;
    buyFateDO.delegate=self;
    buyFateDO.phoneNumber=[User shareUser].phoneNumber;
    buyFateDO.feedID=feedID;
    buyFateDO.payPassword=payPassword ;
    
    
    [buyFateDO buyFateRequest];
    
}




#pragma mark-delegate

-(void)fateListInquaryFieldWithMessage:(NSString *)message
{
    [UIComponentService showFailHudWithStatus:message];
}


-(void)fateListInquarySuccessWithMessage:(NSString *)message
{
    [UIComponentService showSuccessHudWithStatus:message];
}




-(void)buyFateSuccessWithMessage:(NSString *)message
{
    [UIComponentService showSuccessHudWithStatus:@"费率升级成功"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)buyFateFieldWithMessage:(NSString *)message
{
    [UIComponentService showFailHudWithStatus:message];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];

        
    if ([self.alertView textFieldAtIndex:0]  == textField)
    {
        if ([toBeString length] > 6) {
            textField.text = [toBeString substringToIndex:6];
            return NO;
        }
    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
