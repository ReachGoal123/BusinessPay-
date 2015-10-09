//
//  ResetPayPasswordDO.h
//  BusinessPay
//
//  Created by SHANGYITONG on 14-12-24.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol ReSetPayPasswordDelegate;

@interface ResetPayPasswordDO : BaseModel


@property (nonatomic,assign) id <ReSetPayPasswordDelegate> delegate;


@property (nonatomic,copy) NSString *password;



-(void)reSetPasswordRequest;



@end


@protocol ReSetPayPasswordDelegate <NSObject>

- (void)reSetPasswordSuccessWithMessage:(NSString *)message;

- (void)reSetPasswordFieldWithMessage:(NSString *)message;


@end