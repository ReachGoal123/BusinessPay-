//
//  FateListDO.h
//  BusinessPay
//
//  Created by SHANGYITONG on 15-2-28.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseModel.h"


@protocol FateListDelegate;

@interface FateListDO : BaseModel

@property (nonatomic,assign) id <FateListDelegate> delegate;

@property (nonatomic,strong) NSMutableArray *temArr;

@property (nonatomic,strong) NSString *feeRateNO; //费率ID
@property (nonatomic,strong) NSString *feeRate;  //费率
@property (nonatomic,strong) NSString *feeRateDesc; //描述
@property (nonatomic,strong) NSString *price; //价格


//@property (nonatomic,strong) NS

-(void) fateListInquaryRequest;

@end



@protocol FateListDelegate <NSObject>

- (void)fateListInquarySuccessWithMessage:(NSString *)message;

- (void)fateListInquaryFieldWithMessage:(NSString *)message;


- (void)fateListInquarySuccessWithMessage:(NSString *)message andArr:(NSMutableArray*)arr;


@end