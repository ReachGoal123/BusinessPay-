//
//  TerMInalViewController.m
//  BusinessPay
//
//  Created by SHANGYITONG on 15-1-6.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "TerMInalViewController.h"

@implementation TerMInalViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH,20)];
    imageView.image = [UIImage imageNamed:@"titleNew.png"];
    [self.view addSubview:imageView];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleNew.png"] forBarMetrics:UIBarMetricsDefault];
    
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbackground"] forBarMetrics:UIBarMetricsD
    
    [_bookImageView setMultipleTouchEnabled:YES];
    [_bookImageView setUserInteractionEnabled:YES];
    //[_bookImageView setImage:[UIImage imageNamed:@"1.jpg"]];
    
    
    oldFrame = _bookImageView.frame;
    largeFrame = CGRectMake(0 - oldFrame.size.width, 0 - oldFrame.size.height, 3 * oldFrame.size.width, 3 * oldFrame.size.height);
    
    [self addGestureRecognizerToView:_bookImageView];
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"资质证书"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
}


- (void) addGestureRecognizerToView:(UIView *)view
{
    // 缩放手势
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [view addGestureRecognizer:pinchGestureRecognizer];
    
    //移动手势
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [view addGestureRecognizer:panGestureRecognizer];
    
    
}

- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIView *view = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
}

- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIView *view = pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        if (_bookImageView.frame.size.width < oldFrame.size.width) {
            _bookImageView.frame = oldFrame;
            //让图片无法缩得比原图小
        }
        if (_bookImageView.frame.size.width > 3 * oldFrame.size.width) {
            _bookImageView.frame = largeFrame;
        }
        pinchGestureRecognizer.scale = 1;
    }  }


- (void) handlePinch:(UIPinchGestureRecognizer*) recognizer
{
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    
    recognizer.scale = 1;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

