//
//  Enum.h
//  Shorthand
//
//  Created by Tears on 14-1-11.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Enum : NSObject

typedef NS_ENUM(NSInteger, DCflagType)
{
    DCflagType_DebitCard = 1,          // 借记卡
    DCflagType_CreditCard,             // 信用卡
};

typedef NS_ENUM(NSInteger, DataSouceType)
{
    DataSouceType_province = 90,
    DataSouceType_city = 100,
    DataSouceType_subbranch = 110
};

typedef NS_ENUM (NSInteger, BankCardChangeType){
    
    BankCardChangeType_Application = 10,    // 银行卡信息变更申请  （认证通过）
    BankCardChangeType_Modify,              // 银行卡信息修改 （未认证）
    
} ;

typedef NS_ENUM (NSInteger, VerificationStatusType){
    
    VerificationStatusType_Passed,              // 认证通过
    VerificationStatusType_Waitting,            // 资料正在审核中
    VerificationStatusType_UnUpLoad,            // 未上传审核资料
    VerificationStatusType_UnPass,              // 认证不通过
    VerificationStatusType_BankPassOnly,        // 仅银行通过
    VerificationStatusType_IDCardPassOnly,      // 仅身份证认证通过
    VerificationStatusType_Disable,             // 用户被禁用
    VerificationStatusType_Wait,                // 待认证
    
} ;

typedef NS_ENUM (NSInteger, RealNameVerificationType){
    
    RealNameVerificationType_TheFirst,           // 首次验证
    RealNameVerificationType_PhoneNumber,            // 待认证
    RealNameVerificationType_Bankcard,              // 认证不通过
    
} ;

//typedef NS_ENUM (NSInteger,)

@end
