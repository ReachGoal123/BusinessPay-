//
//  OrderPayDO.h
//  BusinessPay
//
//  Created by Tears on 14-4-17.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol OrderPayDelegate ;

@interface OrderPayDO : BaseModel

@property (nonatomic, assign)id <OrderPayDelegate>delegate;
//@property (nonatomic , copy)NSString * orderAmount;
//@property (nonatomic , copy)NSString * commodityPrice;
//@property (nonatomic , copy)NSString * commodityName;
//@property (nonatomic , copy)NSString * quantity;
//@property (nonatomic , copy)NSString * billingCycle;

@property (nonatomic,copy) NSString *menchantNO;
@property (nonatomic,copy) NSString *urlType;


//response
@property(nonatomic,copy) NSString *reURL;

- (void)submitOrderRequest;

@end

@protocol OrderPayDelegate <NSObject>

- (void)orderPayScuessWithReurl:(NSString *) reurl andMessage:(NSString *)message;

- (void)orderPayFailWithMessage: (NSString *)message;

@end
