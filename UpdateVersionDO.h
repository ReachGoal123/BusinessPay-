//
//  UpdateVersionDO.h
//  BusinessPay
//
//  Created by SHANGYINTONG on 15-4-2.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseModel.h"


@protocol updateVersionDelegate;
@interface UpdateVersionDO : BaseModel

@property (nonatomic, assign) id <updateVersionDelegate> delegate;

@property (nonatomic,strong)NSString *isUpdate;
@property (nonatomic,strong)NSString *updateUrl;


- (void)updateRequest;


@end


@protocol updateVersionDelegate <NSObject>

-(void) updateSuccessWithMessage:(NSString *)message withUpdateVersion:(UpdateVersionDO *) updateDO;
-(void) updateFeildWithMessage:(NSString *)message;



@end