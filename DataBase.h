//
//  DataBase.h
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-19.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SqliteDatabase.h"


@interface DataBase : NSObject{
    SqliteDatabase *_sqliteDataBase;
}

+(DataBase *)shareDatabase;
+(void) createDataBaseIfNotExists;
+(NSString *)filename;

@end
