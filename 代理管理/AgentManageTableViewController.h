//
//  AgentManageTableViewController.h
//  BusinessPay
//
//  Created by zm on 29/4/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivationCodeTransfer.h"
#import "childAgentQuery.h"
#import "FateChange.h"
#import "ActivationCodeTransfer.h"
#import "ActivationCodeManagement.h"
#import "IQKeyboardManager.h"
#import "UIView+IQKeyboardToolbar.h"

@interface AgentManageTableViewController : UITableViewController<ActivationCodeTransferDelegate,FateChangeDelegate,UITextFieldDelegate,ActivationCodeManagementDelegate>{
    
    NSInteger   selectedTextFieldTag;
    int  number ;

}

@property (nonatomic,assign) NSInteger fateNumber;

@property (nonatomic,strong) NSMutableArray *AgentTemArr;

@property(strong, nonatomic)childAgentQuery *child;

@property(nonatomic,strong) UIAlertView *fateAlert;

@property(nonatomic,strong)NSString *fateStr;

@property(nonatomic,strong) UIAlertView *suerAlertView;

@property(nonatomic,strong) UIAlertView *jihuomaNumView;

@property(nonatomic,strong) UIAlertView *jihuomachenggongView;  //激活码划拨成功提示框

@property(nonatomic,strong) UITextField *jihuomaNumfield;

@property(nonatomic,strong) UIAlertView *jihuomaPassWordView;

@property(nonatomic,strong) UITextField *jihuomaPassWordfield;

@property(nonatomic,strong)NSString *childAgentNum;  //目标代理商编号

@property(nonatomic,strong)NSString *isfromjihuomaview;

@property(nonatomic,strong)NSString *jihuomahuaboNum;  //需要划拨的激活码数量

@property(nonatomic,strong)NSString *payPassWordStr;

@property(nonatomic,strong)NSString *codehuaboNum; //最多可划拨的激活码数量

@property(strong, nonatomic)NSMutableArray *fateAlertArr;





@end
