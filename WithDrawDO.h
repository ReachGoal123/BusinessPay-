//
//  WithDrawDO.h
//  BusinessPay
//
//  Created by SHANGYITONG on 14-12-24.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol WithDrawDelegate;

@interface WithDrawDO : BaseModel

@property(nonatomic,assign) id <WithDrawDelegate> delegate;

@property(nonatomic,strong) NSString *txMoney;
@property(nonatomic,strong) NSString *accountCard;

@property(nonatomic,strong) NSString *isUrgency;

@property(nonatomic,strong) NSString *payPassword;


@property (nonatomic,strong) NSString *responeCode;
@property (nonatomic,strong) NSString *responeMessage;




-(void)withDrawRequest;

@end



@protocol WithDrawDelegate <NSObject>

- (void)withDrawResponseSuccessWithMessage:(NSString *)message;

- (void)withDrawFieldWithMessage:(NSString *)message;

@end
