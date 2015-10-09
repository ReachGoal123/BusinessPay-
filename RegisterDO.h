//
//  RegisterDO.h
//  BusinessPay
//
//  Created by Tears on 14-4-11.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "ProvinceDO.h"
#import "CityDO.h"
#import "SubbranchDO.h"

@protocol RegisterRequestDelegate;

@interface RegisterDO :BaseModel


@property (nonatomic, strong) ProvinceDO * provinceDO;
@property (nonatomic, strong) CityDO * cityDO;
@property (nonatomic, strong) SubbranchDO * subbranchDO;

@property (nonatomic,strong) NSString *recommendation;

// request
@property (nonatomic , copy)NSString * bankCardNumber;              // 卡号
@property (assign)id <RegisterRequestDelegate> delegate;

// response PronVice
@property (nonatomic , copy)NSString * belongsBankName;             // 开户行名称
@property (nonatomic , copy)NSString * bankID;                      // 开户行ID
@property (nonatomic , assign)int cardType;                         // 开卡类型
@property (nonatomic , strong)NSMutableArray * provinceArr;         // 省列表集合
@property (nonatomic , copy)NSString * MACValue;                    // PACKAGEMAC
@property (nonatomic , copy)NSString * responseCode;                // 响应码
@property (nonatomic , copy)NSString * responseMessage;             // 响应消息

// response City
@property (nonatomic , strong)NSMutableArray * cityArr;             // 城市列表集合

// response Subbranch
@property (nonatomic , strong)NSMutableArray * subbranchArr;        // 城市列表集合

// response MessageVerification
@property (nonatomic, copy) NSString * verificationPhoneNumber;     // 验证手机号

- (void)registerBankNameRequestWithTrancode: (NSString *)trancode;

//- (void)registerCityNameRequestWithTrancode: (NSString *)trancode andRequestMessage :(NSMutableDictionary *)messageDic;
//-(void)registerCityNameRequestWithRequester:(ASIFormDataRequest *)request;

//- (void)registerSubbranchRequestWithTrancode: (NSString *)trancode andRequestMessage :(NSMutableDictionary *)messageDic;
//- (void)registerSubbranchRequestWithRequester:(ASIFormDataRequest *)request;
-(void)registerCityNameRequestWithTrancode: (NSString *)trancode andProvinceID:(NSString *)provinceID;
- (void)registerSubbranchRequestWithTrancode: (NSString *)trancode andProvinceID :(NSString *)provinceID andCityID:(NSString *)cityID andBankID:(NSString *)bankID;

//- (void)registerMessageVerificationRequestWithTrancode: (NSString *)trancode andRequestMessage :(NSMutableDictionary *)messageDic;

- (void)registerMessageVerificationRequestWithRequester:(ASIFormDataRequest *)request;

//- (void)registerRequestWithTrancode: (NSString *)trancode andRequestMessage :(NSMutableDictionary *)messageDic;
- (void)registerRequestWithRequester:(ASIFormDataRequest *)request;

@end



@protocol RegisterRequestDelegate <NSObject>

- (void)responseSuccess:(RegisterDO *)registerDO;

- (void)cityResponseSuccess:(RegisterDO *)registerDO;

- (void)subbranchResponseSuccess:(RegisterDO *)registerDO;

- (void)messageVerificationSuccessWithMessage: (NSString *)message;

- (void)registerSucessWithMessage: (NSString *)message;

- (void)responseFildWithMessage: (NSString *)message;

- (void)registerResponseFailWithMessage: (NSString *)message;

@end
