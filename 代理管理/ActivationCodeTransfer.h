//
//  ActivationCodeTransfer.h
//  BusinessPay
//
//  Created by zm on 4/5/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol ActivationCodeTransferDelegate;

@interface ActivationCodeTransfer : BaseModel

@property (nonatomic, assign) id <ActivationCodeTransferDelegate> delegate;

@property (nonatomic, copy) NSString * trancode;

@property(strong, nonatomic)NSString *LoginPhoneNum;  //当前登录手机号

@property(strong, nonatomic)NSString *currentAgentNumber;  //当前代理商编号

@property(strong,nonatomic)NSString *targetAgentNum; //目标代理商编号

@property(strong, nonatomic)NSString *huoBoNumber;  //划拨数量

@property(strong, nonatomic)NSString *payPassWord;  //支付密码
@property(nonatomic,strong)NSString *responseCode;

@property(nonatomic,strong)NSString *responseMessage;


-(void)ActivationCodeTransferRequest;

@end


@protocol ActivationCodeTransferDelegate <NSObject>

- (void)ActivationCodeTransferSuccessWithMessage: (NSString *)message;

- (void)ActivationCodeTransferFildWithMessage: (NSString *)message;

@end