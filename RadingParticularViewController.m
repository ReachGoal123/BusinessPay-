//
//  RadingParticularViewController.m
//  BusinessPay
//
//  Created by SHANGYINTONG on 15-4-8.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "RadingParticularViewController.h"


@interface RadingParticularViewController()

@property (weak,nonatomic) IBOutlet UIImageView *ImageView;

//@property (weak, nonatomic) IBOutlet UIImageView *secondImageVIew;
//@property (weak,nonatomic) IBOutlet UIImageView *thirdImageView;
//@property (weak,nonatomic) IBOutlet UIImageView *fourthImageView;

@property (weak,nonatomic) IBOutlet UIView *secondLine;
@property (weak,nonatomic) IBOutlet UIView *thirdLine;

@property (weak,nonatomic) IBOutlet UILabel *statusLabel;
@property (weak,nonatomic) IBOutlet UILabel *titleLabel;
@property (weak,nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak,nonatomic) IBOutlet UILabel *moneyLeftLabel;
@property (weak,nonatomic) IBOutlet UILabel *actMoneyLabel;
@property (weak,nonatomic) IBOutlet UILabel *feeLabel;
@property (weak,nonatomic) IBOutlet UILabel *nameLabel;
@property (weak,nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak,nonatomic) IBOutlet UILabel *styleLabel;
@property (weak,nonatomic) IBOutlet UILabel *timeLabel;
@property (weak,nonatomic) IBOutlet UILabel *tranNumberLabel;
@property (weak,nonatomic) IBOutlet UILabel *accountLabel;

@property (weak,nonatomic) IBOutlet UILabel *styleTitleLabel;

@property (weak,nonatomic) IBOutlet UILabel *timeTitleLabel;
@property (weak,nonatomic) IBOutlet UILabel *tranTitleLabel;

@end

@implementation RadingParticularViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(radingParticularsRequest) withObject:nil afterDelay:kDelayTime];
    
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"交易详情"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
}


-(void)radingParticularsRequest
{
    RadingParticularsDO *radingParticularDo=[[RadingParticularsDO alloc] init];
    radingParticularDo.trancode=@"701162";
    radingParticularDo.delegate=self;
    radingParticularDo.alogNO=self.algno;
    
    
    [radingParticularDo radingRequest];
    
    
}



#pragma mark - radingDelegate


-(void)radingParticularsSuccessWithMessage:(NSString *)message withRadingPar:(RadingParticularsDO *)radingParticularsDO
{
    
    
    [UIComponentService showSuccessHudWithStatus:message];
    float txtMoney=[radingParticularsDO.txtAmt floatValue]/100.f;
    float feeMoney=[radingParticularsDO.feeAmt floatValue]/100.f;
    float totalMoney=txtMoney+feeMoney;
    
    
    
    if([radingParticularsDO.orderType isEqualToString:@"0"])
    {
        //消费转入
        if([radingParticularsDO.orderStype isEqualToString:@"01"])
        {
            self.titleLabel.text=@"充    值";
            //[self.thirdImageView setHidden:YES];
            
            [self.nameLabel setHidden:YES];
            [self.phoneNumberLabel setHidden:YES];
            [self.accountLabel setHidden:YES];
            [self.thirdLine setHidden:YES];
//            CGFloat y = self.secondLine.frame.size.height + self.secondLine.frame.origin.y;
//            //[self.thirdImageView setFrame:CGRectMake(0, y, self.view.frame.size.width, 1)];
//            // NSLog(@"thirdImageView:(%f,%f)",self.thirdImageView.frame.origin.y,self.thirdImageView.frame.size.width);
//            //[self.fourthImageView setFrame:CGRectMake(0, y-10 , self.view.frame.size.width , 200)];
//            
//            [self.styleTitleLabel setFrame:CGRectMake(18, y+10, 88, 21)];
//            [self.styleLabel setFrame:CGRectMake(133, y+10, 88, 21)];
//            [self.timeTitleLabel setFrame:CGRectMake(18, y+85, 88, 21)];
//            [self.timeLabel setFrame:CGRectMake(133, y+85, 155, 21)];
//            [self.tranTitleLabel setFrame:CGRectMake(18, y+150, 88, 21)];
//            [self.tranNumberLabel setFrame:CGRectMake(133, y+150, 276, 21)];

            self.moneyLabel.text=[NSString stringWithFormat:@"%.2lf 元",totalMoney];
          
        }
        //虚拟账户转入
        else if ([radingParticularsDO.orderStype isEqualToString:@"02"])
        {
            self.titleLabel.text=@"转入金额";
            self.moneyLabel.text=[NSString stringWithFormat:@"%.2lf 元",totalMoney];
            self.nameLabel.text=radingParticularsDO.outName;
            NSString *phoneNumberFirst=[radingParticularsDO.outActid substringToIndex:3];
            NSString *phoneNumberLast=[radingParticularsDO.outActid substringFromIndex:radingParticularsDO.outActid.length-4];
            
            self.phoneNumberLabel.text  = [NSString stringWithFormat:@"%@****%@",phoneNumberFirst,phoneNumberLast];

            
        }
        //现金充值
        else if ([radingParticularsDO.orderStype isEqualToString:@"03"])
        {
            //[self.thirdImageView removeFromSuperview];
            self.titleLabel.text=@"充    值";
            self.moneyLabel.text=[NSString stringWithFormat:@"%.2lf 元",totalMoney];
            //[self.thirdImageView setHidden:YES];
            [self.nameLabel setHidden:YES];
            [self.phoneNumberLabel setHidden:YES];
            [self.accountLabel setHidden:YES];
//            CGFloat y = self.secondLine.frame.size.height + self.secondLine.frame.origin.y;
//            //[self.thirdImageView setFrame:CGRectMake(0, y, self.view.frame.size.width, 1)];
//            // NSLog(@"thirdImageView:(%f,%f)",self.thirdImageView.frame.origin.y,self.thirdImageView.frame.size.width);
//            //[self.fourthImageView setFrame:CGRectMake(0, y-10 , self.view.frame.size.width , 200)];
//           // self.titleLabel.text=@"收    益";
//            [self.thirdLine setHidden:YES];
//            
            self.moneyLabel.text=[NSString stringWithFormat:@"%.2lf 元",totalMoney];
//            [self.styleTitleLabel setFrame:CGRectMake(18, y+10, 88, 21)];
//            [self.styleLabel setFrame:CGRectMake(133, y+10, 88, 21)];
//            [self.timeTitleLabel setFrame:CGRectMake(18, y+85, 88, 21)];
//            [self.timeLabel setFrame:CGRectMake(133, y+85, 155, 21)];
//            [self.tranTitleLabel setFrame:CGRectMake(18, y+150, 88, 21)];
//            [self.tranNumberLabel setFrame:CGRectMake(133, y+150, 276, 21)];
            self.styleLabel.text=@"信用卡充值";

        }else
        {
            //利息收益转入
            //[self.thirdImageView setHidden:YES];
            [self.thirdLine removeFromSuperview];
            [self.nameLabel setHidden:YES];
            [self.phoneNumberLabel setHidden:YES];
            [self.accountLabel setHidden:YES];
//            CGFloat y = self.secondLine.frame.size.height + self.secondLine.frame.origin.y;
//           
//            NSLog(@"secondFrame:(%f,%f)",self.secondLine.frame.origin.y,self.secondLine.frame.size.height);
            self.titleLabel.text=@"收    益";
//            self.moneyLabel.text=[NSString stringWithFormat:@"%.2lf 元",totalMoney];
//            [self.styleTitleLabel setFrame:CGRectMake(18, y, 88, 21)];
//            NSLog(@"titley=%f",self.styleLabel.frame.origin.y);
//            [self.styleLabel setFrame:CGRectMake(133, y+10, 88, 21)];
//            [self.timeTitleLabel setFrame:CGRectMake(18, y+85, 88, 21)];
//            [self.timeLabel setFrame:CGRectMake(133, y+85, 155, 21)];
//            [self.tranTitleLabel setFrame:CGRectMake(18, y+150, 88, 21)];
//            [self.tranNumberLabel setFrame:CGRectMake(133, y+150, 276, 21)];
            
        }

    }else if([radingParticularsDO.orderType isEqualToString:@"2"])
    {
        //转出
        if ([radingParticularsDO.orderStype isEqualToString:@"22"]||[radingParticularsDO.orderStype isEqualToString:@"23"])//转账到其他银行卡
        {
            self.titleLabel.text =@"转   账";
            
            self.moneyLabel.text=[NSString stringWithFormat:@"%.2lf 元",totalMoney];
            if ([radingParticularsDO.pactNam isEqualToString:nil]) {
                self.nameLabel.text=@"未知";
                self.phoneNumberLabel.text=@"***";
            }else{
            
            self.nameLabel.text=radingParticularsDO.pactNam;
            NSString *phoneNumberFirst=[radingParticularsDO.pactActid substringToIndex:3];
            NSString *phoneNumberLast=[radingParticularsDO.pactActid substringFromIndex:radingParticularsDO.pactActid.length-4];
            
            self.phoneNumberLabel.text  = [NSString stringWithFormat:@"%@****%@",phoneNumberFirst,phoneNumberLast];
            }
            self.styleLabel.text=@"转账";
            
            
        }else if([radingParticularsDO.orderStype isEqualToString:@"24"])//手机充值
        {
            self.titleLabel.text=@"手机充值";
            self.accountLabel.text=@"充值号码";
            
            self.moneyLabel.text=[NSString stringWithFormat:@"%.2lf 元",totalMoney];
            NSString *phoneNumberFirst=[radingParticularsDO.actid substringToIndex:3];
            NSString *phoneNumberLast=[radingParticularsDO.actid substringFromIndex:radingParticularsDO.actid.length-4];
            
            
            self.nameLabel.text  = [NSString stringWithFormat:@"%@****%@",phoneNumberFirst,phoneNumberLast];
            //self.nameLabel.text=radingParticularsDO.targActid;
            [self.phoneNumberLabel setHidden:YES];
            
            
        }else if([radingParticularsDO.orderStype isEqualToString:@"25"])
        {
            self.titleLabel.text=@"服务购买";
            self.moneyLabel.text=[NSString stringWithFormat:@"%.2lf 元",totalMoney];
            //[self.thirdImageView setHidden:YES];
            [self.thirdLine setHidden:YES];
            [self.nameLabel setHidden:YES];
            [self.phoneNumberLabel setHidden:YES];
            [self.accountLabel setHidden:YES];
//            CGFloat y = self.secondLine.frame.size.height + self.secondLine.frame.origin.y;
//            //[self.fourthImageView setFrame:CGRectMake(0, y-10 , self.view.frame.size.width , 150)];
//            
            [self.styleTitleLabel setHidden:YES];
            [self.styleLabel setHidden:YES];
//
//            [self.timeTitleLabel setFrame:CGRectMake(18, y+10, 88, 21)];
//            [self.timeLabel setFrame:CGRectMake(133, y+10, 155, 21)];
//            [self.tranTitleLabel setFrame:CGRectMake(18, y+100, 88, 21)];
//            [self.tranNumberLabel setFrame:CGRectMake(133, y+100, 276, 21)];

        }else if([radingParticularsDO.orderStype isEqualToString:@"27"]) {
            
            self.titleLabel.text=@"信用卡还款";
            self.actMoneyLabel.text=radingParticularsDO.bankName;
            self.moneyLabel.text=[NSString stringWithFormat:@"%.2lf 元",totalMoney];
            
            self.accountLabel.text=@"账户信息";
            
            NSString *number=[radingParticularsDO.cardNO substringWithRange:NSMakeRange(radingParticularsDO.cardNO.length-4,4)];
            self.nameLabel.text=[NSString stringWithFormat:@"尾号:%@",number];
            self.phoneNumberLabel.text=radingParticularsDO.cardName;
            
        
        }else if([radingParticularsDO.orderStype isEqualToString:@"21"])//提现到绑定银行卡
        {
            self.titleLabel.text=@"提    现";
            self.moneyLeftLabel.text=[NSString stringWithFormat:@"%.2lf 元",totalMoney];
            self.actMoneyLabel.text=[NSString stringWithFormat:@"到账金额：%.2lf元",txtMoney];
            self.feeLabel.text=[NSString stringWithFormat:@"手 续 费：%.2lf元",feeMoney];
            
            //[self.thirdImageView setHidden:YES];
            [self.thirdLine setHidden:YES];
            [self.nameLabel setHidden:YES];
            [self.phoneNumberLabel setHidden:YES];
            [self.accountLabel setHidden:YES];
//            CGFloat y = self.secondLine.frame.size.height + self.secondLine.frame.origin.y;
//           // [self.fourthImageView setFrame:CGRectMake(0, y-10 , self.view.frame.size.width , 150)];
//            
//            [self.styleTitleLabel setHidden:YES];
//            [self.styleLabel setHidden:YES];
//            
//            [self.timeTitleLabel setFrame:CGRectMake(18, y+10, 88, 21)];
//            [self.timeLabel setFrame:CGRectMake(133, y+10, 155, 21)];
//            [self.tranTitleLabel setFrame:CGRectMake(18, y+100, 88, 21)];
//            [self.tranNumberLabel setFrame:CGRectMake(133, y+100, 276, 21)];

            
        }else
        {
            self.titleLabel.text=@"闪电提现";
            self.moneyLeftLabel.text=[NSString stringWithFormat:@"%.2lf 元",totalMoney];
            self.actMoneyLabel.text=[NSString stringWithFormat:@"到账金额：%.2lf元",txtMoney];
            self.feeLabel.text=[NSString stringWithFormat:@"手 续 费：%.2lf元",feeMoney];
            
            //[self.thirdImageView setHidden:YES];
            [self.thirdLine setHidden:YES];
            [self.nameLabel setHidden:YES];
            [self.phoneNumberLabel setHidden:YES];
            [self.accountLabel setHidden:YES];

//            CGFloat y = self.secondLine.frame.size.height + self.secondLine.frame.origin.y;
//            //[self.thirdImageView setFrame:CGRectMake(0, y, self.view.frame.size.width, 1)];
//            // NSLog(@"thirdImageView:(%f,%f)",self.thirdImageView.frame.origin.y,self.thirdImageView.frame.size.width);
//           // [self.fourthImageView setFrame:CGRectMake(0, y-10 , self.view.frame.size.width , 200)];
//            NSLog(@"secondLine:(%f,%f)",self.secondLine.frame.origin.y,self.secondLine.frame.size.height);
//            [self.styleTitleLabel setFrame:CGRectMake(18, y+10, 88, 21)];
//            [self.styleLabel setFrame:CGRectMake(133, y+10, 88, 21)];
//            [self.timeTitleLabel setFrame:CGRectMake(18, y+85, 88, 21)];
//            [self.timeLabel setFrame:CGRectMake(133, y+85, 155, 21)];
//            [self.tranTitleLabel setFrame:CGRectMake(18, y+150, 88, 21)];
//            [self.tranNumberLabel setFrame:CGRectMake(133, y+150, 276, 21)];
        }
    }
    
    if([radingParticularsDO.orderStutas isEqualToString:@"0"])
    {
        self.statusLabel.text         = @"失败";
        self.ImageView.image=[UIImage imageNamed:@"failed.png"];
    }else if([radingParticularsDO.orderStutas isEqualToString:@"1"])
    {
        self.statusLabel.text        = @"成功";
        self.ImageView.image=[UIImage imageNamed:@"withDrawSuccess.png"];
    }else{
        self.statusLabel.text        = @"处理中";
    }
    
    NSString *date =[radingParticularsDO.orderTime substringWithRange:NSMakeRange(6, 2)];
    
    if ([date isEqualToString:@"00"]) {
        date=@"01";
    }

    
    
   self.timeLabel.text  = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",[radingParticularsDO.orderTime substringWithRange:NSMakeRange(0, 4)],[radingParticularsDO.orderTime substringWithRange:NSMakeRange(4, 2)],date,[radingParticularsDO.orderTime substringWithRange:NSMakeRange(8, 2)],[radingParticularsDO.orderTime substringWithRange:NSMakeRange(10, 2)],[radingParticularsDO.orderTime substringWithRange:NSMakeRange(12, 2)]];
    
    self.tranNumberLabel.text=self.algno;
    
    
}


-(void)radingParticularsFeildWithMessage:(NSString *)message
{
    [UIComponentService showFailHudWithStatus:message];
    
}






@end