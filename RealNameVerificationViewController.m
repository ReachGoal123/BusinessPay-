//
//  RealNameVerificationViewController.m
//  BusinessPay
//
//  Created by Tears on 14-4-15.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "RealNameVerificationViewController.h"
#import "UIImage+ImageHelper.h"


#define DOCUMENT [(NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)) firstObject]
#define kIDCardImageName    @"idcardscale.png"
#define kSenceImageName     @"scenescale.png"

#define kIDCardImagePathKey    @"idCardImagePathKey"
#define kSenceImagePathKey     @"SenceImagePathKey"
//#define kBankCardImagePathKey  @"bankCardImagePathKey"

@interface RealNameVerificationViewController ()
{
    NSInteger   selectedTextFieldTag;
    BOOL        hasBecomeFirstRespond;
    BOOL _isIDCardPhoto;                    //判断是否为身份证照
    BOOL _isSencePhoto;                     //判断是否为情景照
    BOOL _isBankCardPhoto;                  //判断是否为银行卡照
    
    BOOL _hasIDCardPhoto;
    BOOL _hasScenePhoto;
    BOOL _hasBankCardPhoto;
}

@property (strong,nonatomic) UIActionSheet *IDCardActionSheet;
@property (strong,nonatomic) UIActionSheet *SencePhotoActionSheet;
@property (strong,nonatomic) UIActionSheet *bankCardActionSheet;


@property (weak,nonatomic) IBOutlet UIView *myView;


@property (weak,nonatomic) IBOutlet UIButton *idCardButton;
@property (weak,nonatomic) IBOutlet UIButton *sencePhotoButton;
@property (weak,nonatomic) IBOutlet UIButton *bankCardButton;




@property (weak, nonatomic) IBOutlet UIImageView *idCardImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sceneImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bankCardImageView;


@property (weak,nonatomic) IBOutlet UIImageView *circleImageView1;
@property (weak,nonatomic) IBOutlet UIImageView *circleImageView2;
@property (weak,nonatomic) IBOutlet UIImageView *circleImageView3;

@property (weak,nonatomic) IBOutlet UITextField *bankNumberTextFeild;


- (IBAction)IDCardFacedeAction:(id)sender;
- (IBAction)shootingSceneAction:(id)sender;
- (IBAction)bankCardAction:(id)sender;
- (IBAction)upLoadAllAction:(id)sender;


- (void)tapAction:(UITapGestureRecognizer *)sender;




//-(IBAction)submitRequest:(id)sender;


@end

@implementation RealNameVerificationViewController


-(void)viewWillAppear:(BOOL)animated
{
    
    if ([User shareUser].idcardSts==0) {
        
        self.circleImageView1.image=[UIImage imageNamed:@"circle1.png"];
        [self.idCardButton setBackgroundImage:[UIImage imageNamed:@"right.png"] forState:UIControlStateNormal];
        [self.idCardButton setUserInteractionEnabled:NO];
        
       UIImage *scaleImage = [self getImageFromDocumentFileWithImageName:[[NSUserDefaults standardUserDefaults] valueForKey:kIDCardImagePathKey]];
       
        if (scaleImage.size.width < scaleImage.size.height) {
            scaleImage = [scaleImage imageRotatedByDegrees:M_PI/2];
        }
        self.idCardImageView.image = scaleImage ;
        
        [self.idCardImageView setUserInteractionEnabled:NO];
        
        
        _hasIDCardPhoto=YES;
        
        
    }
    
    if ([User shareUser].senceSts==0) {
        self.circleImageView2.image=[UIImage imageNamed:@"circle2.png"];
        [self.sencePhotoButton setBackgroundImage:[UIImage imageNamed:@"right.png"] forState:UIControlStateNormal];
        [self.sencePhotoButton setUserInteractionEnabled:NO];
        
        UIImage *scaleImage = [self getImageFromDocumentFileWithImageName:[[NSUserDefaults standardUserDefaults] valueForKey:kSenceImagePathKey]];
        
        if (scaleImage.size.width < scaleImage.size.height) {
            scaleImage = [scaleImage imageRotatedByDegrees:M_PI/2];
        }
        self.sceneImageView.image = scaleImage ;
        
        [self.sceneImageView setUserInteractionEnabled:NO];
        
        
        _hasScenePhoto=YES;
    }
    
}



-(void)viewDidLayoutSubviews
{
    [self.scrollView setScrollEnabled:YES];
    self.scrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, 672);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setKeyBoard];
    
    //UINavigationBar *navigationBar=[UINavigationBar alloc] ini
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleNew.png"] forBarMetrics:UIBarMetricsDefault];
    
    [self.idCardImageView setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tapges=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(IDCardTapAction:)];
    [self.idCardImageView addGestureRecognizer:tapges];

    
    [self.sceneImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapGes1=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scenePhotoTapAction:)];
    [self.sceneImageView addGestureRecognizer:tapGes1];
    

    

    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"实名认证"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    
    
    //[self removeImages];
    
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (selectedTextFieldTag==110 &&self.bankNumberTextFeild.text.length ==kTextLengthZero) {
        [self showWarmingWithMessage:@"请输入银行卡号"];
        return;
    }else
    {
        self.circleImageView3.image=[UIImage imageNamed:@"circle3.png"];
    }
}


- (void)setKeyBoard
{
    NSArray *tfArr = [NSArray arrayWithObjects:_bankNumberTextFeild ,nil];
    
    [IQKeyboardManager sharedManager];
    
    for (int i = 0; i < tfArr.count; i++) {
        UITextField *tf = (UITextField *)[tfArr objectAtIndex:i];
        tf.delegate = self;
        [tf addPreviousNextDoneOnKeyboardWithTarget:self
                                     previousAction:@selector(previousClicked:)
                                         nextAction:@selector(nextClicked:)
                                         doneAction:@selector(doneClicked:)];
        //First textField
        if (i == 0)
        {
            [tf setEnablePrevious:NO next:YES];
        }
        //Last textField
        else if(i== tfArr.count - 1)
        {
            [tf setEnablePrevious:YES next:NO];
        }
    }
}

#pragma mark - toolBarItemAction

-(void)nextClicked:(UISegmentedControl*)segmentedControl
{
    [(UITextField*)[self.view viewWithTag:selectedTextFieldTag+1] becomeFirstResponder];
}

-(void)doneClicked:(UIBarButtonItem*)barButton
{
    [self.view endEditing:YES];
}

-(void)previousClicked:(UISegmentedControl*)segmentedControl
{
    [(UITextField*)[self.view viewWithTag:selectedTextFieldTag-1] becomeFirstResponder];
}




-(void)IDCardTapAction:(UITapGestureRecognizer *)sender
{
    if (!_hasIDCardPhoto) {
        _IDCardActionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"删除", nil];
        [_IDCardActionSheet showInView:self.view];
    }
    else
    {
        _IDCardActionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"重拍身份证正面照",@"删除", nil];
        [_IDCardActionSheet showInView:self.view];
    }
    
}

-(void)scenePhotoTapAction:(UITapGestureRecognizer *)sender
{
    if(!_hasScenePhoto)
    {
    _SencePhotoActionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"删除", nil];
    }
    else
    {
        _SencePhotoActionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"重拍情景照",@"删除", nil];
    }
    [_SencePhotoActionSheet showInView:self.view];
}


//-(void)bankCardTapAction:(UITapGestureRecognizer *)sender
//{
//    if(!_hasBankCardPhoto)
//    {
//    
//    _bankCardActionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"删除", nil];
//    }else
//    {
//        _bankCardActionSheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"重拍银行卡",@"删除", nil];
//    }
//    [_bankCardActionSheet showInView:self.view];
//    
//    
//}


- (IBAction)IDCardFacedeAction:(id)sender
{
    _isIDCardPhoto = YES ;
    _isSencePhoto =NO;
    _isBankCardPhoto=NO;
    [self takePhotoAction];
}

- (IBAction)shootingSceneAction:(id)sender {
    _isIDCardPhoto = NO ;
    _isBankCardPhoto=NO;
    _isSencePhoto=YES;
    [self takePhotoAction];
}


//-(IBAction)bankCardAction:(id)sender
//{
//    _isSencePhoto=NO;
//    _isIDCardPhoto=NO;
//    _isBankCardPhoto=YES;
//    
//    [self takePhotoAction];
//    
//    
//}




- (IBAction)upLoadAllAction:(id)sender {
    
    
    
    if (!_hasIDCardPhoto) {
        [self showWarmingWithMessage:@"未拍摄正面照片"];
        return;
    }
    if (!_hasScenePhoto) {
        [self showWarmingWithMessage:@"未拍摄情景照片"];
        return;
    }
//    if (!_hasBankCardPhoto)
//    {
//        [self showWarmingWithMessage:@"未拍摄银行卡照片"];
//        return;
//    }
    if (self.bankNumberTextFeild.text.length ==kTextLengthZero) {
        [self showWarmingWithMessage:@"请输入银行卡号"];
        return;
    }
    [UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(upLoadRequest) withObject:nil afterDelay:kDelayTime];
}

- (void)upLoadRequest
{
    //    @"50410001998"
    //NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 开始 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    RealNameDO * realNameDO = [[RealNameDO alloc] init];
    realNameDO.delegate = self;
    
    realNameDO.trancode = kTrancode_RealName ;
    
    realNameDO.merchantNum=[User shareUser].merchantNum;
    
    NSString *IDCardImageName = [[NSUserDefaults standardUserDefaults] valueForKey:kIDCardImagePathKey];
    NSString *SenceImageName = [[NSUserDefaults standardUserDefaults] valueForKey:kSenceImagePathKey];
    
//    NSString *bankcardImageName=[[NSUserDefaults standardUserDefaults] valueForKey:kBankCardImagePathKey];
    
    realNameDO.IDCardFaceData=[self getImageFromDocumentFilePathWithImageName:IDCardImageName];
    realNameDO.photoData=[self getImageFromDocumentFilePathWithImageName:SenceImageName];
    //realNameDO.bankcardPhotoData=[self getImageFromDocumentFilePathWithImageName:bankcardImageName];
    
    realNameDO.IDFileName = IDCardImageName;
    realNameDO.photoFileName = SenceImageName;
    //realNameDO.bankCardFileName=bankcardImageName;
    
    realNameDO.bankNumber=self.bankNumberTextFeild.text;
    
    [realNameDO realNameVerificationRequest];
}


- (void)realNameVerificationSuccessWithMessage:(NSString *)message
{
    [UIComponentService showSuccessHudWithStatus:message];

    [self performSelector:@selector(popViewController) withObject:nil afterDelay:kDelayTime];
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)realNameVerificationFailWithMessage:(NSString *)message
{
    [UIComponentService showFailHudWithStatus:message];
}

- (void)takePhotoAction
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *pickVC = [[UIImagePickerController alloc] init];
        pickVC.sourceType = UIImagePickerControllerSourceTypeCamera;

        if (_isSencePhoto) {
            pickVC.cameraDevice=UIImagePickerControllerCameraDeviceFront;
        }
        
        pickVC.delegate = self;
        [self presentViewController:pickVC animated:YES completion:nil];
    }
}

#pragma mark - imagePicker  delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    NSLog(@"拍摄相片：%@",image);
    
    
    CGSize size ;
    if (image.size.width >image.size.height) {
        size = CGSizeMake(300, 240);
    } else {
        size = CGSizeMake(240, 300);
    }
    UIImage * scaleImage;
    [self imageWithImageSimple:image scaledToSize:size];
    
    
    if (_isIDCardPhoto) {
        
        scaleImage = [self getImageFromDocumentFileWithImageName:[[NSUserDefaults standardUserDefaults] valueForKey:kIDCardImagePathKey]];
        NSLog(@"取图片名：%@",[[NSUserDefaults standardUserDefaults] valueForKey:kIDCardImagePathKey]);
        
        //[[NSUserDefaults standardUserDefaults] ]
        
        if (scaleImage.size.width < scaleImage.size.height) {
            scaleImage = [scaleImage imageRotatedByDegrees:M_PI/2];
        }
        self.idCardImageView.image = scaleImage ;
        [self.idCardButton setBackgroundImage:[UIImage imageNamed:@"right.png"] forState:UIControlStateNormal];
        
        [self.idCardButton setUserInteractionEnabled:NO];
        self.circleImageView1.image=[UIImage imageNamed:@"circle1.png"];
        _hasIDCardPhoto = YES ;
        
        
        
        
        
    } else  if(_isSencePhoto){
        scaleImage = [self getImageFromDocumentFileWithImageName:[[NSUserDefaults standardUserDefaults] valueForKey:kSenceImagePathKey]];
        if (scaleImage.size.width < scaleImage.size.height) {
            scaleImage = [scaleImage imageRotatedByDegrees:M_PI/2];
        }
        self.sceneImageView.image = scaleImage ;
        [self.sencePhotoButton setBackgroundImage:[UIImage imageNamed:@"right.png"] forState:UIControlStateNormal];
        [self.sencePhotoButton setUserInteractionEnabled:NO];
        self.circleImageView2.image=[UIImage imageNamed:@"circle2.png"];
        
        _hasScenePhoto = YES ;
        
    
    }
//    else  if(_isBankCardPhoto){
//        scaleImage = [self getImageFromDocumentFileWithImageName:[[NSUserDefaults standardUserDefaults] valueForKey:kBankCardImagePathKey]];
//        if (scaleImage.size.width < scaleImage.size.height) {
//            scaleImage = [scaleImage imageRotatedByDegrees:M_PI/2];
//        }
//        self.bankCardImageView.image = scaleImage ;
//        [self.bankCardButton setBackgroundImage:[UIImage imageNamed:@"right.png"] forState:UIControlStateNormal];
//        [self.bankCardButton setUserInteractionEnabled:NO];
//        self.circleImageView3.image=[UIImage imageNamed:@"circle3.png"];
//        _hasBankCardPhoto = YES ;
//        
//        
//    }
        [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImageToDocument:(UIImage *)tempImage WithName:(NSString *)imageName
{
    //NSLog(@"准备保存：%@",tempImage);
    
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    
    //NSLog(@"图片数据 ；%@",imageData);
    NSString* fullPathToFile = [DOCUMENT stringByAppendingPathComponent:imageName];
    //NSLog(@"文件路径：%@",fullPathToFile);
    
    BOOL success=[imageData writeToFile:fullPathToFile atomically:YES];
    
    NSLog(@"success: %@" ,success?@"YES":@"NO");
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    //NSError *error = nil;
//    if ([fileManager fileExistsAtPath:fullPathToFile]) {
//
//        NSLog(@" 存储成功 ! ");
//    }else
//    {
//        NSLog(@" 存储失败 ！ ");
//        
//    }
    
    
}

- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    //NSLog(@" 转换图片1：%@",newImage);
    UIGraphicsEndImageContext();
    
    //NSLog(@" 转换图片2：%@",newImage);
    //[self deleteScaledImageBefore];
    //取好文件名
    NSDate *imageDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMDDHHmmss";
    NSString *tempImageName = [[dateFormatter stringFromDate:imageDate] stringByAppendingString:@".png"]
    ;
    if (_isIDCardPhoto) {
        //删除旧的图片
        NSString *oldImagePath = [[NSUserDefaults standardUserDefaults] valueForKey:kIDCardImagePathKey];
        NSLog(@"old Image Path:%@",oldImagePath);
        if (oldImagePath != nil) {
            [self deleteScaledImageByImageName:oldImagePath];
        }
        
        //将新的图片名加到关键路径中去
        [[NSUserDefaults standardUserDefaults] setValue:tempImageName forKey:kIDCardImagePathKey];
        
        NSLog(@"存文件名：%@",[[NSUserDefaults standardUserDefaults] valueForKey:kIDCardImagePathKey]);
        [self saveImageToDocument:newImage WithName:tempImageName];
    } else  if(_isSencePhoto){
        //删除旧的图片
        NSString *oldImagePath = [[NSUserDefaults standardUserDefaults] valueForKey:kSenceImagePathKey];
        NSLog(@"old Image Path:%@",oldImagePath);
        if (oldImagePath != nil) {
            [self deleteScaledImageByImageName:oldImagePath];
        }
        //将新的图片名加到关键路径中去
        [[NSUserDefaults standardUserDefaults] setValue:tempImageName forKey:kSenceImagePathKey];
        [self saveImageToDocument:newImage WithName:tempImageName];
    }
//    else
//    {
//        NSString *oldImagePath = [[NSUserDefaults standardUserDefaults] valueForKey:kBankCardImagePathKey];
//        NSLog(@"old Image Path:%@",oldImagePath);
//        if (oldImagePath != nil) {
//            [self deleteScaledImageByImageName:oldImagePath];
//        }
//        
//        //将新的图片名加到关键路径中去
//        [[NSUserDefaults standardUserDefaults] setValue:tempImageName forKey:kBankCardImagePathKey];
//        [self saveImageToDocument:newImage WithName:tempImageName];
//
//    }
    
    //[[NSUserDefaults standardUserDefaults] synchronize];
    return newImage;
}

-(BOOL)deleteScaledImageByImageName:(NSString *)imageName
{
    NSString* fullPathToFile = [DOCUMENT stringByAppendingPathComponent:imageName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    if ([fileManager fileExistsAtPath:fullPathToFile]) {
        
        if ([fileManager removeItemAtPath:fullPathToFile error:&error]) {
            return YES;
        }
    }
    return NO;
}



#pragma mark - actionDelegate


-(void)willPresentActionSheet:(UIActionSheet *)actionSheet
{

    
    for (UIView *view in _IDCardActionSheet.subviews)
    {
        if (view.tag==2) {
            UIButton *button=(UIButton *)view;
            if(!_hasIDCardPhoto){
             [button setUserInteractionEnabled:NO];
             [button setAlpha:0.4f];
            }else
            {
                [button setAlpha:1.0f];
                [button setUserInteractionEnabled:YES];
            }
        }
    }
    for (UIView *view in _SencePhotoActionSheet.subviews) {
        if (view.tag==2) {
            UIButton *button=(UIButton *)view;
            if (!_hasScenePhoto) {
                [button setUserInteractionEnabled:NO];
                [button setAlpha:0.4f];
                
            }else
            {
                [button setUserInteractionEnabled:YES];
                [button setAlpha:1.0f];
            }
        }
    }
//    for (UIView *view in _bankCardActionSheet.subviews) {
//        if (view.tag==2) {
//            UIButton *button=(UIButton *)view;
//            if (!_hasBankCardPhoto) {
//                [button setUserInteractionEnabled:NO];
//                [button setAlpha:0.4f];
//            }else
//            {
//                [button setUserInteractionEnabled:YES];
//                [button setAlpha:1.0f];
//            }
//        }
//    }
    
    
    
    
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet==_IDCardActionSheet) {
        if (buttonIndex==0) {
            [self IDCardFacedeAction:nil];
        }else if (buttonIndex==1)
        {
            NSString *oldImagePath = [[NSUserDefaults standardUserDefaults] valueForKey:kIDCardImagePathKey];
            [self deleteScaledImageByImageName:oldImagePath];
            self.idCardImageView.image=[UIImage imageNamed:@"idCard.png"];
            [self.idCardButton setBackgroundImage:[UIImage imageNamed:@"takePhoto.png"] forState:UIControlStateNormal];
            [self.idCardButton setUserInteractionEnabled:YES];
            self.circleImageView1.image=[UIImage imageNamed:@"circleGray1.png"];
            
            _hasIDCardPhoto=NO;
            
        }
    }else if (actionSheet==_SencePhotoActionSheet)
    {
        if (buttonIndex==0) {
            [self shootingSceneAction:nil];
        }else if(buttonIndex==1)
        {
            NSString *oldImagePath=[[NSUserDefaults standardUserDefaults] valueForKey:kSenceImagePathKey];
            [self deleteScaledImageByImageName:oldImagePath];
            self.sceneImageView.image=[UIImage imageNamed:@"sencePhoto.png"];
            
            
            [self.sencePhotoButton setBackgroundImage:[UIImage imageNamed:@"takePhoto.png"] forState:UIControlStateNormal];
            [self.sencePhotoButton setUserInteractionEnabled:YES];
            
            self.circleImageView2.image=[UIImage imageNamed:@"circleGray2.png"];

            _hasScenePhoto=NO;
        }

    }
   // else
//    {
//        if (buttonIndex==0) {
//            [self bankCardAction:nil];
//        }else if(buttonIndex==1)
//        {
//            NSString *oldImagePath=[[NSUserDefaults standardUserDefaults] valueForKey:kBankCardImagePathKey];
//            [self deleteScaledImageByImageName:oldImagePath];
//            self.bankCardImageView.image=[UIImage imageNamed:@"bankCard.png"];
//           
//            
//            [self.bankCardButton setBackgroundImage:[UIImage imageNamed:@"takePhoto.png"] forState:UIControlStateNormal];
//            [self.bankCardButton setUserInteractionEnabled:YES];
//            
//            self.circleImageView3.image=[UIImage imageNamed:@"circleGray3.png"];
//             _hasBankCardPhoto=NO;
//        }
//        
//    }

}




- (UIImage *)getImageFromDocumentFileWithImageName: (NSString *)imamgeName
{
    NSString* fullPathToFile = [DOCUMENT stringByAppendingPathComponent:imamgeName];
    NSLog(@"image=%@",[UIImage imageWithContentsOfFile:fullPathToFile]);
    return [UIImage imageWithContentsOfFile:fullPathToFile];
    
    
    
}


-(NSString *)getImageFromDocumentFilePathWithImageName:(NSString *) imageName
{
    
    NSString *fullPathFile= [ DOCUMENT stringByAppendingPathComponent:imageName];
   
    return fullPathFile;
}


- (void)removeImages
{
    NSString * idcardImage = kIDCardImageName;
    NSString * senceImage = kSenceImageName;
    NSString* idCardfullPath = [DOCUMENT stringByAppendingPathComponent:idcardImage];
    NSString* sencefullPath = [DOCUMENT stringByAppendingPathComponent:senceImage];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:idCardfullPath error:nil];
    [fileManager removeItemAtPath:sencefullPath error:nil];
}




- (void)registerResponseFailWithMessage:(NSString *)message
{
    [UIComponentService showFailHudWithStatus:message];
}

- (void)messageVerificationSuccessWithMessage:(NSString *)message
{
    [UIComponentService showSuccessHudWithStatus:message];
//    NSLog(@"messageVerificationSuccess");
}

- (void)registerSucessWithMessage:(NSString *)message
{
    [UIComponentService showSuccessHudWithStatus:message];
    
    [self performSegueWithIdentifier:@"huizhuye2" sender:nil];
    
    
    
    
//    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"huizhuye2"]) {
        NSLog(@"回到主页");
//        self.navigationController.navigationBarHidden = YES;
    }
}



@end
