//
//  SetPayPasswordDO.h
//  BusinessPay
//
//  Created by SHANGYITONG on 15-1-7.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol SetPayPasswordDelegate;

@interface SetPayPasswordDO : BaseModel

@property (nonatomic,assign) id <SetPayPasswordDelegate> delegate;

@property (nonatomic,strong) NSString *payPassword;


-(void)setPasswordRequest;

@end



@protocol SetPayPasswordDelegate <NSObject>

- (void)setPasswordSuccessWithMessage:(NSString *)message;

- (void)setPasswordFieldWithMessage:(NSString *)message;


@end