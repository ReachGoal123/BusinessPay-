//
//  CodeListTableViewController.m
//  BusinessPay
//
//  Created by zm on 7/5/15.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "CodeListTableViewController.h"
#import "CodeActivationListCell.h"

@interface CodeListTableViewController ()

@end

@implementation CodeListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundimage"]];
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"已生成的激活码"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.codeArr.count ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor whiteColor];  //隐藏cell的线
    
    CodeActivationListCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"codeCell" forIndexPath:indexPath];
    
   _codeImformation = [self.codeArr objectAtIndex:indexPath.row];
    cell.codeLabel.text = self.codeImformation.activCode;
    
    
//    cell.codeUserDateLabel.text = self.codeImformation.kaishiTime;
    
    NSString *newTimeStr = [self timeNowString:self.codeImformation.kaishiTime];
    
    NSLog(@"newTimeStr-----%@",newTimeStr);
    
    return cell;
}


- (NSString *)timeNowString:(NSString*)timestr
{
     NSString* string = timestr;
    
    NSLog(@"string-----%@",string);
 
    NSDateFormatter* dateformatter = [[NSDateFormatter alloc] init];
    
     [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
     NSDate *inputDate = [dateformatter dateFromString:string];
    
    NSString *dateString = [dateformatter stringFromDate:inputDate];
    
    NSLog(@"dateString----%@",dateString);
    
    return dateString;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
