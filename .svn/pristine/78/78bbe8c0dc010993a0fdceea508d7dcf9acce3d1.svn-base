//
//  YiBaoPayChannelDO.h
//  BusinessPay
//
//  Created by SHANGYINTONG on 15/4/27.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol YiBaoPayChannelDelegate;

@interface YiBaoPayChannelDO : BaseModel


@property (nonatomic,assign) id<YiBaoPayChannelDelegate> delegate;

//验证手机验证码;
@property (nonatomic,strong) NSString *vierifyCode;    //验证码
@property (nonatomic,strong) NSString *clslogNO;       //订单号

// 发送手机验证码

@property (nonatomic,strong) NSString *cardTel;        //持卡人手机号


//支付


//@property (nonatomic,strong) NSString *phoneNumber;
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


@property (nonatomic,strong) NSString *isCheck;      // 是否验证

@property (nonatomic,strong) NSString *isBind;    // 是否绑定

@property (nonatomic,strong) NSString *imagePath;   // 图片路径；

-(void) sendMessageRequest;
-(void) vierifyMessageRequest;
-(void) payRequest;

@end



@protocol YiBaoPayChannelDelegate <NSObject>


-(void) sendMessageRequestWithSuccess:(NSString *)message;
-(void) sendMessageRequestWithFail:(NSString *)message;

-(void) vierifyMessageRequestWithSuccess:(NSString *)message;
-(void) vierifyMessageRequestWithFail:(NSString *) message;


-(void) payRequestWithSuccess:(NSString *)message andYibaoPay:(YiBaoPayChannelDO *)yibaoPayChannelDO;
-(void) payRequestWithFail:(NSString *)message;



@end




