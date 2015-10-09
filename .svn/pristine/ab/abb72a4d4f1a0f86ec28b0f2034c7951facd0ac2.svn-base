//
//  FeedBackDO.h
//  BusinessPay
//
//  Created by SHANGYINTONG on 15/5/4.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseModel.h"


@protocol  FeedBackDelegate;

@interface FeedBackDO : BaseModel

@property (nonatomic,assign) id<FeedBackDelegate> delegate;
@property (nonatomic,strong) NSString *contactName;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *contactType;
@property (nonatomic,strong) NSString *email;

-(void) feedBackRequest;

@end



@protocol FeedBackDelegate <NSObject>

-(void)feedBackRequestSuccessWithMessage:(NSString *)message;
-(void)feedBackRequestFeildWithMessage:(NSString *)message;



@end