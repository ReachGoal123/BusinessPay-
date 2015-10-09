//
//  RadingParticularViewController.h
//  BusinessPay
//
//  Created by SHANGYINTONG on 15-4-8.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseViewController.h"
#import "RadingParticularsDO.h"

@interface RadingParticularViewController : BaseViewController <RadingParticularsDelegate>

@property (nonatomic,strong) NSString *algno;

@property (nonatomic,strong) RadingParticularsDO *radingParticularDO;


@end
