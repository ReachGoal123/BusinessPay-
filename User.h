//
//  User.h
//  BusinessPay
//
//  Created by Tears on 14-4-8.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property(nonatomic ,copy)NSString *passWord;
@property(nonatomic, copy)NSString *IDcard;
@property(nonatomic ,copy)NSString * termno;
@property(nonatomic ,copy)NSString * phoneNumber;            //登录时手机号码
@property(nonatomic ,copy)NSString * merchantNum;
@property(nonatomic ,copy)NSString * userName;               //用户姓名
@property (nonatomic , copy)NSString * nocCardFeeRete;
@property (nonatomic , copy)NSString * agentNumber;  //代理商编号
@property(nonatomic ,copy)NSString *currolstr;

@property(nonatomic ,copy)NSString *loginType;



//代理商管理
@property(nonatomic,strong)NSString *numberHasUsed; //已使用数量

@property(nonatomic,strong)NSString *currentYield; //当前收益

@property(nonatomic,strong)NSString *totalYield;   //累计收益

@property(nonatomic,strong)NSString *minimumRate;  //最小费率

@property(nonatomic,strong)NSString *maxRate; //最大费率

@property(nonatomic,strong)NSString *nocaragTeyp; //等级

@property(nonatomic,strong)NSString *agentName; //商户名

@property(nonatomic,strong) NSString *upminFate;//修改下级代理最低费率


//激活码管理
@property(nonatomic,strong)NSString *yijihuo;

@property(nonatomic,strong)NSString *yishengcheng;

@property(nonatomic,strong)NSString *weishengcheng;

@property(nonatomic,strong)NSString *yihuabo;



//@property (nonatomic,copy) NSString *registerPhoneNumber;    //注册时手机号码
@property (nonatomic,copy) NSString *ProvinceName;
@property (nonatomic,copy) NSString *cityName;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *bankCard;
@property (nonatomic,copy) NSString *bankName;     




@property(nonatomic ,assign)int verificationStatus;
@property(nonatomic ,assign)int status;
@property (nonatomic,assign)int reChangeStutas;         //第一次充值状态 0成功 1失败

@property(nonatomic ,assign)int loginNum;

@property (nonatomic,assign) int idcardSts;          //实名认证
@property (nonatomic,assign) int senceSts;
@property (nonatomic,assign) int  bankCardSts;



@property(nonatomic,assign) BOOL bankCardChange;
@property(nonatomic,assign) BOOL phoneNumberChange;


@property (nonatomic,strong) NSString *appUserID;                  //推送时需要传的user_id  和 channel_id
@property (nonatomic,strong) NSString *appChannelID;


@property (nonatomic,strong) NSString *identity;          //是否有设置手势密码标识；


@property (nonatomic,strong) NSString *pushType;
@property (nonatomic,strong) NSString *businessType;
@property (nonatomic,strong) NSString *markStutas;
@property (nonatomic,strong) NSString *pushData;


+ (User *)shareUser;

- (NSString *)encrypt:(NSMutableDictionary *)xmlDic;

- (NSString *)decrypt:(NSString *)responseString;

//- (NSString *)realNameEncrypt:(NSMutableDictionary *)xmlDic;

@end
