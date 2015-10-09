//
//  CreateActivationCode.h
//  BusinessPay
//
//  Created by zm on 4/5/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol CreateActivationCodeDelegate;

@interface CreateActivationCode : BaseModel

@property (nonatomic, assign) id <CreateActivationCodeDelegate> delegate;

@property (nonatomic, copy) NSString * trancode;

@property(strong, nonatomic)NSString *LoginPhoneNum;  //当前登录手机号

@property(strong, nonatomic)NSString *currentAgentNumber;  //当前代理商编号

@property(strong, nonatomic)NSString *PayPassword;  //支付密码

@property(strong, nonatomic)NSString *codeNum;  //激活码数量

@property(nonatomic,strong)NSString *responseCode;

@property(nonatomic,strong)NSString *responseMessage;

@property(nonatomic,strong)NSMutableArray *codeArray;

@property(nonatomic,strong)NSString *creatCodeNum;


-(void)CreateActivationCodeRequest;

@end



@protocol CreateActivationCodeDelegate <NSObject>

- (void)CreateActivationCodeSuccessWithMessage: (NSString *)message andArr:(NSMutableArray*)codeArr;

- (void)CreateActivationCodeFildWithMessage: (NSString *)message;

@end