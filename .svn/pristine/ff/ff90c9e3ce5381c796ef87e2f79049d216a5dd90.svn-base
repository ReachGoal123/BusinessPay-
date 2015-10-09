//
//  UploadPhotoDO.h
//  BusinessPay
//
//  Created by SHANGYINTONG on 15/4/30.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseModel.h"


@protocol UploadPhotoDelegate ;


@interface UploadPhotoDO : BaseModel


@property (nonatomic,strong) id<UploadPhotoDelegate> delegate;

@property (nonatomic,strong) NSString *imageName;
@property (nonatomic,strong) NSString *imagePath;

@property (nonatomic,strong) NSString *upLoadImagePath;

-(void) upLoadPhotoRequest;


@end


@protocol UploadPhotoDelegate <NSObject>

-(void) upLoadRequestSuccessWithMessage:(NSString *) message andImagePath:(NSString *)imagePath;
-(void) upLOadRequestFeildWihtMessage:(NSString *)message;

@end