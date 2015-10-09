//
//  MerchantInfo.m
//  BusinessPay
//
//  Created by SHANGYITONG on 14-12-22.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "MerchantInfo.h"

static MerchantInfo *merchantInfo;

@implementation MerchantInfo

@synthesize merchantNum;


bool isFromSelf=NO;

+(id)stringManager
{
    if(merchantInfo==nil)
    {
        isFromSelf=YES;
        merchantInfo=[[MerchantInfo alloc] init];
        
        isFromSelf=NO;
    }
    return merchantInfo;
}



+(id)alloc
{
    if(isFromSelf)
    {
        return [super alloc] ;
    }
    else
    {
        return nil;
    }
}


@end
