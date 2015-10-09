//
//  orderCheckDO.h
//  BusinessPay
//
//  Created by SHANGYITONG on 14-12-23.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol orderChectDelegate;


@interface orderCheckDO : BaseModel

@property (nonatomic , assign)id <orderChectDelegate>delegate;

@property (nonatomic,strong) NSString *currentPageNum;
@property (nonatomic,strong) NSString *numPerPage;


//response

@property (nonatomic,strong) NSString *totalRecord;   //总记录数
@property (nonatomic,strong) NSString *accountID;     //账户id
@property (nonatomic,strong) NSString *userName;      //用户名
@property (nonatomic,strong) NSString *serialNum;

@property (nonatomic,strong) NSString *transactionMoney;  //交易金额

@property (nonatomic,strong) NSString *operTime;          //交易时间
@property (nonatomic,strong) NSString *operstat;         //交易状态


-(void)orderCheckRequest;


@end



@protocol orderChectDelegate <NSObject>

- (void)orderCheckResponseSuccessWithMessage:(NSString *)message;

- (void)orderCheckFieldWithMessage:(NSString *)message;


@end
