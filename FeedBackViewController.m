//
//  FeedBackViewController.m
//  BusinessPay
//
//  Created by SHANGYINTONG on 15/5/4.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()
@property (nonatomic,weak) IBOutlet UIView *myView;
@property (nonatomic,weak) IBOutlet UITextView * textView;
@property (nonatomic,weak) IBOutlet UITextField *contactwayTextFeild;
-(IBAction)submitAction:(id)sender;

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.textView setDelegate:self];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH,20)];
    imageView.image = [UIImage imageNamed:@"titleNew.png"];
    [self.view addSubview:imageView];
    self.myView.backgroundColor=[UIColor colorWithWhite:0.95f alpha:0.9f];
    
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"反馈消息"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    // Do any additional setup after loading the view.
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    NSRange range;
    range.location = 0;
    range.length = 0;
    textView.selectedRange = range;
}


-(void)submitAction:(id)sender
{
    [UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(feedBAckRequest) withObject:nil afterDelay:kDelayTime];
}



-(void)feedBAckRequest
{
 
    FeedBackDO *feedBackDO=[[FeedBackDO alloc] init];
    feedBackDO.delegate=self;
    feedBackDO.trancode=kTrancode_feedBack;
    feedBackDO.phoneNumber=[User shareUser].phoneNumber;
    feedBackDO.contactName=@"mao";
    feedBackDO.contactType=@"1";
    feedBackDO.content=self.textView.text;
    feedBackDO.email=self.contactwayTextFeild.text;
    
    
    [feedBackDO feedBackRequest];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)feedBackRequestSuccessWithMessage:(NSString *)message{
    [UIComponentService showSuccessHudWithStatus:message];
    
}


-(void)feedBackRequestFeildWithMessage:(NSString *)message
{
    [UIComponentService showFailHudWithStatus:message];
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
