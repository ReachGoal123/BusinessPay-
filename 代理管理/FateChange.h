//
//  FateChange.h
//  BusinessPay
//
//  Created by zm on 7/5/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol FateChangeDelegate;

@interface FateChange : BaseModel

@property (nonatomic, assign) id <FateChangeDelegate> delegate;

@property(nonatomic, strong)NSString *phoneNumstr;
@property(nonatomic, copy)NSString *trancode;
@property(nonatomic, strong)NSString *childAgengNum;
@property(nonatomic, strong)NSString *childFate;
@property(nonatomic,strong)NSString *responseMessage;

@property(nonatomic,strong)NSString *responseCode;

-(void)FateChangeRequest;

@end


@protocol FateChangeDelegate <NSObject>

- (void)FateChangeSuccessWithMessage:(NSString *)message ;

- (void)FateChangeFildWithMessage:(NSString *)message;

@end