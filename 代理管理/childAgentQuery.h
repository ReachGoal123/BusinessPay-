//
//  childAgentQuery.h
//  BusinessPay
//
//  Created by zm on 4/5/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol childAgentQueryDelegate;

@interface childAgentQuery : BaseModel

@property (nonatomic, assign) id <childAgentQueryDelegate> delegate;

@property (nonatomic, copy) NSString * trancode;

@property(strong, nonatomic)NSString *LoginPhoneNum;  //当前登录手机号

@property(strong, nonatomic)NSString *currentAgentNumber;  //当前代理商编号

@property(strong, nonatomic)NSString *childAgentNumber;  //子代理商编号

@property(strong, nonatomic)NSString *childAgentName;  //子代理商姓名

@property(strong, nonatomic)NSString *costRate;  //成本费率

@property(strong, nonatomic)NSString *pickGoodsNumber ;  //提货数量

@property(strong, nonatomic)NSString *childPhoneNum ;  //电话

@property(nonatomic,strong)NSString *responseCode;

@property(nonatomic,strong)NSString *responseMessage;

@property (nonatomic,strong) NSMutableArray *termArr;

-(void)childAgentQueryRequest;

@end


@protocol childAgentQueryDelegate <NSObject>

- (void)childAgentQuerySuccessWithMessage:(NSString *)message andArr:(NSMutableArray *)arr;

- (void)childAgentQueryFildWithMessage:(NSString *)message;

@end