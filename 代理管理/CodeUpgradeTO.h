//
//  CodeUpgradeTO.h
//  BusinessPay
//
//  Created by SHANGYINTONG on 15/5/11.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol CodeUpgradeTODelegate;

@interface CodeUpgradeTO : BaseModel

@property (nonatomic, assign) id <CodeUpgradeTODelegate> delegate;

@property (nonatomic, copy) NSString * trancode;

@property (nonatomic, copy) NSString * userTelephone;

@property (nonatomic, copy) NSString * upgradeType;

@property (nonatomic, copy) NSString * userCode;

@property(nonatomic,strong)NSString *responseCode;

@property(nonatomic,strong)NSString *responseMessage;

-(void)CodeUpgradeTORequset;

@end


@protocol CodeUpgradeTODelegate <NSObject>

- (void)CodeUpgradeTOSuccessWithMessage: (NSString *)message;

- (void)CodeUpgradeTOFildWithMessage: (NSString *)message;

@end