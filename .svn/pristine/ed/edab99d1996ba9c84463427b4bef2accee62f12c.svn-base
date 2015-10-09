//
//  OrderDetailDO.h
//  BusinessPay
//
//  Created by Tears on 14-4-17.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol OrderDetailDelegate;

@interface OrderDetailDO : BaseModel
@property (nonatomic, assign) id <OrderDetailDelegate>delegate;
@property (nonatomic, copy)NSString * orderCode;
@property (nonatomic, copy)NSString * orderDataTime;
@property (nonatomic, copy)NSString * urlType;

//response
@property (nonatomic, copy)NSString *meroederStatus;

- (void)orderDetailRequest;
//01102014041719492500000098  20140417194925

@end

@protocol OrderDetailDelegate <NSObject>

- (void)orderDetailSuccessWithMessage: (NSString *)message andPhoneNumber: (NSString *)phoneNumber andMerorderStatus:(NSString *) merorderStatus;

- (void)orderDetailFailWithMessage: (NSString *)message andPhoneNumber: (NSString *)phoneNumber andMerorderStatus:(NSString *) merorderStatus ;

@end