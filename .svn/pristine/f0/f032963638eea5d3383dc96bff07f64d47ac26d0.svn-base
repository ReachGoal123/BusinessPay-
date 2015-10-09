//
//  PhoneNumberUploadPhotoDO.h
//  BusinessPay
//
//  Created by SHANGYITONG on 15-1-14.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseModel.h"
@protocol PhoneNumberChangeUpLoadDelegate ;

@interface PhoneNumberUploadPhotoDO : BaseModel

@property (nonatomic , assign) id<PhoneNumberChangeUpLoadDelegate>delegate;



@property (nonatomic, copy) NSString *IDFilePath;
@property (nonatomic,copy) NSString *photoFilePath;


@property (nonatomic,strong) NSString *IDFileName;
@property (nonatomic,strong) NSString *photoFileName;

- (void)phoneNumberUploadChangeRequest;

@end


@protocol PhoneNumberChangeUpLoadDelegate <NSObject>

- (void)phoneNumberChangeUploadSuccessWithMessage: (NSString *)message;

- (void)phoneNumberChangeUploadFailWithMessage: (NSString *)message;


@end