//
//  CodeNotUserImformationQuery.h
//  BusinessPay
//
//  Created by zm on 6/5/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol CodeNotUserImformationQueryDelegate;

@interface CodeNotUserImformationQuery : BaseModel

@property (nonatomic, assign) id <CodeNotUserImformationQueryDelegate> delegate;

@property(copy,nonatomic)NSString *trancode;

@property(strong,nonatomic)NSString *phongeNumberCode;  //代理商电话

@property(strong,nonatomic)NSString *agentNumber; //代理商编号

@property(nonatomic,strong)NSString *responseMessage;

@property(nonatomic,strong)NSString *responseCode;

@property(nonatomic,strong)NSString *kaishiTime; //开始时间

@property(nonatomic,strong)NSString *jieshuTime; //结束时间

@property(nonatomic,strong)NSString *codeType; //激活码类型

@property(nonatomic,strong)NSString *activCode; //激活码


@property (nonatomic,strong) NSMutableArray *termArr;

-(void)CodeNotUserImformationQueryRequest;

@end


@protocol CodeNotUserImformationQueryDelegate <NSObject>

- (void)CodeNotUserImformationQuerySuccessWithMessage:(NSString *)message andArr:(NSMutableArray *)arr;

- (void)CodeNotUserImformationQueryFildWithMessage:(NSString *)message;

@end