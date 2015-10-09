//
//  UserUpgradeToAgent.h
//  BusinessPay
//
//  Created by zm on 4/5/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseModel.h"


@protocol UserToAgentDelegate;

@interface UserUpgradeToAgent : BaseModel


@property (nonatomic, assign) id <UserToAgentDelegate> delegate;

@property (nonatomic, copy) NSString * trancode;

@property(nonatomic, strong)NSString *toVerifiedNum;  //被验证号

@property(strong, nonatomic)NSString *LoginPhoneNum;  //当前登录手机号

@property(strong, nonatomic)NSString *fateNum;  //当前费率

@property(nonatomic,strong)NSString *responseCode;

@property(nonatomic,strong)NSString *responseMessage;

-(void)sureUpgradeRequest;

@end


@protocol UserToAgentDelegate <NSObject>

- (void)UserToAgentSuccessWithMessage: (NSString *)message;

- (void)UserToAgentFildWithMessage: (NSString *)message;

@end