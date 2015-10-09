//
//  TakeBankCardPhotoViewController.h
//  BusinessPay
//
//  Created by SHANGYINTONG on 15/4/30.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseViewController.h"
#import "UploadPhotoDO.h"


@interface TakeBankCardPhotoViewController : BaseViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UploadPhotoDelegate>

@property (nonatomic,strong) NSString *money;
@end
