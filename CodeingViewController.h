//
//  CodeingViewController.h
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-4.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "BaseViewController.h"

@interface CodeingViewController : BaseViewController


@property (nonatomic,weak) IBOutlet UIImageView *imageView;

@property (nonatomic,weak) IBOutlet UILabel *nameLabel;

@property (nonatomic,copy) NSString *codeContent;

@property (nonatomic,copy) NSString *name;

@end
