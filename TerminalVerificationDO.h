//
//  TerminalVerificationDO.h
//  BusinessPay
//
//  Created by Tears on 14-4-17.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "BaseModel.h"

@protocol TerminalVerificationDelegate;

@interface TerminalVerificationDO : BaseModel

@property (nonatomic , assign)id <TerminalVerificationDelegate>delegate;
@property (nonatomic , copy)NSString *userLoginName;

- (void)terminalVerificationRequest;

@end

@protocol TerminalVerificationDelegate <NSObject>

- (void)terminalVerificationResponseScuess;

- (void)terminalVerificationFieldWithMessage:(NSString *)message;

@end