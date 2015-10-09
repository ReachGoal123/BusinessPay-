//
//  OrderCreateDO.h
//  BusinessPay
//
//  Created by SHANGYITONG on 14-12-12.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol OrderCreateDelegate;

@interface OrderCreateDO : BaseModel

@property(nonatomic,assign) id<OrderCreateDelegate> delegate;

//@property(nonatomic,copy) NSString *orderAmount;
@property(nonatomic,copy) NSString *payType;
@property(nonatomic,copy) NSString *commddityName;
@property(nonatomic,copy) NSString *commodityPrice;
@property(nonatomic,copy) NSString *tetmo;
@property(nonatomic,copy) NSString *UrlType;
@property(nonatomic,copy) NSString *merType;

//response
@property(nonatomic,copy) NSString *merchantNO;
@property(nonatomic,copy) NSString *merchantDate;
@property(nonatomic,copy) NSString *reUrl;


-(void) submitOrderCreateRequest;

@end

@protocol OrderCreateDelegate <NSObject>

//- (void)orderCreateScuessWithTransactionFlowCode: (NSString *)transactionFlowCode;

- (void)orderCreateFailWithMessage: (NSString *)message;

- (void)orderCreateSuccessWithMessage: (NSString *)message andMerchantId:(NSString *)merchantID andMerchantDate:(NSString *) merchantDate ;


@end





     //[request addPostValue:self.phoneNumber forKey:@"PHONENUMBER"];
//    [request addPostValue:self.orderAmount forKey:@"ORDAMT"];
//    [request addPostValue:self.commodityName forKey:@"PRDNAME"];
//    [request addPostValue:self.commodityPrice forKey:@"PRDUNITPRICE"];
//    [request addPostValue:self.quantity forKey:@"BUYCOUNT"];
//    [request addPostValue:self.billingCycle forKey:@"STLTYPE"];
//    [request addPostValue:self.termno forKey:@"TERMINALNUMBER"];

