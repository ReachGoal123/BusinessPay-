//
//  MyCircleDO.h
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-17.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol MyCircleDelegate ;

@interface MyCircleDO : BaseModel

@property (nonatomic,assign) id<MyCircleDelegate> delegate;


@property (nonatomic,strong) NSString *pageNum;
@property (nonatomic,strong) NSString *numPerPage;

@property (nonatomic,strong) NSString *totalRecode;
@property (nonatomic,strong) NSString *tranlist;

@property (nonatomic,strong) NSString *merchantName;
@property (nonatomic,strong) NSString *merPhoneNumber;              //注册号码
@property (nonatomic,strong) NSString *applyDate;                   //注册时间
@property (nonatomic,strong) NSString *FenRunEarnings;              //累计分润收益


@property (nonatomic,strong) NSMutableArray *termArr;

-(void) myCircleRequest;

@end


@protocol MyCircleDelegate <NSObject>

- (void)myCircleRequestSuccessWithMessage:(NSString *)message andArr:(NSMutableArray *)arr;

- (void)myCircleRequestFieldWithMessage:(NSString *)message;


@end