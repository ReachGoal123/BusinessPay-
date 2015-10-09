//
//  withDrawSuccessViewController.m
//  BusinessPay
//
//  Created by SHANGYITONG on 15-3-12.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "withDrawSuccessViewController.h"

@interface withDrawSuccessViewController ()

@property (nonatomic,weak) IBOutlet UILabel * timeLabel;
@property (nonatomic,weak) IBOutlet UILabel * cardTypeLabel;
@property (nonatomic,weak) IBOutlet UILabel * bankLabel;
@property (nonatomic,weak) IBOutlet UILabel * cardNoLabel;
@property (nonatomic,weak) IBOutlet UILabel * moneyLabel;

-(IBAction)finishAction:(id)sender;

@end

@implementation withDrawSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bankLabel.text=self.accountDO.bankName;
    //NSLog(@"%@",self.accountDO.bankName);
    //NSLog(@"%@",self.accountDO.bindCard);
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleNew.png"] forBarMetrics:UIBarMetricsDefault];
    NSString *bindCard=[self.accountDO.bindCard substringWithRange:NSMakeRange(self.accountDO.bindCard.length-4, 4)];
    if (self.buttonIndex==0) {
        //NSDate* now = [NSDate date];
        NSDate *tomorrow = [NSDate dateWithTimeIntervalSinceNow:+(24*60*60)];
        NSCalendar *cal = [NSCalendar currentCalendar];
        
        unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit;
        NSDateComponents *dd = [cal components:unitFlags fromDate:tomorrow];
       
        
        int y = [dd year];
        int m = [dd month];
        int d = [dd day];
        
        self.timeLabel.text=[NSString stringWithFormat:@"预计%i-%i-%i 23:59:00前到账",y,m,d];

        
    }else
    {
        self.timeLabel.text=@"预计5分钟内到账";
    }
    
    self.cardNoLabel.text=[NSString stringWithFormat:@"尾号%@",bindCard];
    if([self.accountDO.typeCard isEqualToString:@"01"])
    {
        self.cardTypeLabel.text=@"借记卡";
    }else
    {
        self.cardTypeLabel.text=@"贷记卡";
    }
    
    
    float money=[self.money floatValue];
    
    self.moneyLabel.text=[NSString stringWithFormat:@"%.2f元",money];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)finishAction:(id)sender{
    [self performSegueWithIdentifier:@"withDrawSuccessSegue" sender:self];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
