//
//  ProtocolViewController.m
//  BusinessPay
//
//  Created by Tears on 14-5-15.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "ProtocolViewController.h"

@interface ProtocolViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ProtocolViewController

-(void)viewDidAppear:(BOOL)animated{
    
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.editable=NO;
    
    CGFloat topCo = (self.textView.bounds.size.height-self.textView.contentSize.height);
    topCo = (topCo <0.0?0.0:topCo);
    self.textView.contentOffset = (CGPoint){.x = 0,.y= -topCo/2};
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleNew.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    
    
    
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"使用条款"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    
}

//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
//{
//    if([textView isFirstResponder]){
//        return YES;
//    }
//    return NO;
//}

- (IBAction)doneAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
