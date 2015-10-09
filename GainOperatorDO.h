//
//  GainOperatorDO.h
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-18.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseModel.h"

@interface GainOperatorDO : BaseModel

-(NSString *)getOperatorRequest:(NSString *)webServiceURL withGainCode:(NSString *)phoneNumber paramName:(NSString *)phoneNumberValue;

@end
