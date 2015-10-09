//
//  PayPasswordSet.h
//  BusinessPay
//
//  Created by SHANGYITONG on 14-12-23.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol PayPasswordSetDelegate;

@interface PayPasswordSet : BaseModel


@property(nonatomic,assign) id <PayPasswordSetDelegate> delegate;

@property(nonatomic,strong) NSString *password;


-(void) payPasswordSetRequest;

@end


@protocol PayPasswordSetDelegate <NSObject>


- (void)payPasswordSetResponseSuccessWithMessage:(NSString *)message;

- (void)payPasswordSetFieldWithMessage:(NSString *)message;

@end