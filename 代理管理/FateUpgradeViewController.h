//
//  FateUpgradeViewController.h
//  BusinessPay
//
//  Created by zm on 8/5/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseViewController.h"
#import "FateListDO.h"

@interface FateUpgradeViewController : BaseViewController<FateListDelegate>

@property(nonatomic,strong)IBOutlet UIButton *accountShengji; //钱包升级

@property(nonatomic,strong)IBOutlet UIButton *codeShengji; //激活码升级

@property(nonatomic,strong)IBOutlet UILabel *currentFateLabel; //激活码升级

@property(nonatomic,strong)IBOutlet UIButton *upgradeButton; //激活码升级

@property (nonatomic,strong) FateListDO *fateListDO;

@property (nonatomic,strong) NSMutableArray *fateArr;


-(IBAction)selectorUpgradeButton:(id)sender;

@end
