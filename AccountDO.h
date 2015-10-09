//
//  AccountDO.h
//  BusinessPay
//
//  Created by SHANGYITONG on 14-12-21.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol  AccountDelegate;

@interface AccountDO : BaseModel

@property (nonatomic , assign)id <AccountDelegate>delegate;


//request
@property (nonatomic,strong) NSString *merchantNum;

//respone;
@property (nonatomic,strong) NSString *loginStatus;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *accountStatus;
@property (nonatomic,strong) NSString *totalAccount;
@property (nonatomic,strong) NSString *fixAccount;     //定期金额
@property (nonatomic,strong) NSString *checkAccount;   //活期金额
@property (nonatomic,strong) NSString *avidAccount;
@property (nonatomic,strong) NSString *accumulatedIncome;  //总收益
@property (nonatomic,strong) NSString *yestedayIncome;
@property (nonatomic,strong) NSString *weekIncome;
@property (nonatomic,strong) NSString *monthIncome;
@property (nonatomic,strong) NSString *bindCard;       //绑定银行卡号
@property (nonatomic,strong) NSString *bankName;
@property (nonatomic,strong) NSString *typeCard;      


@property (nonatomic,strong) NSString *responseCode;

- (void)accountRequest;
- (void)decodeAccount:(NSString *)content;

@end

@protocol AccountDelegate <NSObject>
@optional
- (void)accountResponseSuccessWithMessage:(NSString *)message withAccount:(AccountDO *)accountDO;


- (void)accountFieldWithMessage:(NSString *)message;

@end
