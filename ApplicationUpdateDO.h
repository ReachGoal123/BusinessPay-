//
//  ApplicationUpdateDO.h
//  BusinessPay
//
//  Created by Tears on 14-4-17.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "BaseModel.h"

@interface ApplicationUpdateDO : BaseModel

@property (nonatomic ,copy)NSString * applicationName;

- (void)applicationUpdateRequest;

@end
