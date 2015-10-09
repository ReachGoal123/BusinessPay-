//
//  FindPayPasswordDO.h
//  BusinessPay
//
//  Created by SHANGYITONG on 14-12-24.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol  FindPayPasswordDelegate;

@interface FindPayPasswordDO : BaseModel

@property (nonatomic,assign) id <FindPayPasswordDelegate> delegate;



//@property (nonatomic, copy) NSString * phoneNumber;
@property (nonatomic, copy) NSString * IDCard;
@property (nonatomic, copy) NSString * messageVerCode;
//@property (nonatomic, copy) NSString * trancode;



// messageRequest

@property (nonatomic, copy) NSString * phoneNumber;
@property (nonatomic, copy) NSString *trancode;

- (void)findPayPasswordRequest;

- (void)findPayPasswordMessageVerificationRequest;

@end


@protocol FindPayPasswordDelegate <NSObject>

- (void)findPayPasswordSuccessWithMessage:(NSString *)message;

- (void)findPayPasswordFieldWithMessage:(NSString *)message;

- (void)messageVerificationSuccessWithMessage:(NSString *)message;

- (void)messageVerificationFieldWithMessage:(NSString *)message;



@end
