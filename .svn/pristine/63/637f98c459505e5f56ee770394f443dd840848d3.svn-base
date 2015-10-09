//
//  BankCardChangeDO.h
//  BusinessPay
//
//  Created by Tears on 14-4-16.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "BaseModel.h"
@protocol BankCardMessageChangeDelegate;

@interface BankCardChangeDO : BaseModel
@property (nonatomic, assign)id <BankCardMessageChangeDelegate>delegate;
@property (nonatomic, copy)NSString * bankName;
@property (nonatomic, copy)NSString * provinceID;
@property (nonatomic, copy)NSString * cityID;
@property (nonatomic, copy)NSString * subbranchID;
@property (nonatomic, copy)NSString * userName;
@property (nonatomic, copy)NSString * cardNumber;


- (void)bankCardChangeApplicationRequest;

@end

@protocol BankCardMessageChangeDelegate <NSObject>

- (void)changSuccessWithMessage : (NSString *)message;

- (void)changFailWithMessage : (NSString *)message;

@end