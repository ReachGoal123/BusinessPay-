//
//  AgentCell.h
//  BusinessPay
//
//  Created by zm on 29/4/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgentCell : UITableViewCell




@property(weak, nonatomic)IBOutlet UILabel *agentName;
@property(weak, nonatomic)IBOutlet UILabel *agentPhoneNum;
@property(weak, nonatomic)IBOutlet UILabel *costFate;
@property(weak, nonatomic)IBOutlet UILabel *numbers;

@property(weak, nonatomic)IBOutlet UILabel *agentID;



@end
