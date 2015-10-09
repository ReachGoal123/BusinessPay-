//
//  AccountViewController.m
//  BusinessPay
//
//  Created by Tears on 14-4-16.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "AccountViewController.h"
#import "RealNameVerificationViewController.h"
#import "LLLockViewController.h"
#import "MyCircleViewController.h"
#import "LoginViewController.h"
#import "User.h"

@interface AccountViewController ()
{
     LLLockViewType lockViewtype;
}

@property (nonatomic,strong) UIAlertView *clearAlertView;
@property (nonatomic,strong) UIAlertView *myAlterView;
@property (nonatomic,strong) UIAlertView *reChangeAlertView;
@property (nonatomic,strong) MyCircleDO *myCircleDO;
@property (nonatomic,strong) LoginViewController *loginVC;

@property (nonatomic,strong) NSMutableArray *temArr;

@property (nonatomic,weak) IBOutlet UIButton *gesButton;
@property (nonatomic,weak) IBOutlet UIButton *myCircleButton;

-(IBAction)accountManagerAction:(id)sender;
-(IBAction)myCircleAction:(id)sender;
-(IBAction)fateBuyAction:(id)sender;
-(IBAction)resetGerPasswordAction:(id)sender;
-(IBAction)accountGetout:(id)sender;
-(IBAction)managemenAction:(id)sender;

@property (nonatomic,weak) IBOutlet UIButton *managemenButton;

@end

@implementation AccountViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
   
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title"] forBarMetrics:UIBarMetricsDefault];
    
    
    UIImage *title_bg = [UIImage imageNamed:@"titleNew.png"];  //获取图片
    CGSize titleSize = self.navigationController.navigationBar.bounds.size;  //获取Navigation Bar的位置和大小
    title_bg = [self scaleToSize:title_bg size:titleSize];//设置图片的大小与Navigation Bar相同
    [self.navigationController.navigationBar
     setBackgroundImage:title_bg
     forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = YES;
}
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"presentToLockViewSegue"]) {
        LLLockViewController *lllockVC=(LLLockViewController *)segue.destinationViewController;
        
        lllockVC.nLockViewType=LLLockViewTypeCreate;
    }
    if ([segue.identifier isEqualToString:@"toMycircleSegue"]) {
        MyCircleViewController *mycircleVC=(MyCircleViewController *)segue.destinationViewController;
        mycircleVC.temArr=_temArr;
    }
    
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"钱海钱包"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    
    User *user = [User shareUser];
    
    if ([user.currolstr isEqualToString:@"0"]) {
        self.agentButton.hidden = YES;
    }

    _temArr=[NSMutableArray arrayWithCapacity:1024];
    self.loginVC =[[LoginViewController alloc] init];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleNew.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    
    if ([User shareUser].status ==2 ||[User shareUser].status==1) {
        [self.myCircleButton setHidden:YES];
        [self.gesButton setHidden:YES];
    }
    if ([[User shareUser].identity isEqualToString:@"1"]) {
        [self.gesButton setUserInteractionEnabled:NO];
        [self.gesButton setAlpha:0.5f];
    }
    
   // [self.managemenButton removeFromSuperview];
    
}

-(IBAction)accountManagerAction:(id)sender{
    if ([User shareUser].reChangeStutas==1) {
        _reChangeAlertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"尊敬的用户，请先充值再操作" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [_reChangeAlertView show];
    }else{
    [self performSegueWithIdentifier:@"personCenter" sender:self];
    }
}
-(IBAction)myCircleAction:(id)sender{
    
    if ([User shareUser].reChangeStutas==1) {
        _reChangeAlertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"尊敬的用户，请先充值再操作" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [_reChangeAlertView show];
    }else{
    
    [UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(mycircleRequest) withObject:nil afterDelay:kDelayTime];
    }
}


//点击代理管理按钮
-(IBAction)managemenAction:(id)sender{
    
    
    
     User *user = [User shareUser];
    
    if ([user.currolstr isEqualToString:@"0"]) {
        [UIComponentService showSuccessHudWithStatus:@"您暂时还不是钱海钱包的代理商,请先升级为代理!"];
    }else{
    
    AgentInformationQuery *agentimformationquery = [[AgentInformationQuery alloc]init];
    agentimformationquery.delegate = self;
    agentimformationquery.trancode = @"701197";
    agentimformationquery.LoginPhoneNum = user.phoneNumber;
    agentimformationquery.agentNumber = user.agentNumber;
    [agentimformationquery AgentInformationQueryRequest];
    }
}


- (void)AgentInformationQuerySuccessWithMessage: (NSString *)message{
    
    [UIComponentService showSuccessHudWithStatus:message];
    
    [self performSegueWithIdentifier:@"managenmentSegue" sender:self];
}

- (void)AgentInformationQueryFildWithMessage: (NSString *)message{
     [UIComponentService showSuccessHudWithStatus:message];

}

-(void) mycircleRequest
{
    _myCircleDO=[[MyCircleDO alloc] init];
    _myCircleDO.delegate=self;
    _myCircleDO.trancode=kTrancode_MyCircle;
    _myCircleDO.phoneNumber=[User shareUser].phoneNumber;
    _myCircleDO.numPerPage=kInquiryCurrentPage;
    _myCircleDO.numPerPage=kInquiryNumber;
    
    [_myCircleDO myCircleRequest];
    
}


-(IBAction)fateBuyAction:(id)sender{
    
    //pushToOrderPaySegue
    if ([User shareUser].reChangeStutas==1) {
        _reChangeAlertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"尊敬的用户，请先充值再操作" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [_reChangeAlertView show];
    }else{
     [self performSegueWithIdentifier:@"fateSegue" sender:self];
    }
}
-(IBAction)resetGerPasswordAction:(id)sender{
    
    if ([User shareUser].reChangeStutas==1) {
        _reChangeAlertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"尊敬的用户，请先充值再操作" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [_reChangeAlertView show];
    }else{
    
    self.clearAlertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否要清空手势图？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [self.clearAlertView show];
    }
}
-(IBAction)accountGetout:(id)sender{
    self.myAlterView=[[UIAlertView alloc] initWithTitle:nil message:@"确定退出?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [self.myAlterView show];

}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView==self.myAlterView)
        {
            if (buttonIndex==0) {
                return;
            }
            else
            {
//                lockViewtype=LLLockViewTypeCreate;
//                [LLLockPassword saveLockPassword:nil];
//                [self.loginVC savePhoneNumber:nil andPassword:nil];
                [self performSegueWithIdentifier:@"perSonToLoginSegue" sender:self];
            }
        }else if (alertView==self.reChangeAlertView)
        {
            [self performSegueWithIdentifier:@"pushToOrderPaySegue" sender:self];
        }
        else
        {
            if (buttonIndex==0) {
                return;
            }else
            {
                lockViewtype=LLLockViewTypeCreate;
                [LLLockPassword saveLockPassword:nil];
                //[self.loginVC savePhoneNumber:nil andPassword:nil];
                [UIComponentService showSuccessHudWithStatus:@"手势密码已清空，请重新输入手势密码"];
                
                [self performSegueWithIdentifier:@"presentToLockViewSegue" sender:self];
                
            }
    }

}


#pragma mark--- mycircleDelegate



-(void)myCircleRequestSuccessWithMessage:(NSString *)message andArr:(NSMutableArray *)arr
{
    [UIComponentService showSuccessHudWithStatus:nil];
    _temArr=arr;
    [self performSegueWithIdentifier:@"toMycircleSegue" sender:self];
    
}


-(void)myCircleRequestFieldWithMessage:(NSString *)message
{
    [UIComponentService showFailHudWithStatus:message];
}


@end
