//
//  DetailTableViewController.h
//  BusinessPay
//
//  Created by Tears on 14-4-11.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProvinceDO.h"
#import "CityDO.h"
#import "SubbranchDO.h"

@protocol shareProvinceMessageDelegate;

@interface DetailTableViewController : UITableViewController

@property (nonatomic, strong)NSMutableArray * searchResults;
@property (nonatomic, strong)NSMutableArray * dataSourceArr;
@property (nonatomic, strong)NSMutableArray * PCSArr;
@property (nonatomic, strong)NSMutableArray * PCSPinYinArr;
@property (nonatomic, strong)NSMutableDictionary * dataSourceDic;
@property (nonatomic, assign)int dataSourceType;
@property (nonatomic, assign)id <shareProvinceMessageDelegate>delegate;

@end

@protocol shareProvinceMessageDelegate <NSObject>

- (void) didSelectProvince: (ProvinceDO *)provinceDO;

- (void) didSelectCity: (CityDO *)cityDO;

- (void) didSelectSubbranch: (SubbranchDO *)subbranchDO;


@end