//
//  RegisterViewController.m
//  BusinessPay
//
//  Created by Tears on 14-4-9.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "RegisterViewController.h"


@interface RegisterViewController ()
{
    NSInteger   selectedTextFieldTag;
    NSString    * remberTerminalNumber;
    
    BOOL        hasBecomeFirstRespond;
    BOOL        terminalVerificationEffective;
    BOOL        _agreeProtocol;
    ABPeoplePickerNavigationController *picker;
}


@property (weak, nonatomic) IBOutlet UIImageView *imageView;      
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *userName;             // 用户姓名
@property (weak, nonatomic) IBOutlet UITextField *IDcard;               // 身份证号码
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;          // 手机号码
@property (weak, nonatomic) IBOutlet UITextField *passWord;             // 密码
@property (weak, nonatomic) IBOutlet UITextField *confirmPasssWord;     // 确认密码
@property (weak, nonatomic) IBOutlet UITextField *emailBox;
@property (weak, nonatomic) IBOutlet UITextField *messageVerificate;    // 短信验证
@property (weak, nonatomic) IBOutlet UITextField *inviteTextField;
//@property (weak, nonatomic) IBOutlet UITextField *terminalNumber;       // 终端号
@property (weak, nonatomic) IBOutlet UITextField *bankCardNumber;       // 银行卡号
@property (weak, nonatomic) IBOutlet UILabel *bankName;                 // 银行名称
@property (weak, nonatomic) IBOutlet UILabel *accountProvince;          // 账户省份
@property (weak, nonatomic) IBOutlet UILabel *accountCity;              // 账户城市
@property (weak, nonatomic) IBOutlet UILabel *accountSubbranch;         // 账户支行
@property (weak, nonatomic) IBOutlet UITextField *userCodeNum;             // 激活码


@property (strong, nonatomic)NSMutableArray * detailVCDataSourceProvinceArr;        // province
@property (strong, nonatomic)NSMutableArray * detailVCDataSourceCityArr;            // city
@property (strong, nonatomic)NSMutableArray * detailVCDataSourceSubbranchArr;       // Subbranch
@property (assign, nonatomic)int selectButtonIndex;
@property (strong, nonatomic)RegisterDO * regestDO;

@property (nonatomic, copy)NSString * bankID;                           // 开户行名称ID
@property (nonatomic, copy)NSString * provinceID;                       // 开户省ID
@property (nonatomic, copy)NSString * cityID;                           // 开户城市ID
@property (nonatomic, copy)NSString * subbranchID;                      // 开户支行ID
@property (nonatomic, copy)NSString * subbranchName;                    // 开户行支行名称

- (IBAction)tapAction:(UITapGestureRecognizer *)sender;
- (IBAction)checkDeal:(id)sender;
- (IBAction)backAction:(id)sender;
- (IBAction)SMSVerificationAction:(id)sender;
- (IBAction)registerAction:(id)sender;
- (IBAction)agreeAction:(id)sender;
- (IBAction)selectAdressBook:(id)sender;

- (IBAction)selecttisiButton:(id)sender;

@end

@implementation RegisterViewController

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    self.scrollView.frame =self.view.bounds;
//}

- (void)selecttisiButton:(id)sender{
    
    self.surebutton.enabled = NO;
 
    NSLog(@"selecttisiButton=====");
    self.color=self.view.backgroundColor;
    
    _myView=[[UIView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH/2, kSCREEN_HEIGHT/2, 2 , 2)];
    
    self.myView.backgroundColor = [UIColor whiteColor];
    
    UILabel *fatelabel=[[UILabel alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH/2, 20, 2, 2)];
    fatelabel.text=@"关于费率介绍";
    fatelabel.textAlignment = YES;
    fatelabel.textColor=[UIColor blackColor];
    fatelabel.font=[UIFont systemFontOfSize:20.0f];
    
    CGRect  fatelabelFrame=CGRectMake(20, 10, kSCREEN_WIDTH-90, 20);
    fatelabel.frame = fatelabelFrame;
    
    UILabel *Wfatelabel=[[UILabel alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH/2, 20, 2, 2)];
    Wfatelabel.text=@"什么是费率?";
    Wfatelabel.textColor=[UIColor blackColor];
    Wfatelabel.font=[UIFont systemFontOfSize:14.0f];
    CGRect  WfatelabelFrame=CGRectMake(20, 48, kSCREEN_WIDTH-90, 20);
    Wfatelabel.frame = WfatelabelFrame;

    
    UITextView *textView=[[UITextView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH, kSCREEN_HEIGHT/2, 0, 0)];
    
    textView.text=@"钱包充值手续费按费率来扣取,费率越低手续费越低\n购买费率可从钱包直接进行费率升级,或使用费率激活码升级.\n\n没有费率激活码?\n\n可以向您的所属代理商索要!\n可以咨询我们的客服热线!\n4008-719-668";
    
    textView.font=[UIFont systemFontOfSize:14.0f];
    
    textView.editable=NO;
    textView.backgroundColor=[UIColor clearColor];
    textView.textColor=[UIColor blackColor];
    CGRect  textViewFrame=CGRectMake(20, 68, kSCREEN_WIDTH-60, 180);
    textView.frame=textViewFrame;
    
    UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH/2, 180, 100, 40)];
    [button setBackgroundImage:[UIImage imageNamed:@"tishixx.png"] forState:UIControlStateNormal];
//    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismissAction:) forControlEvents:UIControlEventTouchUpInside];
    CGRect  leftButtonFrame= CGRectMake(250, -8, 40, 40);
    button.frame=leftButtonFrame;

    
    _myView.frame = CGRectMake(15, 25, kSCREEN_WIDTH-40, kSCREEN_HEIGHT-200);
   

    [_myView addSubview:fatelabel];
    [_myView addSubview:Wfatelabel];
    [_myView addSubview:textView];
    [_myView addSubview:button];

    [self.view addSubview:_myView];

}

-(void) dismissAction:(id)sender
{
    self.surebutton.enabled = YES;

    [_myView removeFromSuperview];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleNew.png"] forBarMetrics:UIBarMetricsDefault];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleNew.png"] forBarMetrics:UIBarMetricsDefault];
}
- (void)selectAdressBook:(id)sender
{
    if (!picker) {
        picker=[[ABPeoplePickerNavigationController alloc] init ];
        picker.peoplePickerDelegate=self;
    }
    
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)checkDeal:(id)sender
{
    [self performSegueWithIdentifier:@"checkDealSegue" sender:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.scrollView setScrollEnabled:YES];
    self.scrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, 416);
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"注  册"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    //[self.imageView sendSubviewToBack:self.view];
    
//    self.passWord.userInteractionEnabled=YES;
//    self.confirmPasssWord.userInteractionEnabled=YES;
//    self.emailBox.userInteractionEnabled=YES;
    
    //[(UIButton *)[self.view viewWithTag:101] setImage:[UIImage imageNamed:@"checkbutton"] forState:UIControlStateNormal];
    _agreeProtocol = YES;
     self.regestDO = [[RegisterDO alloc] init];
    [self InitializationLabTest];
    [self setKeyBoard];
    [self setLabBackground];
}

- (void)InitializationLabTest
{
    self.bankID                 = kNil;
    self.provinceID             = kNil;
    self.cityID                 = kNil;
    self.subbranchID            = kNil;
    self.subbranchName          = kNil;
    self.bankName.text          = kNil;
    self.accountProvince.text   = kNil;
    self.accountCity.text       = kNil;
    self.accountSubbranch.text  = kNil;
}

- (void)setLabBackground
{
    for (int i = 8; i < 12; i++) {
        UILabel * lab = (UILabel *)[self.view viewWithTag:i];
        lab.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"registertext"]];
    }
}

- (void)setKeyBoard
{
    NSArray *tfArr = [NSArray arrayWithObjects:_phoneNumber, _passWord,_confirmPasssWord,_emailBox,_messageVerificate, nil];
    
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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        DetailTableViewController * detailTableVC = (DetailTableViewController *)[segue.destinationViewController topViewController];
        detailTableVC.delegate = self;
        
        switch (self.selectButtonIndex) {
            case DataSouceType_province:
            {
                detailTableVC.dataSourceArr = _detailVCDataSourceProvinceArr;
                detailTableVC.dataSourceType = DataSouceType_province;
            }
                break;
            case DataSouceType_city:
            {
                detailTableVC.dataSourceArr = _detailVCDataSourceCityArr;
                detailTableVC.dataSourceType = DataSouceType_city;
            }
                break;
            case DataSouceType_subbranch:
            {
                detailTableVC.dataSourceArr = _detailVCDataSourceSubbranchArr;
                detailTableVC.dataSourceType = DataSouceType_subbranch;
            }
                break;
            default:
                break;
        }
    }
}


#pragma mark - uitextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{

    

}



- (void)textFieldDidEndEditing:(UITextField *)textField
{
    selectedTextFieldTag=textField.tag;
    
    
    BOOL isPhoneNumber =[BaseModel isValidPhone:self.phoneNumber.text];
    
    if(selectedTextFieldTag==101)
    {
        if(!isPhoneNumber)
        {
          [self showWarmingWithMessage:@"请输入正确的手机号"];
          return;
        }else
        {
            //[self registerRequest];
            [self merchantRequest];
//            if([self.regestDO.responseCode isEqualToString:@"000002"])
//            {
//                [self showWarmingWithMessage:@"该手机已注册"];
//                return;
//            }
        }
    }
    if(selectedTextFieldTag==102 && self.passWord.text.length==kTextLengthZero)
    {
        [self showWarmingWithMessage:@"请输入登录密码"];
        return;
    }
    if(selectedTextFieldTag==102 && self.passWord.text.length<6)
    {
        [self showWarmingWithMessage:@"密码为6-15位"];
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self chickBankNumberTextField];
    return YES;
}
#pragma mark


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
#pragma mark


- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    [self chickBankNumberTextField];
}

#pragma mark - delegate and Response

- (void)terminalVerificationResponseScuess
{
    terminalVerificationEffective =  YES;
}

- (void)terminalVerificationFieldWithMessage:(NSString *)message
{
    terminalVerificationEffective = NO;
    [UIComponentService showFailHudWithStatus:message];
    self.bankName.text = kNil;
    self.bankID =kNil;
}

- (void)responseFildWithMessage: (NSString *)message
{
    [UIComponentService showFailHudWithStatus:message];
}

- (void)responseSuccess:(RegisterDO *)registerDO
{
    [UIComponentService showSuccessHudWithStatus:registerDO.responseMessage];
    _detailVCDataSourceProvinceArr = registerDO.provinceArr;
    self.bankID = registerDO.bankID;
    UILabel * lab = (UILabel *)[self.view viewWithTag:8];
    lab.text = registerDO.belongsBankName;
}

- (void)didSelectProvince:(ProvinceDO *)provinceDO
{
    UILabel * lab =(UILabel *)[self.view viewWithTag:self.selectButtonIndex/10];
    if (![lab.text isEqualToString:provinceDO.provinceName]) {
        self.accountCity.text       = kNil;
        self.accountSubbranch.text  = kNil;
        self.cityID                 = kNil;
        self.subbranchID            = kNil;
    } 
    lab.text = provinceDO.provinceName;
    self.provinceID = provinceDO.provinceID;
}

- (void)registerCityRequest:(NSString *)provinceID
{
    self.regestDO = [[RegisterDO alloc] init];
    self.regestDO.delegate = self;
    //self.regestDO.termno = self.terminalNumber.text;
//    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                 self.regestDO.termno,@"TERMNO",
//                                 kInquiryCurrentPage,@"PAGENUM",
//                                 kInquiryNumber,@"NUMPERPAGE",
//                                 provinceID,@"PROVID",nil];
//    NSString * urlStr = [self.regestDO appendPosm5URL:kTrancode_City];
//    NSURL * url = [NSURL URLWithString:urlStr];
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    [request addPostValue:self.regestDO.termno forKey:@"TERMNO"];
//    [request addPostValue:kInquiryCurrentPage forKey:@"PAGENUM"];
//    [request addPostValue:kInquiryNumber forKey:@"NUMPERPAGE"];
    //[request addPostValue:provinceID forKey:@"PROVID"];
    
    
    //[self.regestDO registerCityNameRequestWithTrancode:kTrancode_City andRequestMessage:dic];
    
    //[self.regestDO registerCityNameRequestWithRequester:request];
    [self.regestDO registerCityNameRequestWithTrancode:kTrancode_City andProvinceID:provinceID];
}

- (void)cityResponseSuccess:(RegisterDO *)registerDO
{
    [UIComponentService dismissHudView];
    _detailVCDataSourceCityArr = registerDO.cityArr;
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
}

- (void)didSelectCity:(CityDO *)cityDO
{
    UILabel * lab =(UILabel *)[self.view viewWithTag:self.selectButtonIndex/10];
    if (![lab.text isEqualToString:cityDO.cityName]) {
        self.accountSubbranch.text  = kNil;
        self.subbranchID            = kNil;
    }
    lab.text = cityDO.cityName;
    self.cityID = cityDO.cityID;
}

- (void)registerSubbranchRequest
{
    self.regestDO = [[RegisterDO alloc] init];
    self.regestDO.delegate = self;
 
    [self.regestDO registerSubbranchRequestWithTrancode:kTrancode_Subbranch andProvinceID:self.provinceID andCityID:self.cityID andBankID:self.bankID];
    
    //[self.regestDO registerSubbranchRequestWithTrancode:kTrancode_Subbranch andRequestMessage:dic];

}

- (void)subbranchResponseSuccess:(RegisterDO *)registerDO
{
    [UIComponentService dismissHudView];
    _detailVCDataSourceSubbranchArr = registerDO.subbranchArr;
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
}

- (void) didSelectSubbranch: (SubbranchDO *)subbranchDO
{
    UILabel * lab =(UILabel *)[self.view viewWithTag:self.selectButtonIndex/10];
    lab.text = subbranchDO.subbranchName;
    self.subbranchName = subbranchDO.subbranchName;
    self.subbranchID = subbranchDO.subbranchID;
}
#pragma mark

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)chickBankNumberTextField
{
    if (hasBecomeFirstRespond) {
        UITextField * textField = (UITextField *)[self.view viewWithTag:7];
        BOOL isBankCard = [BaseModel checkCardNo:self.bankCardNumber.text];
        if (!isBankCard) {
            [self showWarmingWithMessage:@"银行卡有误"];
            return;
        }
//        if (self.terminalNumber.text.length == kTextLengthZero) {
//            [self showWarmingWithMessage:@"终端号不能为空"];
//            return;
//        }
        
        [UIComponentService showHudWithStatus:kPleaseWait];
        [self performSelector:@selector(bankNameRequest:) withObject:textField.text afterDelay:kDelayTime];
        hasBecomeFirstRespond = NO;
    }
}

- (void)bankNameRequest:(NSString *)bankCardNumber
{
    self.regestDO = [[RegisterDO alloc] init];
    self.regestDO.delegate = self;
    self.regestDO.bankCardNumber = [BaseModel deleteBlankFromString:self.bankCardNumber.text];
//    @"6227003525540023534"
    //self.regestDO.termno =self.terminalNumber.text;
    //[self terminalVerification:self.terminalNumber.text];
//    if (!terminalVerificationEffective) {
//        return;
//    }
    [self.regestDO registerBankNameRequestWithTrancode:kTrancode_Province];
}

- (void)terminalVerification:(NSString *)string
{
    TerminalVerificationDO * term =[[TerminalVerificationDO alloc] init];
    term.trancode = kTrancode_TerminalVerification ;
    term.delegate = self;
    term.phoneNumber = kNil;
    term.userLoginName = kNil;
    term.termno = string;
    term.appType = kAppType;
    [term terminalVerificationRequest];
}
-(BOOL)isValidateEmail:(NSString *)email

{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
    
    
}

- (IBAction)SMSVerificationAction:(id)sender {
    
    
    if (!_agreeProtocol) {
        [self showWarmingWithMessage:@"未同意协议"];
        return;
    }
    //[self registerRequest];
    [self merchantRequest];
    if([self.regestDO.responseCode isEqualToString:@"000002"])
    {
        [self showWarmingWithMessage:@"该手机已注册"];
        return;
    }
    
    
    
    

    [UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(messageVerificateRequest) withObject:nil afterDelay:kDelayTime];
    
}

- (void)messageVerificateRequest
{
    self.regestDO = [[RegisterDO alloc] init];
    self.regestDO.delegate = self;
    
    // 13147047062
    //self.regestDO.termno = self.terminalNumber.text;
//    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                 self.regestDO.termno,@"TERMINALNUMBER",
//                                 kTermType,@"TYPE",
//                                 self.phoneNumber.text,@"PHONENUMBER",
//                                 nil];
    
    NSString * urlStr = [self.regestDO appendPosm5URL:kTrancode_RegisterMessageVerification];
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    //[request addPostValue:self.regestDO.termno forKey:@"TERMINALNUMBER"];
    [request addPostValue:@"2" forKey:@"TRMTYP"];
    [request addPostValue:@"100001" forKey:@"TYPE"];
    [request addPostValue:self.phoneNumber.text forKey:@"PHONENUMBER"];
    
    NSLog(@"url=%@",url);
    
    //NSLog(@"request=%@",request);
    
    [self.regestDO registerMessageVerificationRequestWithRequester:request];
    
    //[self.regestDO registerMessageVerificationRequestWithTrancode:kTrancode_RegisterMessageVerification andRequestMessage:dic];
}

- (IBAction)registerAction:(id)sender {
    
    if (!_agreeProtocol) {
        [self showWarmingWithMessage:@"未同意协议"];
        return;
    }

    BOOL isPhoneNumber =[BaseModel isValidPhone:self.phoneNumber.text];
    if (!isPhoneNumber) {
        [self showWarmingWithMessage:@"手机号有误"];
        return;
    }
    if (self.passWord.text.length < 6) {
        [self showWarmingWithMessage:@"密码为6-15位数字、字母或特殊符号"];
        return;
    }
//    if (self.userCodeNum.text.length == kTextLengthZero) {
//        [self showWarmingWithMessage:@"激活码不能为空"];
//        return;
//    }

    
    
    if (self.messageVerificate.text.length == kTextLengthZero) {
        [self showWarmingWithMessage:@"验证码不能为空"];
        return;
    }
    [UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(registerRequest) withObject:nil afterDelay:kDelayTime];
}
- (void)registerRequest
{
   // @"50410001998"  // 终端号   6222 0210 0111 6245 702
    
   
    //self.regestDO.termno = self.terminalNumber.text;
    self.regestDO.delegate = self;
    NSString * urlStr = [self.regestDO appendPosm5URL:kTrancode_Register];
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    
    [request addPostValue:@"2" forKey:@"TRMTYP"];
    [request addPostValue:self.phoneNumber.text forKey:@"PHONENUMBER"];
    [request addPostValue:@"" forKey:@"REFPHONE"];
    [request addPostValue:@"IOS_qhcs_1.0.0" forKey:@"APPMARKNUMBER"];
    [request addPostValue:self.emailBox.text forKey:@"EMAIL"];
    [request addPostValue:@"3" forKey:@"MERMOD"];
    [request addPostValue:self.inviteTextField.text forKey:@"recommendation"];
    [request addPostValue:self.passWord.text forKey:@"PASSWORD"];
    [request addPostValue:self.messageVerificate.text forKey:@"RANDOM"];
    [request addPostValue:self.userCodeNum.text forKey:@"ACTCODE"];
    
    
    [self.regestDO registerRequestWithRequester:request];
    
}

- (void)merchantRequest
{
    MerchantDO * merchantDO = [[MerchantDO alloc] init];
    merchantDO.delegate = self;
    merchantDO.termType = kTermType;
    merchantDO.phoneNumber = self.phoneNumber.text;
    merchantDO.trancode = kTrancode_MerchantData;
    [merchantDO merchantInformationInquiryRequest];
}

- (IBAction)provinceSelect:(id)sender {
    UIButton * buttonSelected = (UIButton *)sender;
    self.selectButtonIndex = buttonSelected.tag;
    if (![self.bankID isEqualToString:kNil]) {
        [self performSegueWithIdentifier:@"detailSegue" sender:self];
    } else {
        [self showWarmingWithMessage:@"银行名称不能为空"];
    }
}

- (IBAction)citySelect:(id)sender {
    
    if ([self.accountProvince.text isEqualToString:kNil]) {
        [self showWarmingWithMessage:@"请先选择省份"];
        return;
    }
//    if (self.terminalNumber.text.length == kTextLengthZero) {
//        [self showWarmingWithMessage:@"终端号不能为空"];
//        return;
//    }
    
    UIButton * buttonSelected = (UIButton *)sender;
    self.selectButtonIndex = buttonSelected.tag;
    
    [UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(registerCityRequest:) withObject:self.provinceID afterDelay:kDelayTime];
}

- (IBAction)subbranchSelect:(id)sender {
    if ([self.accountCity.text isEqualToString:kNil]) {
        [self showWarmingWithMessage:@"请先选择城市"];
        return;
    }
//    if (self.terminalNumber.text.length == kTextLengthZero) {
//        [self showWarmingWithMessage:@"终端号不能为空"];
//        return;
//    }
    UIButton * buttonSelected = (UIButton *)sender;
    self.selectButtonIndex = buttonSelected.tag;
    
    [UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(registerSubbranchRequest) withObject:nil afterDelay:kDelayTime];
}

- (IBAction)agreeAction:(id)sender {
    UIButton * button = (UIButton *)sender;
    if (_agreeProtocol) {
        [button setImage:nil forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"forgetbutton"] forState:UIControlStateNormal];
        _agreeProtocol = NO;
    } else {
        [button setImage:nil forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"checkbutton"] forState:UIControlStateNormal];
        _agreeProtocol = YES;
    }
}

- (void)registerResponseFailWithMessage:(NSString *)message
{
    
    if([self.regestDO.responseCode isEqualToString:@"100002"])
    {
        return;
    }else
    {
        [UIComponentService showFailHudWithStatus:message];
    }
    
}

- (void)messageVerificationSuccessWithMessage:(NSString *)message
{
    [UIComponentService showSuccessHudWithStatus:message];
    NSLog(@"messageVerificationSuccess");
}

- (void)registerSucessWithMessage:(NSString *)message
{
    [UIComponentService showSuccessHudWithStatus:message];
    [User shareUser].phoneNumber=self.phoneNumber.text;
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)merchantInformationInquiryFieldWithMessage:(NSString *)message
{
    
}

-(void)merchantInformationInquirySuccessWithMessage:(NSString *)message andMerchantDO:(MerchantDO *)merchantDO
{
    [UIComponentService showFailHudWithStatus:@"该手机已被注册"];
}

#pragma  mark - ABdelegate


- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    if (property==kABPersonPhoneProperty) {
        ABMutableMultiValueRef phoneMulti=ABRecordCopyValue(person, property);
        int index= ABMultiValueGetIndexForIdentifier(phoneMulti,identifier);
        NSString *phone=(__bridge NSString*)ABMultiValueCopyValueAtIndex(phoneMulti, index);
        
        NSString *phoneNew;
        
        if([phone rangeOfString:@"+"].location!=NSNotFound)
        {
            phoneNew=[phone substringWithRange:NSMakeRange(0, 3)];
            phoneNew=[phoneNew stringByReplacingOccurrencesOfString:@"-" withString:@""];
        }else
        {
            phoneNew=[phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
        }
        
        
        
        self.inviteTextField.text=phoneNew;
        
        
        //[self performSelector:@selector(merchantRequestWithPhoneNumber:) withObject:phoneNew afterDelay:0.0f];
        
        
        
        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    }
    
}


-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    return YES;
    
}

-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    if (property==kABPersonPhoneProperty) {
        ABMutableMultiValueRef phoneMulti=ABRecordCopyValue(person, property);
        int index= ABMultiValueGetIndexForIdentifier(phoneMulti,identifier);
        NSString *phone=(__bridge NSString*)ABMultiValueCopyValueAtIndex(phoneMulti, index);
        
        NSString *phoneNew;
        
        if([phone rangeOfString:@"+"].location!=NSNotFound)
        {
            phoneNew=[phone substringWithRange:NSMakeRange(0, 3)];
            phoneNew=[phoneNew stringByReplacingOccurrencesOfString:@"-" withString:@""];
        }else
        {
            phoneNew=[phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
        }
        
        
        
        self.inviteTextField.text=phoneNew;
        
        
        //[self performSelector:@selector(merchantRequestWithPhoneNumber:) withObject:phoneNew afterDelay:0.0f];
        
        
        
        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    }
    
    
    return NO;
    
}

-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([string isEqualToString:@""]) {
        if (self.bankCardNumber == textField) {
            if (([textField.text length]-1)%5 == 0) {
                textField.text = [textField.text substringToIndex:textField.text.length -1];
            }
        }
    } else {
        if (self.bankCardNumber == textField) {
            if (([textField.text length]+1)%5 == 0) {
                textField.text = [textField.text stringByAppendingString:@" "];
            }
        }
    }
    
    if (self.phoneNumber == textField)
    {
        if ([toBeString length] > 11) {
            textField.text = [toBeString substringToIndex:11];
            return NO;
        }
    }
    if (self.IDcard == textField)
    {
        if ([toBeString length] > 18) {
            textField.text = [toBeString substringToIndex:18];
            return NO;
        }
    }
    if (self.passWord == textField)
    {
        if ([toBeString length] > 15) {
            textField.text = [toBeString substringToIndex:15];
            return NO;
        }
    }
    if (self.confirmPasssWord == textField)
    {
        if ([toBeString length] > 15) {
            textField.text = [toBeString substringToIndex:15];
            return NO;
        }
    }
    if(self.messageVerificate==textField)
    {
        if([toBeString length]>6)
        {
            textField.text=[toBeString substringFromIndex:6];
            return NO;
        }
    }
    
    
    return YES;
}


@end
