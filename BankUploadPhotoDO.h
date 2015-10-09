//
//  BankUploadPhotoDO.h
//  BusinessPay
//
//  Created by SHANGYITONG on 15-1-5.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol BankUploadPhotoDelegate;

@interface BankUploadPhotoDO : BaseModel

@property (nonatomic, assign)id <BankUploadPhotoDelegate>delegate;

@property (nonatomic, strong) NSString *IDFilePath;
@property (nonatomic, strong) NSString *photoFilePath;

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *IDcard;
@property (nonatomic, strong) NSString *bankCardNumber;
@property (nonatomic, strong) NSString *bankName;
@property (nonatomic, strong) NSString *provinceID;
@property (nonatomic, strong) NSString *cityID;
@property (nonatomic, strong) NSString *subbranchID;

@property (nonatomic, strong) NSString *IDFileName;
@property (nonatomic, strong) NSString *photoFileName;


-(void) upLoadRequest;

@end


@protocol BankUploadPhotoDelegate <NSObject>

- (void)upLoadPhotoSuccessWithMessage:(NSString *)message;

- (void)upLoadPhotoFailWithMessage:(NSString *)message;

@end