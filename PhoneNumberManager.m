//
//  PhoneNumberManager.m
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-19.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "PhoneNumberManager.h"
#import "DataBase+PhoneProvider.h"
#import "PhoneNumberInfo.h"

@interface PhoneNumberManager()
{
    DataBase *_database;
}

@end

@implementation PhoneNumberManager

-(instancetype)init
{
    if (self=[super init]) {
        _database=[DataBase shareDatabase];
    }
    return self;
}


-(void)addContact:(PhoneNumberInfo *)phone error: (NSError *__autoreleasing *)error
{
    [_database insertPhoneNumber:phone error:error];
}

-(void)updateContact:(PhoneNumberInfo *)phone error:(NSError *__autoreleasing *)error
{
    [_database updateContact:phone error:error];
    [_database deleteContact:phone error:error];
}

-(void)deleteContact:(PhoneNumberInfo *)phone error:(NSError *__autoreleasing *)error
{
    [_database deleteContact:phone error:error];
}

@end
