//
//  BuyFateDO.h
//  BusinessPay
//
//  Created by SHANGYITONG on 15-2-28.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol BuyFateDelegate ;


@interface BuyFateDO : BaseModel


@property (nonatomic,assign) id<BuyFateDelegate> delegate;

@property (nonatomic,strong) NSString *feedID;      //费率ID
@property (nonatomic,strong) NSString *payPassword; //支付密码


-(void) buyFateRequest;



@end


@protocol BuyFateDelegate <NSObject>

- (void)buyFateSuccessWithMessage:(NSString *)message;

- (void)buyFateFieldWithMessage:(NSString *)message;


@end