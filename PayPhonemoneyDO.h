//
//  PayPhonemoneyDO.h
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-17.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol payPhoneMoneyDelegate;

@interface PayPhonemoneyDO : BaseModel

@property (nonatomic,assign) id<payPhoneMoneyDelegate>delegate;

@property (nonatomic,strong) NSString *proID;
@property (nonatomic,strong) NSString *proName;
@property (nonatomic,strong) NSString *proAmt;
@property (nonatomic,strong) NSString *proType;
@property (nonatomic,strong) NSString *proNum;
@property (nonatomic,strong) NSString *proParValue;


@property (nonatomic,strong) NSString *responeCode;
@property (nonatomic,strong) NSString *responeMessage;

@property (nonatomic,strong) NSMutableArray *Arr;

-(void) payMoneyRequest;

@end


@protocol payPhoneMoneyDelegate <NSObject>

-(void)payMoneyRequestSuccessWithMessage:(NSString *)message;
-(void)payMoneyRequestFeildWithMessage:(NSString *)message;

@end


