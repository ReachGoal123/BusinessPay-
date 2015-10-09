//
//  PayViewController.h
//  BusinessPay
//
//  Created by Tears on 14-4-24.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MerchantDO.h"
#import "AccountDO.h"
#import "LoginDO.h"
#import "ZBarSDK.h"
#import "PayPhonemoneyDO.h"
#import "ImagePlayerView.h"


@interface PayViewController : BaseViewController<UIScrollViewDelegate, MerchantInformationInquiryDelegate,AccountDelegate,LoginRequestDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,ZBarReaderDelegate,payPhoneMoneyDelegate,ImagePlayerViewDelegate>
{

    NSTimer *myTimer;             //定时器 (首页图片)
    
    int num;
    BOOL upOrdown;
    NSTimer *timer;    //（扫描二维码定时器）
}

@property (nonatomic,strong) NSString *merchantNum;

@property (nonatomic,strong) AccountDO *accountDO;

@property (nonatomic,strong) LoginDO *loginDO;

@property (nonatomic,strong) MerchantDO * merchantDO;

@property (nonatomic,strong) PayPhonemoneyDO *payPhoneMoneyDo;

@property (nonatomic,strong) IBOutlet UIScrollView *uiScrollView;

@property (nonatomic,strong) IBOutlet UIPageControl *pageControl;

@property (nonatomic,strong) IBOutlet UIScrollView *myScrollView;

@property (nonatomic,strong) IBOutlet ImagePlayerView *imagePlayerView;

@property (nonatomic,strong) NSString *stringValueBefore;

@property (nonatomic,strong) NSString *stringValueBehind;


@property (nonatomic,strong) UIAlertView *needAddAlertView;
@property (nonatomic,strong) UIAlertView *phoneNumberChangeAlertView;
@property (nonatomic,strong) UIAlertView *addSuccessAlertView;
@property (nonatomic,strong) UIAlertView *addFieldAlertView;
@property (nonatomic,strong) UIAlertView *getOutAlertView;
@property (nonatomic,strong) UIAlertView *reChangeAlertView;



@property (nonatomic,strong) NSString *loginMessage;     //登录返回信息




@property (nonatomic,strong) UIImageView *line;   //扫描二维码平移的线

@property(nonatomic,strong) UITextView *outputTextView;



@end
