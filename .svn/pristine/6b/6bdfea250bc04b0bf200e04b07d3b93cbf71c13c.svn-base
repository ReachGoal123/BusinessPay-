//
//  OrderInquiryDO.h
//  BusinessPay
//
//  Created by Tears on 14-4-17.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "BaseModel.h"
@protocol OrderListInquiryDelegate ;

@interface OrderInquiryDO : BaseModel
@property (nonatomic, assign) id <OrderListInquiryDelegate> delegate;
@property (nonatomic, copy)NSString * currentPage;
@property (nonatomic, copy)NSString * accountPerPage;
@property (nonatomic, copy)NSString * totleAccount;
@property (nonatomic, copy)NSString * startDataTime;
@property (nonatomic, copy)NSString * endDataTime;

// response  (未支付的)
@property (nonatomic, copy)NSString * payOrderNumber;
@property (nonatomic, copy)NSString * orderMoney;
@property (nonatomic, copy)NSString * totalOrderMoney;
@property (nonatomic, copy)NSString * payTime;
@property (nonatomic, copy)NSString * payStatus;
@property (nonatomic, copy)NSString * orderType;
@property (nonatomic, copy)NSString * transacteLineNumber;
@property (nonatomic, copy)NSString * transacteCheckLineNumber;
@property (nonatomic, copy)NSString * totalRecord;
@property (nonatomic, copy)NSString * orderNum;
@property (nonatomic, copy)NSString * orderStype;

@property (nonatomic,copy) NSString * recNumber;      //充值号码
@property (nonatomic,copy) NSString * cardNo;         // 还款账号
@property (nonatomic,copy) NSString * cardName;       // 还款姓名
@property (nonatomic,copy) NSString * bankName;       // 银行名称
@property (nonatomic,copy) NSString * outActName;     // 出账姓名
@property (nonatomic,copy) NSString * payActName;     // 收款姓名




- (void)orderListInquiryRequest;

@end

@protocol OrderListInquiryDelegate <NSObject>

- (void)orderListInquiryResponseSuccessWithMessage: (NSString *)message andOrderInquiryDOArry :(NSMutableArray *)arr;

- (void)orderListInquiryResponseFailWithMessage: (NSString *)message;

@end