//
//  Macro.h
//  Shorthand
//
//  Created by Tears on 14-1-11.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IsIOS6 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]<7)
#define kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define kSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define kTabBar_HEIGHT 49
#define kTbaBarDistance_Bottom IsIOS7 ? 69 : 49
#define kTitleBar_HEIGHT IsIOS8 ?  66 : 44

#define kIP                                     @"183.63.52.147"
//#define kIP                                     @"180.166.124.95"
//#define kIP                                     @"119.147.71.132"


#define kTrancode_PhoneNumValidation            @"701190"           // 钱包客户手机号验证
#define kTrancode_ChangePassword                @"199003"           // 修改密码
#define kTrancode_PhoneNumberChange             @"198109"           // 手机号码变更申请
#define kTrancode_PhoneNumberChangeVerification @"198220"           // 手机号码变更申请短信验证
#define kTrancode_MerchantData                  @"199102"           // 商户资料
#define kTrancode_BankMessageChange             @"198101"           // 银行信息修改申请 （认证）
#define kTrancode_BankMessagever                @"198102"           // 银行信息修改申请认证
#define kTrancode_Province                      @"199104"           // 省份
#define kTrancode_City                          @"199108"           // 城市
#define kTrancode_Subbranch                     @"199109"           // 支行
#define kTrancode_ForgetPasswordSMSVerification @"198115"           // 忘记密码短信验证
#define kTrancode_ForgetPassword                @"198116"           // 忘记密码
#define kTrancode_ResetPassword                 @"198117"           // 重置密码
#define kTrancode_Login                         @"199002"           // 登录
#define kTrancode_Register                      @"199001"           // 注册
#define kTrancode_OrderPay                      @"701616"           // 无卡支付

#define kTrancode_RegisterMessageVerification   @"199018"           // 注册短信验证
#define kTrancode_TerminalVerification          @"198107"           // 终端验证
#define kTrancode_OrderList                     @"701615"           // 订单列表
#define kTrancode_OrderDetail                   @"701614"           // 订单详情
#define kTrancode_OrderCreate                   @"701613"           // 创建订单
#define kTrancode_BindCard                      @"701730"           // 绑卡查询
#define kTrancode_UploadPhoto                   @"701734"           // 图片上传
#define kTrancode_YibaoPay                      @"701725"           // 易宝支付
#define kTrancode_YibaoGetMessage               @"701727"           // 易宝获取验证码
#define kTrancode_YibaoVerMessage               @"701726"           // 易宝验证手机验证码

#define kTrancode_BankMessageChangeMerchantData @"203017"           // 商户资料   (银行卡信息修改)
#define kTrancode_BankCardChangeNotVerification @"199103"           // 银行卡信息修改   (未认证)
#define kTrancode_RealName                      @"199101"           // 实名认证   (首次验证)
#define kTrancode_RealNamePhoneNumber           @"198110"           // 实名认证   (手机号码变更申请)
#define kTrancode_RealNameBankCard              @"198102"           // 实名认证   (银行卡号变更申请)
#define kTrancode_AccountMessage                @"701122"           // 账户资金信息查询
#define kTrancode_PayPasswordChange             @"701121"           // 账户支付密码修改；
#define kTrancode_PayPasswordSet                @"701120"           // 账户支付密码设置；
#define kTrancode_FindPaypasswordSMVerification @"701493"           // 账户支付密码发送验证码
#define kTrancode_FindPayPasswordVerification   @"701494"           // 账户支付密码找回
#define kTrancode_FindPayPasswordReset          @"701497"           // 账户支付密码重设
#define kTrancode_TranferAccount                @"701129"           // 账户转账
#define kTrancode_FateList                      @"701709"           // 费率列表
#define kTrancode_FateBuy                       @"701708"           // 费率购买
#define kTrancode_MyCircle                      @"701720"           // 我的圈子
#define kTrancode_payPhoneMoney                 @"701640"           // 查询话费单价
#define kTrancode_Rechange                      @"701639"           // 充值话费

#define kTrancode_feedBack                      @"701735"           //反馈和建议

#define kXORKey                     @"tangdiit"
#define kMD5PassWord                @"dynamicode"
#define kBankCardNumberAppendStr    @"d49121202369991430fffffffffff996222024000079840084d1561560000000000001003236999010000049120d000000000000d000000000000d00000000fffffffffffffff"
#define kRequestSuccessCode         @"000000"
#define kPleaseWait                 @"请稍后..."
#define kTermType                   @"4"
#define kSIMNumber                  @"11111111"
#define kAppType                    @"2"
#define kNil                        @""
#define kPointStr                   @"."
#define kInquiryCurrentPage         @"1"
#define kInquiryNumber              @"500"
#define kZero                       @"0"
#define kZeroPoint                  @"0."
#define kZeroPointZero              @"0.0"
#define kDelayTime                  0.02f
#define kTextLengthZero             0
