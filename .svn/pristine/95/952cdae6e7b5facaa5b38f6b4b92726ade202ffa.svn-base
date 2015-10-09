//
//  DataBase+PhoneProvider.m
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-19.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "DataBase+PhoneProvider.h"
#import "PhoneNumberInfo.h"

@implementation DataBase (PhoneProvider)


-(NSArray *)getAllPhoneNumber
{
    NSString *sql=@"SELECT phone_id,phone FROM Phone";
    [_sqliteDataBase open];
    SqliteDataReader *dr=[_sqliteDataBase executeQuery:sql];
    NSMutableArray *items=[NSMutableArray array];
    PhoneNumberInfo *item;
    
    while ([dr read]) {
        item=[[PhoneNumberInfo alloc] init];
        item.oid=[dr integerValueForColumnIndex:0];
        item.phoneNumber=[dr stringValueForColumnIndex:1];
        
        [items addObject:item];
    }
    [_sqliteDataBase close];
    return items;
    
}

-(int)insertPhoneNumber:(PhoneNumberInfo *)phone error:(NSError *__autoreleasing *)error
{
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO Phone(phone) VALUES('%@')",phone.phoneNumber?phone.phoneNumber:@""];

    int lastRowId;
    int rc=[_sqliteDataBase executeNonQuery:sql outputLastInsertRowId:&lastRowId error:error];
    if (rc==SQLITE_OK) {
        phone.oid=lastRowId;
    }
    return rc;
    
}


-(int)updateContact:(PhoneNumberInfo *)phone error:(NSError *__autoreleasing *)error
{
    NSString *sql=[NSString stringWithFormat:@"UPDATE Phone SET phone='%@' WHERE phone_id=%i ",phone.phoneNumber,phone.oid];
    
    int rc=[_sqliteDataBase executeNonQuery:sql error:error];
    return rc;
    
}

-(int)deleteContact:(PhoneNumberInfo *)phone error:(NSError *__autoreleasing *)error
{
    NSString *sql=[NSString stringWithFormat:@"DELETE FROM Phone WHERE phone_id=%i",phone.oid];
    int rc=[_sqliteDataBase executeNonQuery:sql error:error];
    return rc;
}



@end
