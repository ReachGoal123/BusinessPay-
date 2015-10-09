//
//  AgentInformationQuery.h
//  BusinessPay
//
//  Created by zm on 5/5/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol AgentInformationQueryDelegate;

@interface AgentInformationQuery : BaseModel

@property (nonatomic, assign) id <AgentInformationQueryDelegate> delegate;

@property (nonatomic, copy) NSString * trancode;

@property(strong, nonatomic)NSString *LoginPhoneNum;  //当前登录手机号

@property(nonatomic, strong)NSString *agentNumber;  //代理商编号

//@property(nonatomic,strong)NSString *numberHasUsed; //已使用数量
//
//@property(nonatomic,strong)NSString *currentYield; //当前收益
//
//@property(nonatomic,strong)NSString *totalYield;   //累计收益
//
//@property(nonatomic,strong)NSString *minimumRate;  //最小费率
//
//@property(nonatomic,strong)NSString *maxRate; //最大费率
//
//@property(nonatomic,strong)NSString *nocaragTeyp; //等级
//
//@property(nonatomic,strong)NSString *agentName; //商户名

@property(nonatomic,strong)NSString *responseMessage;

@property(nonatomic,strong)NSString *responseCode;

-(void)AgentInformationQueryRequest;

@end

@protocol AgentInformationQueryDelegate <NSObject>

- (void)AgentInformationQuerySuccessWithMessage: (NSString *)message;

- (void)AgentInformationQueryFildWithMessage: (NSString *)message;

@end
