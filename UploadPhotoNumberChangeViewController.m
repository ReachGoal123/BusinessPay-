//
//  UploadPhotoNumberChangeViewController.m
//  BusinessPay
//
//  Created by SHANGYITONG on 15-1-14.
//  Copyright (c) 2015年 Tears. All rights reserved.
//

#import "UploadPhotoNumberChangeViewController.h"
#import "UIImage+ImageHelper.h"

#define DOCUMENT [(NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)) firstObject]
#define kIDCardImageName    @"idcardscale.png"
#define kSenceImageName     @"scenescale.png"

#define kIDCardImagePathKey @"idCardImagePathKey"
#define kSenceImagePathKey @"SenceImagePathKey"


@interface UploadPhotoNumberChangeViewController()
{
    BOOL _isIDCardPhoto;
    BOOL _hasIDCardPhoto;
    BOOL _hasScenePhoto;
    
}

@property (weak, nonatomic) IBOutlet UIImageView *idCardImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sceneImageView;

//@property (strong,nonatomic) BankUploadPhotoDO *bankUploadDo;


- (IBAction)IDCardFacedeAction:(id)sender;
- (IBAction)shootingSceneAction:(id)sender;
- (IBAction)upLoadAllAction:(id)sender;
- (IBAction)clearAction:(id)sender;

@end


@implementation UploadPhotoNumberChangeViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"手机号码变更认证"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
}


- (IBAction)IDCardFacedeAction:(id)sender
{
    _isIDCardPhoto = YES ;
    [self takePhotoAction];

}

- (IBAction)shootingSceneAction:(id)sender {
    _isIDCardPhoto = NO ;
    [self takePhotoAction];
}

- (IBAction)upLoadAllAction:(id)sender {
    
    if (!_hasIDCardPhoto) {
        [self showWarmingWithMessage:@"未拍摄正面照片"];
        return;
    }
    if (!_hasScenePhoto) {
        [self showWarmingWithMessage:@"未拍摄情景照片"];
        return;
    }
    
    [UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(upLoadRequest) withObject:nil afterDelay:kDelayTime];
}

-(void)upLoadRequest
{

    PhoneNumberUploadPhotoDO *phoneUploadDO=[[PhoneNumberUploadPhotoDO alloc] init];
    phoneUploadDO.delegate=self;
    phoneUploadDO.trancode=@"198110";
    
    
    
    
    
    NSString *IDCardImageName = [[NSUserDefaults standardUserDefaults] valueForKey:kIDCardImagePathKey];
    NSString *SenceImageName = [[NSUserDefaults standardUserDefaults] valueForKey:kSenceImagePathKey];
    
    phoneUploadDO.IDFilePath=[self getImageFromDocumentFilePathWithImageName:IDCardImageName];
    phoneUploadDO.photoFilePath=[self getImageFromDocumentFilePathWithImageName:SenceImageName];
    phoneUploadDO.IDFileName = IDCardImageName;
    phoneUploadDO.photoFileName = SenceImageName;
    
    [phoneUploadDO phoneNumberUploadChangeRequest];
    
    
    
}

-(void)phoneNumberChangeUploadSuccessWithMessage:(NSString *)message
{
    [UIComponentService showSuccessHudWithStatus:@"上传成功，请等待后台验证"];
    [User shareUser].phoneNumberChange=YES;
    
//    [self.navigationController popToRootViewControllerAnimated:YES];
    [self performSegueWithIdentifier:@"gozhuye" sender:self];
    
}


-(void)phoneNumberChangeUploadFailWithMessage:(NSString *)message
{
    [UIComponentService showFailHudWithStatus:message];
}


- (IBAction)clearAction:(id)sender {
    self.idCardImageView.image = [UIImage imageNamed:@"idcard.png"];
    self.sceneImageView.image = [UIImage imageNamed:@"scene.png"];
    _hasIDCardPhoto = NO ;
    _hasScenePhoto  = NO ;
    [self removeImages];
}

- (void)takePhotoAction
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *pickVC = [[UIImagePickerController alloc] init];
        pickVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickVC.delegate = self;
        [self presentViewController:pickVC animated:YES completion:nil];
    }
}


#pragma mark - imagePicker  delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    //    [self deleteShareImageBefore];
    //    if (_isIDCardPhoto) {
    //        [self saveImageToDocument:image WithName:@"idcard.png"];
    //        [self fileSizeForFilePath:@"idcard.png"];
    //        self.idCardImageView.image = [self getImageFromDocumentFileWithImageName:@"idcardscale.png"] ;
    //        _hasIDCardPhoto = YES ;
    //    } else {
    //        [self saveImageToDocument:image WithName:@"scene.png"];
    //        [self fileSizeForFilePath:@"scene.png"];
    //        self.sceneImageView.image = [self getImageFromDocumentFileWithImageName:@"scenescale.png"] ; ;
    //        _hasScenePhoto = YES ;
    //    }
    
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
        if (scaleImage.size.width < scaleImage.size.height) {
            scaleImage = [scaleImage imageRotatedByDegrees:M_PI/2];
        }
        self.idCardImageView.image = scaleImage ;
        _hasIDCardPhoto = YES ;
    } else {
        scaleImage = [self getImageFromDocumentFileWithImageName:[[NSUserDefaults standardUserDefaults] valueForKey:kSenceImagePathKey]];
        if (scaleImage.size.width < scaleImage.size.height) {
            scaleImage = [scaleImage imageRotatedByDegrees:M_PI/2];
        }
        self.sceneImageView.image = scaleImage ;
        _hasScenePhoto = YES ;
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImageToDocument:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSString* fullPathToFile = [DOCUMENT stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPathToFile atomically:NO];
    
}

- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self deleteScaledImageBefore];
    //取好文件名
    NSDate *imageDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMDDHHmmss";
    NSString *tempImageName = [[dateFormatter stringFromDate:imageDate] stringByAppendingString:@".png"]
    ;
    if (_isIDCardPhoto) {
        //删除旧的图片
        NSString *oldImagePath = [[NSUserDefaults standardUserDefaults] valueForKey:kIDCardImagePathKey];
        if (oldImagePath !=nil) {
            [self deleteScaledImageByImageName:oldImagePath];
        }        //将新的图片名加到关键路径中去
        [[NSUserDefaults standardUserDefaults] setValue:tempImageName forKey:kIDCardImagePathKey];
        [self saveImageToDocument:newImage WithName:tempImageName];
    } else {
        //删除旧的图片
        NSString *oldImagePath = [[NSUserDefaults standardUserDefaults] valueForKey:kSenceImagePathKey];
        if (oldImagePath !=nil) {
            [self deleteScaledImageByImageName:oldImagePath];
        }
        //将新的图片名加到关键路径中去
        [[NSUserDefaults standardUserDefaults] setValue:tempImageName forKey:kSenceImagePathKey];
        [self saveImageToDocument:newImage WithName:tempImageName];
    }
    
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

- (void)deleteScaledImageBefore
{
    NSString * imageName;
    if (_isIDCardPhoto) {
        imageName = kIDCardImageName;
    } else {
        imageName = kSenceImageName;
    }
    
    NSString* fullPathToFile = [DOCUMENT stringByAppendingPathComponent:imageName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    if ([fileManager fileExistsAtPath:fullPathToFile]) {
        
        [fileManager removeItemAtPath:fullPathToFile error:&error];
        if (error) {
            printf("remove error!!!");
        }
    }
    
    
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
    //NSString *fullPathFile=@"/Users/shangyitong/Downloads/userlogin_bg.jpg";
    
    NSLog(@"fullPathFile==%@",fullPathFile);
    
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




@end
