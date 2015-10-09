//
//  BaseModel.h
//  BusinessPay
//
//  Created by Tears on 14-4-8.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "GDataXMLNode.h"
@class User;

@interface BaseModel : NSObject<ASIHTTPRequestDelegate>

BOOL isNumber (char ch);
@property (nonatomic , strong) User * user;
@property (nonatomic , copy) NSString * termno;
@property (nonatomic , copy) NSString * termType;
@property (nonatomic , copy) NSString * trancode;
@property (nonatomic , copy) NSString * phoneNumber;
@property (nonatomic , copy) NSString * appType;


+ (NSString *)XMLStringFromDic :(NSMutableDictionary *)dic;

+ (NSString *)randomString;

- (NSString *)appendPospURL:(NSString *)trancode;

- (NSString *)appendPosmURL:(NSString *)trancode;

- (NSString *)appendPosm5URL:(NSString *)trancode;

- (NSString *)stringFromNSdata: (NSData *)tempData;

- (NSString *)appendPayURL:(NSString *)trancode;

- (NSString *)appendPosm7URL: (NSString *) trancode;

- (NSString *)appendPosmUploadURL:(NSString *)trancode;

// phoneNumber
+ (BOOL) isValidPhone:(NSString*)value;

// IDcard
+ (BOOL) Chk18PaperId :(NSString *)sPaperId;

+(BOOL) checkCardNo:(NSString*) cardNo;

+ (BOOL)isChineseName:(NSString *)name;

+ (NSString *)statusString:(NSString *)str;

+ (NSString *)deleteBlankFromString: (NSString *)string;

@end
