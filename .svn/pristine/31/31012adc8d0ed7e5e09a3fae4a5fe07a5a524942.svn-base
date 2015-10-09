//
//  FindPasswordDO.h
//  BusinessPay
//
//  Created by Tears on 14-4-14.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol FindPasswordDelegate ;

@interface FindPasswordDO : BaseModel

@property (nonatomic, copy) NSString * phoneNumber;
@property (nonatomic, copy) NSString * IDCard;
@property (nonatomic, copy) NSString * messageCaptcha;
@property (nonatomic, copy) NSString * trancode;

@property (nonatomic, assign) id <FindPasswordDelegate>delegate;

// messageRequest
@property (nonatomic, copy) NSString * termno;
@property (nonatomic, copy) NSString * messageTrancode;

- (void)findPasswordRequest;

- (void)findPasswordMessageVerificationRequest;

@end


@protocol FindPasswordDelegate <NSObject>

- (void)findPasswordSuccessWithMessage:(NSString *)message;

- (void)findPasswordFieldWithMessage:(NSString *)message;

- (void)messageVerificationSuccessWithMessage:(NSString *)message;

- (void)messageVerificationSuccessFieldWithMessage:(NSString *)message;

@end