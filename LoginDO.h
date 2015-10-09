//
//  LoginDO.h
//  BusinessPay
//
//  Created by Tears on 14-4-11.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"


@protocol LoginRequestDelegate;

@interface LoginDO : BaseModel

@property (nonatomic, copy) NSString * userNamePhoneNumber;
@property (nonatomic, copy) NSString * passWord;
@property (nonatomic, assign) id <LoginRequestDelegate> delegate;
@property (nonatomic, copy) NSString * trancode;
@property (nonatomic, copy) NSString * termno;
@property (nonatomic, copy) NSString * SIMNumber;
@property (nonatomic, copy) NSString * appType;
@property (nonatomic, copy) NSString * responseCode;
@property (nonatomic ,copy) NSString * responseMessage;
@property (nonatomic,strong) NSError *error;

@property (nonatomic,strong) NSString *isUpdate;
@property (nonatomic,strong) NSString *updateUrl;


@property (nonatomic,copy) NSString *merchantNum;





- (void)loginRequest;

@end

@protocol LoginRequestDelegate <NSObject>

- (void)loginSuccessWithMessage: (NSString *)message;

- (void)loginFildWithMessage: (NSString *)message;

@end