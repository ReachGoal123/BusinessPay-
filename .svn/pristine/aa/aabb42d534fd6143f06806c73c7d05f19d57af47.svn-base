//
//  DataBase.m
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-19.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "DataBase.h"

@implementation DataBase

+(void)createDataBaseIfNotExists{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:[self filename]]) {
        return;
    }
    
    //组装数据库初始化SQL语句
    NSMutableString *init_sqls=[NSMutableString stringWithCapacity:1024];
    //创建表SQL语句
    [init_sqls appendFormat:@"CREATE TABLE Phone(phone_id INTEGER PRIMARY KEY,phone TEXT);"];
    
    SqliteDatabase *db=[[SqliteDatabase alloc] initWithFilename:[self filename]];
    
    int r=[db executeNonQuery:init_sqls error:nil];
    if (r != SQLITE_OK) {
        [fileManager removeItemAtPath:[self filename] error:nil];
    }
}

+ (NSString *)filename{
    return [NSString stringWithFormat:@"%@/Documents/db.sqlite1",NSHomeDirectory()];
}

+(DataBase *)shareDatabase{
    static id db=nil;
    if(db==nil){
        db=[[DataBase alloc] init];
    }
    return db;
    
}

- (id)init{
    self=[super init];
    if (self) {
        _sqliteDataBase=[[SqliteDatabase alloc] initWithFilename:[[self class] filename]];
    }
    return self;
}

@end