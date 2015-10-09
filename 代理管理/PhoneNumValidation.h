//
//  PhoneNumValidation.h
//  BusinessPay
//
//  Created by zm on 30/4/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseModel.h"


@protocol NumberValidationDelegate;

@interface PhoneNumValidation : BaseModel

@property (nonatomic, assign) id <NumberValidationDelegate> delegate;

@property (nonatomic, copy) NSString * trancode;

@property(strong, nonatomic)NSString *VerifiedNum;  //被验证号

@property(strong, nonatomic)NSString *CurrentLoginPhoneNum;  //当前登录手机号

@property (nonatomic,strong) NSError *error;

@property(nonatomic,strong)NSString *responseCode;

@property(nonatomic,strong)NSString *responseMessage;

- (void)phoneNumValidationRequest;

@end


@protocol NumberValidationDelegate <NSObject>

- (void)NumberValidationSuccessWithMessage: (NSString *)message;

- (void)NumberValidationFildWithMessage: (NSString *)message;

@end