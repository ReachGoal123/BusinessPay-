//
//  BindCardDO.h
//  BusinessPay
//
//  Created by SHANGYINTONG on 15/4/29.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol BindCardDelegate;



@interface BindCardDO : BaseModel

@property (nonatomic,assign) id <BindCardDelegate> delegate;



@property (nonatomic,strong) NSString *merType;       //商户类型
@property (nonatomic,strong) NSString *cardWay;       //支付通道
@property (nonatomic,strong) NSString *orderAmt;      //交易金额
//@property (nonatomic,strong) NSString *cardTel;
@property (nonatomic,strong) NSString *cardType;      //证件类型
@property (nonatomic,strong) NSString *cardNumber;    //证件号码

@property (nonatomic,strong) NSString *cardName;     //持卡人姓名
@property (nonatomic,strong) NSString *cardCode;     //卡号
@property (nonatomic,strong) NSString *ferID;        //银行编号
@property (nonatomic,strong) NSString *expireYear;   // 有效期年（4位）
@property (nonatomic,strong) NSString *expireMonth;   // 有效期月
@property (nonatomic,strong) NSString *cvv;       //?
@property (nonatomic,strong) NSString *issuer;        //发卡行

@property (nonatomic,strong) NSString *cardTel;        //持卡人手机号


@property (nonatomic,strong) NSString *reChangeNumber;   //充值次数；

-(void) bindCardRequest;



@end



@protocol BindCardDelegate <NSObject>

-(void) bindCardRequestSuccessWithMessage:(NSString *)message andBindCardDOArr:(NSMutableArray *)temArr;
-(void) bindCardRequestFeildWithMessage:(NSString *) message;

@end
