//
//  ActivCodeViewController.h
//  BusinessPay
//
//  Created by zm on 29/4/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseViewController.h"
#import "CreateActivationCode.h"
#import "ActivationCodeTransfer.h"
#import "CodeNotUserImformationQuery.h"
#import "childAgentQuery.h"
#import "CodeListTableViewController.h"
#import "ActivationCodeManagement.h"


@interface ActivCodeViewController : BaseViewController<CreateActivationCodeDelegate,ActivationCodeTransferDelegate,CodeNotUserImformationQueryDelegate,childAgentQueryDelegate,ActivationCodeManagementDelegate,UIActionSheetDelegate>

@property(weak, nonatomic)IBOutlet UIButton *createCode;  //激活码生产

@property(weak, nonatomic)IBOutlet UIButton *transferCode;  //激活码划拨

@property(strong,nonatomic)IBOutlet UILabel *yihuabo;

@property(strong,nonatomic)IBOutlet UILabel *yiJiHuoWeiShengC;

@property(strong,nonatomic)IBOutlet UILabel *weiShengCheng;

@property(strong,nonatomic)NSString *CodeNum; //激活码数量

@property(strong,nonatomic)NSString *payPassWord;  //支付密码

@property(strong,nonatomic)UITextField *payPassWordField;  //支付密码框

@property(nonatomic,strong) UIAlertView *codeNumAlert;

@property(nonatomic,strong) UIAlertView *payPassWordAlert;

@property(strong,nonatomic)UITextField *codenumber;

@property(strong,nonatomic)NSString *CodeNumStr; //输入的激活码数量

@property(nonatomic,strong) UIAlertView *codeNumAlert2;

@property(nonatomic,strong) UIAlertView *payPassWordAlert2;

@property(strong,nonatomic)NSString *huaBoPayPassWord; //划拨支付密码

@property(strong,nonatomic)UITextField *huoBoPayPassWord;

@property (nonatomic,strong) NSMutableArray *temArr;

@property (nonatomic,strong) NSMutableArray *temArrchild;

@property (nonatomic,strong) NSMutableArray *creatCodeNumber;

@property(nonatomic, strong)IBOutlet UIImageView *imageview;

@property(nonatomic,strong)UIAlertView *alert;

@property(nonatomic,strong)UIActivityIndicatorView *activityIndicator ;

@property(strong,nonatomic)NSString *isfromjihuomahuabo; //划拨支付密码
-(IBAction)createCodeAction:(id)sender;

-(IBAction)transferCodeAction:(id)sender;

@end
