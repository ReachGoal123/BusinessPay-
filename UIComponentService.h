//
//  UIComponentService.h
//  BccClient
//
//  Created by Apple on 12-10-5.
//  Copyright (c) 2012年 Straw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"


@interface UIComponentService : NSObject <UIAlertViewDelegate> {

}

+ (UIComponentService *)getInstance;

@property(nonatomic, assign) NSInteger bgimgIndex;

+ (void)showNoStatusHud;

+ (void)showSuccessHudWithStatus:(NSString *)message;

+ (void)showFailHudWithStatus:(NSString *)message;

+ (void)showFailHudWithStatus:(NSString *)message duration:(NSTimeInterval)duration ;

+ (void)showHudWithStatus:(NSString *)status;

+ (void)dismissHudView;

+ (void)dismissHudSuccess;

+ (void)showMessageAlertView:(NSString *)title message:(NSString *)message;

+ (void)showSimpleToast:(NSString *)message;

@end
