//
//  PayPasswordChange.h
//  BusinessPay
//
//  Created by SHANGYITONG on 14-12-23.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol PayPasswordChangeDelegate;

@interface PayPasswordChange : BaseModel


@property(nonatomic,assign) id <PayPasswordChangeDelegate> delegate;

@property (nonatomic,strong) NSString *oldPassword;
@property (nonatomic,strong) NSString *Passwords;


-(void) payPasswordChangeRequest;


@end


@protocol PayPasswordChangeDelegate <NSObject>

- (void)payPasswordChangeResponseSuccessWithMessage:(NSString *)message;

- (void)payPasswordChangeFieldWithMessage:(NSString *)message;

@end