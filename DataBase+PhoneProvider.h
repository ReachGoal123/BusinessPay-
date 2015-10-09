//
//  DataBase+PhoneProvider.h
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-19.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "DataBase.h"
@class PhoneNumberInfo;


@interface DataBase (PhoneProvider)

- (NSArray *) getAllPhoneNumber;
-(int) insertPhoneNumber:(PhoneNumberInfo *) phone error:(NSError **)error;
- (int) updateContact:(PhoneNumberInfo *) phone error:(NSError **)error;
- (int) deleteContact:(PhoneNumberInfo *) phone error:(NSError **)error;

@end
