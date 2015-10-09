//
//  PhoneNumberChangeDO.h
//  BusinessPay
//
//  Created by Tears on 14-4-17.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol PhoneNumberChangeDelegate ;

@interface PhoneNumberChangeDO : BaseModel

@property (nonatomic , assign) id<PhoneNumberChangeDelegate>delegate;
@property (nonatomic ,copy)NSString * phoneNumberNew;
@property (nonatomic ,copy)NSString * messageCaptcha;

- (void)phoneNumberChangeRequest;

- (void)phoneNumberChangeMessageVerificationRequest;

@end

@protocol PhoneNumberChangeDelegate <NSObject>

- (void)phoneNumberChangeSuccessWithMessage: (NSString *)message;

- (void)phoneNumberChangeFailWithMessage: (NSString *)message;

- (void)phoneNumberChangeMessageVerificationSuccessWithMessage: (NSString *)message;

@end
