//
//  ChangePasswordDO.h
//  BusinessPay
//
//  Created by Tears on 14-4-15.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol ChangePasswordDelegate;

@interface ChangePasswordDO : BaseModel

@property (nonatomic, copy) NSString * trancode;
@property (nonatomic, copy) NSString * phoneNumber;
@property (nonatomic, copy) NSString * oldPassword;
@property (nonatomic, copy) NSString * passWordnew;
@property (nonatomic, assign)id <ChangePasswordDelegate>delegate;

- (void)changePasswordRequest;

- (void)changePasswordAfterVerificationRequest;

@end


@protocol ChangePasswordDelegate <NSObject>

- (void)changePasswordSuccessWithMessage:(NSString *)message;

- (void)changePasswordFieldWithMessage:(NSString *)message;

@end