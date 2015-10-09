//
//  MerchantDO.h
//  BusinessPay
//
//  Created by Tears on 14-4-16.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol MerchantInformationInquiryDelegate ;

@interface MerchantDO : BaseModel

@property (nonatomic , assign)id<MerchantInformationInquiryDelegate>delegate;
@property (nonatomic , copy) NSString * trancode;
@property (nonatomic , copy) NSString * phoneNumber;
@property (nonatomic , copy)NSString * termno;
@property (nonatomic , copy)NSString * termType;

// response
@property (nonatomic , copy)NSString * merchantID;
@property (nonatomic , copy)NSString * merchantName;
@property (nonatomic , copy)NSString * bankCardNumber;
@property (nonatomic , copy)NSString * bankName;
@property (nonatomic , copy)NSString * IDCard;
@property (nonatomic , copy)NSString * realNameStatus;

// response BankID ProvinceID CityID...
@property (nonatomic , copy)NSString * bankID;
@property (nonatomic , copy)NSString * provinceID;
@property (nonatomic , copy)NSString * provinceName;
@property (nonatomic , copy)NSString * cityID;
@property (nonatomic , copy)NSString * cityName;
@property (nonatomic , copy)NSString * subbranchID;
@property (nonatomic , copy)NSString * subbranchName;


@property (nonatomic, copy) NSString * responseCode;

- (void)merchantInformationInquiryRequest;

- (void)bankCardMessageChangeMerchantInformationInquiryRequest;

@end

@protocol MerchantInformationInquiryDelegate <NSObject>
@optional

- (void)merchantInformationInquirySuccessWithMessage: (NSString *)message andMerchantDO:(MerchantDO *)merchantDO;

- (void)merchantInformationInquiryFieldWithMessage: (NSString *)message ;

- (void)merchantBankInformationInquirySuccessWithMessage: (NSString *)message andMerchantDO:(MerchantDO *)merchantDO;

@end
