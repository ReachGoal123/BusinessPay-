//
//  OrderPayInquiryDO.h
//  BusinessPay
//
//  Created by SHANGYITONG on 15-1-13.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol OrderPayInquiryDelegate ;

@interface OrderPayInquiryDO : BaseModel

@property (nonatomic, assign) id <OrderPayInquiryDelegate> delegate;


@property (nonatomic,strong) NSMutableArray * tempArr;

@property (nonatomic, copy)NSString * currentPage;
@property (nonatomic, copy)NSString * accountPerPage;
@property (nonatomic, copy)NSString * totleAccount;
@property (nonatomic, copy)NSString * startDataTime;
@property (nonatomic, copy)NSString * endDataTime;

// response
@property (nonatomic, copy)NSString * payOrderNumber;
@property (nonatomic, copy)NSString * orderMoney;
@property (nonatomic, copy)NSString * payTime;
@property (nonatomic, copy)NSString * payStatus;
@property (nonatomic, copy)NSString * orderType;
@property (nonatomic, copy)NSString * transacteLineNumber;
@property (nonatomic, copy)NSString * transacteCheckLineNumber;
@property (nonatomic, copy)NSString * totalRecord;
@property (nonatomic, copy)NSString * orderNum;



// 已支付的

@property (nonatomic,copy) NSString *txtDate;
@property (nonatomic,copy) NSString *clsDate;
@property (nonatomic,copy) NSString *clsAmt;

@property (nonatomic,copy) NSString *frramt;

@property (nonatomic,copy) NSString *txtamt;

- (void)orderListInquiryRequest;

@end

@protocol OrderPayInquiryDelegate <NSObject>

- (void)orderPayInquiryResponseSuccessWithMessage: (NSString *)message andOrderInquiryDOArry :(NSMutableArray *)arr;

- (void)orderPayInquiryResponseFailWithMessage: (NSString *)message;


@end
