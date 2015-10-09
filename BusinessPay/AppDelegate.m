//
//  AppDelegate.m
//  BusinessPay
//
//  Created by Tears on 14-4-1.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "AppDelegate.h"
#import "LockViewController.h"
#import "PayViewController.h"
#import "LLLockViewController.h"
#import "RealNameVerificationViewController.h"
#import "DataBase.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"



@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [UMSocialData setAppKey:@"5569729067e58e402f007b48"];
    
    [UMSocialWechatHandler setWXAppId:@"wx504be3bb18c9dee4" appSecret:@"289893ba8532e2968a9694ad45f601a1" url:@"https://download.qhno1.com/down.html"];
    
    [UMSocialQQHandler setQQWithAppId:@"1104231525" appKey:@"dX6nQwFwj93nC0t9" url:@"https://download.qhno1.com/down.html"];

    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 100)];
    imageView.image = [UIImage imageNamed:@"titleNew.png"];
    [self.window addSubview:imageView];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"title"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:225/255.f green:225/255.f blue:225/255.f alpha:1]];
    
    
    // iOS8 下需要使用新的 API
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }

//     #warning 上线 AppStore 时需要修改 pushMode   z0sIou4Z9vDGDs4cSbtNaLqC（生产挨apiKey）
//     在 App 启动时注册百度云推送服务,需要提供 Apikey   fr3Gtub7cEGREfi71lGRO9k3（测试apikey）
//    [BPush registerChannel:launchOptions apiKey:@"z0sIou4Z9vDGDs4cSbtNaLqC" pushMode:BPushModeDevelopment isDebug:NO];
    
    [BPush registerChannel:launchOptions apiKey:@"z0sIou4Z9vDGDs4cSbtNaLqC" pushMode:BPushModeProduction withFirstAction:nil withSecondAction:nil withCategory:nil isDebug:YES];
    // 设置 BPush 的回调
   // [BPush setDelegate:self];
   //  App 是用户点击推送消息启动
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        NSLog(@"从消息启动:%@",userInfo);
        [BPush handleNotification:userInfo];
    }

    //角标清0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
  // [self performSelector:@selector(testLocalNotifi) withObject:nil afterDelay:1.0];
    
    return YES;
} 



 //在 iOS8 系统中，还需要添加这个方法。通过新的 API 注册推送服务
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    
    [application registerForRemoteNotifications];
    
    
}


-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"test:%@",deviceToken);
    [BPush registerDeviceToken:deviceToken];
    [BPush bindChannelWithCompleteHandler:^(id result, NSError *error) {
        
        [User shareUser].appChannelID=[result objectForKey:@"channel_id"];
        [User shareUser].appUserID=[result objectForKey:@"user_id"];
        
        NSLog(@"userid=%@,channelID=%@",[User shareUser].appUserID,[User shareUser].appChannelID);
        
    }];
}



-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{

    NSLog(@"userInfo==%@",userInfo);
    
    NSString *jsonData=[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] ;
    NSLog(@"数据=%@",jsonData);
    [User shareUser].pushData=jsonData;
    
    NSString *push_type=[userInfo objectForKey:@"push_type"];
    NSLog(@"push_type=%@",push_type);
    [User shareUser].pushType=push_type;
    
    NSString *business_type=[userInfo objectForKey:@"business_type"];
    NSLog(@"business_type = %@",business_type);
    [User shareUser].businessType=business_type;
    
    NSString *mark_status=[userInfo objectForKey:@"mark_status"];
    
    NSLog(@"mark_stutas=%@",mark_status);
    [User shareUser].markStutas=mark_status;
        [BPush handleNotification:userInfo];
    

//    [BPush localNotification:[NSDate date] alertBody:jsonData badge:-1 withFirstAction:@"打开" withSecondAction:@"关闭" userInfo:nil soundName:nil region:nil regionTriggersOnce:YES category:nil];
    
   
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        
    }
}


-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"DeviceToken 获取失败，原因  %@",error);
    
}

- (void)testLocalNotifi
{
    NSLog(@"测试本地通知啦！！！");
    //[self.viewController addLogString:@"尊敬的用户钱海钱包提醒你"];
   NSDate *fireDate = [[NSDate new] dateByAddingTimeInterval:5];
    [BPush localNotification:fireDate alertBody:@"这是本地通知" badge:3 withFirstAction:@"打开" withSecondAction:@"关闭" userInfo:nil soundName:nil region:nil regionTriggersOnce:YES category:nil];
}


//
//- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
//{
//    NSLog(@"接收本地通知啦！！！");
//    [BPush showLocalNotificationAtFront:notification identifierKey:nil];
//    
//}



#pragma mark - bPushDelegate

//-(void)onMethod:(NSString *)method response:(NSDictionary *)data
//{
//    [User shareUser].appChannelID=[data objectForKey:@"channel_id"];
//    [User shareUser].appUserID=[data objectForKey:@"user_id"];
//    
//  NSLog(@"userid=%@,channelID=%@",[User shareUser].appUserID,[User shareUser].appChannelID);
//    
//}
//


- (void)applicationWillResignActive:(UIApplication *)application
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[self timeNowString] forKey:@"out"];
    [userDefaults synchronize];
}

- (NSString *)timeNowString
{
    NSDate * now = [NSDate date];
    NSDateFormatter* dateformatter = [[NSDateFormatter alloc] init];
    dateformatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString* dateString = [dateformatter stringFromDate:now];
    return dateString;
}

//应用退到后台，3分钟没启动再次使用就要锁屏
- (BOOL)compareTime
{
    NSString * inStr = [self timeNowString];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * outStr = [userDefaults objectForKey:@"out"];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date1=[dateFormatter dateFromString:outStr];
    NSDate *date2=[dateFormatter dateFromString:inStr];
    NSTimeInterval time=[date2 timeIntervalSinceDate:date1];
    int minter = time/180;
    if (minter >= 1) {
        return YES;
    } else {
        return NO;
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
  
    UIViewController * testVC = [self topViewController];
    //NSLog(@"testVC   ===   %@",testVC);
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    NSString *psw=[ud objectForKey:@"lock"];
    
    
    if(psw==nil) {
        return;
    }else{
        if ([self compareTime]) {
            if (![testVC isKindOfClass:[LLLockViewController class]]) {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
            LLLockViewController * presentVC =(LLLockViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"gestureToTabSegue"];
            
            CATransition *animation = [CATransition animation];
            animation.duration = 0.05f;
            animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation.type = @"rippleEffect";
            animation.subtype = kCATransitionFromLeft;
            [testVC.view.window.layer addAnimation:animation forKey:nil];
            [testVC presentViewController:presentVC animated:NO completion:nil];
            
        };
    }
 }
    
}

- (UIViewController *)topViewController{
    return [self topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController *)topViewController:(UIViewController *)rootViewController
{
    if (rootViewController.presentedViewController == nil) {
        return rootViewController;
    }
    
    if ([rootViewController.presentedViewController isMemberOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        return [self topViewController:lastViewController];
    }
    
    UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
    return [self topViewController:presentedViewController];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
   
   
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}
@end
