//
//  TransferAccountDO.h
//  BusinessPay
//
//  Created by SHANGYITONG on 15-1-27.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol  transferAccountDelegate;

@interface TransferAccountDO : BaseModel
@property (nonatomic , assign)id <transferAccountDelegate>delegate;

//request

@property (nonatomic,strong) NSString *oppositePhone;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *money;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *password;


//response

@property (nonatomic,strong) NSString *checkAmt;  //账号活期余额，
@property (nonatomic,strong) NSString *avaAmt;     //账号可用余额

@property (nonatomic,strong) NSString *responeCode;
@property (nonatomic,strong) NSString *responeMessage;



- (void)TranferaccountRequest;
- (void)decodeTranferAccount:(NSString *)content;

@end



@protocol transferAccountDelegate <NSObject>

- (void)TranferaccountResponseSuccessWithMessage:(NSString *)message;

- (void)TranferaccountFieldWithMessage:(NSString *)message;

@end
