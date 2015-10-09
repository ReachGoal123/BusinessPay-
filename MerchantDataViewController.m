//
//  MerchantDataViewController.m
//  BusinessPay
//
//  Created by Tears on 14-4-16.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "MerchantDataViewController.h"

@interface MerchantDataViewController ()

@property (weak, nonatomic) IBOutlet UILabel *merchantIDLab;
@property (weak, nonatomic) IBOutlet UILabel *merchantNameLab;
@property (weak, nonatomic) IBOutlet UILabel *bankCardNumberLab;
@property (weak, nonatomic) IBOutlet UILabel *bankNameLab;
@property (weak, nonatomic) IBOutlet UILabel *IDCardIDLab;
@property (weak, nonatomic) IBOutlet UILabel *realNameStatusLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberIDLab;

@end

@implementation MerchantDataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundView = nil;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    
    [UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(merchantRequest) withObject:nil afterDelay:kDelayTime];
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"用户信息"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
}

- (void)merchantRequest
{
    MerchantDO * merchantDO = [[MerchantDO alloc] init];
    merchantDO.delegate = self;
    merchantDO.termType = kTermType;
    merchantDO.phoneNumber = [User shareUser].phoneNumber;
    merchantDO.trancode = kTrancode_MerchantData;
    [merchantDO merchantInformationInquiryRequest];
}

- (void)merchantInformationInquirySuccessWithMessage: (NSString *)message andMerchantDO:(MerchantDO *)merchantDO
{
    
    [UIComponentService showSuccessHudWithStatus:message];
    
    int status = [merchantDO.realNameStatus intValue];
    
    NSString *merchantFirstName;
    NSString *merchantLastName;

    if(merchantDO.merchantName.length==3)
    {
          merchantFirstName= [merchantDO.merchantName substringToIndex:merchantDO.merchantName.length-2];
          merchantLastName= [merchantDO.merchantName substringFromIndex:2];
        self.merchantNameLab.text   = [NSString stringWithFormat:@"%@*%@",merchantFirstName,merchantLastName];

    }else if (merchantDO.merchantName.length==4)
    {
        merchantFirstName=[merchantDO.merchantName substringToIndex:merchantDO.merchantName.length-3];
        merchantLastName=[merchantDO.merchantName substringFromIndex:3];
        self.merchantNameLab.text   = [NSString stringWithFormat:@"%@**%@",merchantFirstName,merchantLastName];
    }else if (merchantDO.merchantName.length==2)
    {
        merchantFirstName=[merchantDO.merchantName substringToIndex:merchantDO.merchantName.length-1];
        //merchantLastName=nil;
        self.merchantNameLab.text   = [NSString stringWithFormat:@"%@*",merchantFirstName];
    }
    
   
    
    if(status==VerificationStatusType_Passed)
    {
        
        NSString *bankCardFirstNumber=[merchantDO.bankCardNumber substringToIndex:7];
        NSString *bankCardlastNumber=[merchantDO.bankCardNumber substringWithRange:NSMakeRange(merchantDO.bankCardNumber.length-8, 4)];
    self.bankCardNumberLab.text = [NSString stringWithFormat:@"%@****%@****",bankCardFirstNumber,bankCardlastNumber];
        
        
        NSString *IDCardFirstNumber=[merchantDO.IDCard substringToIndex:5];
        
        NSString *IDCardLastNumber=[merchantDO.IDCard substringFromIndex:merchantDO.IDCard.length-4];
        self.IDCardIDLab.text       = [NSString stringWithFormat:@"%@*********%@",IDCardFirstNumber,IDCardLastNumber];
    }
        self.bankNameLab.text       = merchantDO.bankName;
    
    
    
    
    NSString *phoneNumberFirst=[merchantDO.phoneNumber substringToIndex:3];
    NSString *phoneNumberLast=[merchantDO.phoneNumber substringFromIndex:merchantDO.phoneNumber.length-4];
    
    self.phoneNumberIDLab.text  = [NSString stringWithFormat:@"%@****%@",phoneNumberFirst,phoneNumberLast];
    
    
    NSLog(@"%d",status);
    NSString * statusStr;
    switch (status) {
        case VerificationStatusType_Passed:
            statusStr = @"认证通过";
            break;
        case VerificationStatusType_Waitting:
            statusStr = @"待认证";
            break;
        case VerificationStatusType_UnPass:
            statusStr = @"认证不通过";
            break;
        case VerificationStatusType_BankPassOnly:
            statusStr = @"仅银行通过";
            break;
        case VerificationStatusType_IDCardPassOnly:
            statusStr = @"仅身份证认证通过";
            break;
        case VerificationStatusType_Disable:
            statusStr = @"未认证";
            break;
        case VerificationStatusType_Wait:
            statusStr = @"待认证";
            break;
        default:
            break;
    }
    self.realNameStatusLab.text = statusStr;
}

-(void)merchantBankInformationInquirySuccessWithMessage:(NSString *)message andMerchantDO:(MerchantDO *)merchantDO
{
    
}

- (void)merchantInformationInquiryFieldWithMessage: (NSString *)message
{
    [UIComponentService showFailHudWithStatus:message];
}

@end
