//
//  LLLockViewController.h
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-5.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#define LLLockRetryTimes 4 // 最多重试几次
#define LLLockAnimationOn  // 开启窗口动画，注释此行即可关闭

#import <UIKit/UIKit.h>
#import "LLLockView.h"
#import "LLLockPassword.h"
#import "LLLockConfig.h"
#import "LoginDO.h"
#import "UpdateVersionDO.h"


@class LoginViewController;

// 进入此界面时的不同目的
typedef enum {
    LLLockViewTypeCheck,  // 检查手势密码
    LLLockViewTypeCreate, // 创建手势密码
    LLLockViewTypeModify, // 修改
    LLLockViewTypeClean,  // 清除
}LLLockViewType;

@interface LLLockViewController : UIViewController <LLLockDelegate,LoginRequestDelegate,updateVersionDelegate>

@property (nonatomic) LLLockViewType nLockViewType; // 此窗口的类型

@property (nonatomic,strong) LoginDO *loginDO;

- (id)initWithType:(LLLockViewType)type; // 直接指定方式打开

@end
