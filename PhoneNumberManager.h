//
//  PhoneNumberManager.h
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-19.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PhoneNumberInfo;


@interface PhoneNumberManager : NSObject

//- (NSArray *) getAllPhoneNumber;
- (void) addContact:(PhoneNumberInfo *) phone error:(NSError **)error;
- (void) updateContact:(PhoneNumberInfo *) phone error:(NSError **)error;
- (void) deleteContact:(PhoneNumberInfo *) phone error:(NSError **)error;

@end
