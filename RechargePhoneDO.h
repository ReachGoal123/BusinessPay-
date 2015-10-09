//
//  RechargePhoneDO.h
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-17.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol RechargePhoneDelegate;


@interface RechargePhoneDO : BaseModel

@property (nonatomic,assign) id<RechargePhoneDelegate>delegate;

@property (nonatomic,strong) NSString *merchantNum;
@property (nonatomic,strong) NSString *proID;
@property (nonatomic,strong) NSString *proType;
@property (nonatomic,strong) NSString *oppositePhoneNumber;
@property (nonatomic,strong) NSString *reQoperators;
@property (nonatomic,strong) NSString *payPassword;


@property (nonatomic,strong) NSString *responseCode;
@property (nonatomic,strong) NSString *responseMessage;




-(void)rechangePhoneRequest;



@end

@protocol RechargePhoneDelegate <NSObject>

-(void)rechangePhoneSuccessWithMessage:(NSString *)message;

-(void)rechangePhoneFeildWithMessage:(NSString *)message;



@end