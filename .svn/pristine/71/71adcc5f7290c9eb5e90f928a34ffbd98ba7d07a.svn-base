//
//  RealNameDO.h
//  BusinessPay
//
//  Created by Tears on 14-4-16.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol RealNameVerificationDelegate;

@interface RealNameDO : BaseModel
@property (nonatomic, assign)id <RealNameVerificationDelegate>delegate;
//@property (nonatomic, copy) NSString * phoneNumber;
@property (nonatomic, strong) NSString * merchantNum;
@property (nonatomic, strong) NSString * bankNumber;

@property (nonatomic, strong) NSString * IDCardFaceData;
@property (nonatomic, strong) NSString * photoData;
@property (nonatomic, strong) NSString * bankcardPhotoData;
@property (nonatomic, strong) NSString *IDFileName;
@property (nonatomic, strong) NSString *photoFileName;
@property (nonatomic, strong) NSString *bankCardFileName;




- (void)realNameVerificationRequest;

@end

@protocol RealNameVerificationDelegate <NSObject>

- (void)realNameVerificationSuccessWithMessage:(NSString *)message;

- (void)realNameVerificationFailWithMessage:(NSString *)message;

@end