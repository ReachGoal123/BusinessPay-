//
//  RadingParticularsDO.h
//  BusinessPay
//
//  Created by SHANGYINTONG on 15-4-8.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol RadingParticularsDelegate;

@interface RadingParticularsDO : BaseModel

@property (nonatomic,strong) id<RadingParticularsDelegate> delegate;

//request
@property (nonatomic,strong) NSString *alogNO;


//response
@property (nonatomic,strong) NSString *reChangeNumber;   //充值号码
@property (nonatomic,strong) NSString *cardNO;           //还款卡号
@property (nonatomic,strong) NSString *cardName;         //还款名字
@property (nonatomic,strong) NSString *bankName;         //银行名字

@property (nonatomic,strong) NSString *outName;   //转入钱的名称
@property (nonatomic,strong) NSString *pactNam;   //转出的名称
@property (nonatomic,strong) NSString *outActid;
@property (nonatomic,strong) NSString *pactActid;




@property (nonatomic,strong) NSString *orderType;       
@property (nonatomic,strong) NSString *orderStype;
@property (nonatomic,strong) NSString *orderTime;       //交易时间
@property (nonatomic,strong) NSString *txtAmt;        //实际入账金额
@property (nonatomic,strong) NSString *feeAmt;        //手续费
@property (nonatomic,strong) NSString *orderStutas;   //交易状态
@property (nonatomic,strong) NSString *targActid;     //?
@property (nonatomic,strong) NSString *actid;



-(void)radingRequest;

@end


@protocol RadingParticularsDelegate <NSObject>

-(void)radingParticularsSuccessWithMessage:(NSString *)message withRadingPar:(RadingParticularsDO *)radingParticularsDO;

-(void)radingParticularsFeildWithMessage:(NSString *)message;


@end