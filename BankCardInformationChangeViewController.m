//
//  BankCardInformationChangeViewController.m
//  BusinessPay
//
//  Created by Tears on 14-4-16.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "BankCardInformationChangeViewController.h"
#import "RealNameVerificationViewController.h"
#import "BankCardUploadPhotoViewController.h"

@interface BankCardInformationChangeViewController ()
{
    NSInteger   selectedTextFieldTag;
    BOOL    hasBecomeFirstRespond;
    BOOL    isFromBankCardChanged;
    NSArray *arr;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *userName;             // 用户姓名
@property (weak, nonatomic) IBOutlet UITextField *IDcard;               // 身份证号码
@property (weak, nonatomic) IBOutlet UITextField *bankCardNumber;       // 银行卡号
@property (weak, nonatomic) IBOutlet UILabel *bankName;                 // 银行名称
@property (weak, nonatomic) IBOutlet UILabel *accountProvince;          // 账户省份
@property (weak, nonatomic) IBOutlet UILabel *accountCity;              // 账户城市
@property (weak, nonatomic) IBOutlet UILabel *accountSubbranch;         // 账户支行

//@property (strong, nonatomic)RegisterDO * regestDO;
@property (strong, nonatomic)NSMutableArray * detailVCDataSourceProvinceArr;        // province
@property (strong, nonatomic)NSMutableArray * detailVCDataSourceCityArr;            // city
@property (strong, nonatomic)NSMutableArray * detailVCDataSourceSubbranchArr;       // Subbranch
@property (assign, nonatomic)int selectButtonIndex;

@property (nonatomic, copy)NSString * bankID;                           // 开户行名称ID
@property (nonatomic, copy)NSString * provinceID;                       // 开户省ID
@property (nonatomic, copy)NSString * cityID;                           // 开户城市ID
@property (nonatomic, copy)NSString * subbranchID;                      // 开户支行ID
@property (nonatomic, copy)NSString * subbranchName;                    // 开户行支行名称

- (IBAction)submitAction:(id)sender;                                    // 提交
- (IBAction)provinceSelect:(id)sender;
- (IBAction)citySelect:(id)sender;
- (IBAction)subbranchSelect:(id)sender;
- (IBAction)tapAction:(UITapGestureRecognizer *)sender;

@end

@implementation BankCardInformationChangeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.scrollView.frame =self.view.bounds;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"bankCardChangeSegue"]) {
        RealNameVerificationViewController * realNameVC = (RealNameVerificationViewController *)segue.destinationViewController;
        realNameVC.type = RealNameVerificationType_Bankcard;
    }
    if([segue.identifier isEqualToString:@"photoSegue"])
    {
        BankCardUploadPhotoViewController *bankCardUpLoadVC=(BankCardUploadPhotoViewController *)segue.destinationViewController;
        bankCardUpLoadVC.array=arr;
    }
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

- (void)setKeyBoard
{
    NSArray *tfArr = [NSArray arrayWithObjects:_userName,_bankCardNumber ,nil];
    
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


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollView setScrollEnabled:NO];
     self.scrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, 471);
    [self setLabBackground];
    
    //arr=[[NSArray alloc] init:128];
    
    
//    UITapGestureRecognizer *ges=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    self.bankName.userInteractionEnabled =YES;
//    ges.numberOfTapsRequired=1;
//    ges.numberOfTouchesRequired=1;
//    [self.bankName addGestureRecognizer:ges];
    
    
    //[UIComponentService showHudWithStatus:@"正在加载商户资料..."];
    [self performSelector:@selector(merchantMessageRequest) withObject:nil afterDelay:kDelayTime];
    self.navigationItem.titleView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 50.0f)];
    UILabel *  lable = (UILabel *)self.navigationItem.titleView ;
    [lable setText:@"开户银行信息修改"];
    lable.font = [UIFont boldSystemFontOfSize:20];
    [lable setTextColor:[UIColor whiteColor]];
    [lable setTextAlignment:NSTextAlignmentCenter];
}

//- (IBAction)tapAction:(UITapGestureRecognizer *)sender;
- (void)merchantMessageRequest
{
    MerchantDO * merchantDO = [[MerchantDO alloc] init];
    merchantDO.delegate = self;
    merchantDO.termno = [User shareUser].termno;
    merchantDO.termType = kTermType;
    merchantDO.phoneNumber = [User shareUser].phoneNumber;
    merchantDO.trancode = kTrancode_MerchantData;
    [merchantDO merchantInformationInquiryRequest];
}

- (void)merchantRequest
{
    _merchantDO = [[MerchantDO alloc] init];
    _merchantDO.delegate = self;
    _merchantDO.phoneNumber = [User shareUser].phoneNumber;
    _merchantDO.trancode = kTrancode_BankMessageChangeMerchantData;
    [_merchantDO bankCardMessageChangeMerchantInformationInquiryRequest];
}

- (void)merchantInformationInquirySuccessWithMessage: (NSString *)message andMerchantDO:(MerchantDO *)merchantDO
{
    //[UIComponentService showSuccessHudWithStatus:message];
    NSString *merchantFirstName;
    NSString *merchantLastName;

    if(merchantDO.merchantName.length==3)
    {
        merchantFirstName= [merchantDO.merchantName substringToIndex:merchantDO.merchantName.length-2];
        merchantLastName= [merchantDO.merchantName substringFromIndex:2];
        self.userName.text   = [NSString stringWithFormat:@"%@*%@",merchantFirstName,merchantLastName];
        
    }else if (merchantDO.merchantName.length==4)
    {
        merchantFirstName=[merchantDO.merchantName substringToIndex:merchantDO.merchantName.length-3];
        merchantLastName=[merchantDO.merchantName substringFromIndex:3];
        self.userName.text   = [NSString stringWithFormat:@"%@**%@",merchantFirstName,merchantLastName];
    }else if (merchantDO.merchantName.length==2)
    {
        merchantFirstName=[merchantDO.merchantName substringToIndex:merchantDO.merchantName.length-1];
       
        self.userName.text   = [NSString stringWithFormat:@"%@*",merchantFirstName];
    }


//    self.bankCardNumber.text    = merchantDO.bankCardNumber;
//    self.bankName.text          = merchantDO.bankName;
//    self.IDcard.text            = merchantDO.IDCard;
    if ([User shareUser].verificationStatus == VerificationStatusType_Passed) {
        self.userName.userInteractionEnabled        = NO;
        self.bankCardNumber.userInteractionEnabled  = YES;
        self.bankName.userInteractionEnabled        = YES;
    }
    
    //[UIComponentService showHudWithStatus:@"正在加载商户资料..."];
    [self performSelector:@selector(merchantRequest) withObject:nil afterDelay:kDelayTime];
}

-(void)messageVerificationSuccessWithMessage:(NSString *)message{
    
}




- (void)merchantBankInformationInquirySuccessWithMessage: (NSString *)message andMerchantDO:(MerchantDO *)merchantDO
{
    //[UIComponentService showSuccessHudWithStatus:message];
//    self.bankID                 = merchantDO.bankID;
//    self.accountProvince.text   = merchantDO.provinceName;
//    self.provinceID             = merchantDO.provinceID;
//    self.accountCity.text       = merchantDO.cityName;
//    self.cityID                 = merchantDO.cityID;
//    self.accountSubbranch.text  = merchantDO.subbranchName;
//    self.subbranchID            = merchantDO.subbranchID;
}

- (void)merchantInformationInquiryFieldWithMessage: (NSString *)message
{
    [UIComponentService showFailHudWithStatus:message];
}

- (void)setLabBackground
{
    for (int i = 8; i < 12; i++) {
        UILabel * lab = (UILabel *)[self.view viewWithTag:i];
        lab.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"registertext"]];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 7 ) {
        hasBecomeFirstRespond = YES;
    } else {
        hasBecomeFirstRespond = NO ;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self chickBankNumberTextField];
    return YES;
}



- (IBAction)submitAction:(id)sender {
    
     if (self.changeType == BankCardChangeType_Application) {
        
        if (self.bankName.text.length == kTextLengthZero) {
            [self showWarmingWithMessage:@"银行名称不能为空"];
            return;
        }
        if (self.bankCardNumber.text.length == kTextLengthZero) {
            [self showWarmingWithMessage:@"银行卡不能为空"];
            return;
        }
        if (self.userName.text.length == kTextLengthZero) {
            [self showWarmingWithMessage:@"用户名不能为空"];
            return;
        }
        
        [UIComponentService showHudWithStatus:kPleaseWait];
        [self performSelector:@selector(changeRquest) withObject:nil afterDelay:kDelayTime];
        
    }
    
    /*
    <?xml version="1.0" encoding="UTF-8"?><EPOSPROTOCOL><RSPCOD>000000</RSPCOD><RSPMSG>更新成功</RSPMSG><PACKAGEMAC>551CD9246E352A423486E7189E33A568</PACKAGEMAC></EPOSPROTOCOL>
    */
}

- (void)changeRquest
{
    BankCardChangeDO * bankCardChangeDO = [[BankCardChangeDO alloc] init];
    bankCardChangeDO.delegate       = self;
    bankCardChangeDO.trancode       = kTrancode_BankMessageChange ;
    bankCardChangeDO.phoneNumber    = [User shareUser].phoneNumber;
    bankCardChangeDO.bankName       = self.bankName.text;
    bankCardChangeDO.provinceID     = self.provinceID;
    bankCardChangeDO.cityID         = self.cityID;
    //bankCardChangeDO.subbranchID    = self.subbranchID;
    bankCardChangeDO.cardNumber     = self.bankCardNumber.text;
    bankCardChangeDO.userName       =[User shareUser].userName;
   
    [bankCardChangeDO bankCardChangeApplicationRequest];
}

- (void)uploadBanckCardMessage
{
    if (!self.regestDO) {
        self.regestDO = [[RegisterDO alloc] init];
    }
    self.regestDO.termno = [User shareUser].termno;
    NSString * urlStr = [self.regestDO appendPosm5URL:kTrancode_BankCardChangeNotVerification];
    NSURL * url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request addPostValue:self.regestDO.termno forKey:@"TERMNO"];
    [request addPostValue:kTermType forKey:@"TRMTYP"];
    [request addPostValue:[User shareUser].phoneNumber forKey:@"PHONENUMBER"];
    [request addPostValue: [User shareUser].userName forKey:@"ACTNAM"];
    [request addPostValue:self.IDcard.text forKey:@"IDCARD"];
    [request addPostValue:self.bankCardNumber.text forKey:@"ACTNO"];
    [request addPostValue:self.bankName.text forKey:@"OPNBNK"];
    [request addPostValue:self.provinceID forKey:@"OPNBNKPRO"];
    [request addPostValue:self.cityID forKey:@"OPNBNKCITY"];
    [request addPostValue:self.subbranchID forKey:@"OPNBNKBRA"];
    
    NSLog(@"User=%@",_merchantDO.merchantName);

    self.regestDO.delegate =  self;
    
    arr=[NSArray arrayWithObjects:kTermType,self.userName.text,self.bankCardNumber.text,self.bankName.text,self.provinceID,self.cityID,self.subbranchID, nil];
    
    [self.regestDO registerRequestWithRequester:request];
    //[self.regestDO registerRequestWithTrancode:kTrancode_BankCardChangeNotVerification andRequestMessage:dic];
}

- (void)changSuccessWithMessage :(NSString *)message
{
    [UIComponentService showSuccessHudWithStatus:@"请拍摄正面照和情景照"];
    [self performSegueWithIdentifier:@"photoSegue" sender:nil];
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)changFailWithMessage :(NSString *)message
{
    [UIComponentService showFailHudWithStatus:message];
}

- (void)responseSuccess:(RegisterDO *)registerDO
{
    [UIComponentService showSuccessHudWithStatus:registerDO.responseMessage];
    _detailVCDataSourceProvinceArr = registerDO.provinceArr;
    if (self.bankID != nil && registerDO.bankID != self.bankID) {
        [self resetBankMessage];
    }
    self.bankID = registerDO.bankID;
    UILabel * lab = (UILabel *)[self.view viewWithTag:8];
    lab.text = registerDO.belongsBankName;
    if (!isFromBankCardChanged) {
        [self performSegueWithIdentifier:@"detailSegue" sender:self];
    }
}

- (void)responseFildWithMessage: (NSString *)message
{
    [UIComponentService showFailHudWithStatus:message];
    [self resetBankMessage];
}

- (void)resetBankMessage
{
    self.bankName.text          = kNil;
    self.bankID                 = kNil;
    self.accountProvince.text   = kNil;
    self.accountCity.text       = kNil;
    self.accountSubbranch.text  = kNil;
    self.provinceID             = kNil;
    self.cityID                 = kNil;
    self.subbranchID            = kNil;
}

- (void)bankNameRequest:(NSString *)bankCardNumber
{
    self.regestDO = [[RegisterDO alloc] init];
    self.regestDO.delegate          = self;
    self.regestDO.bankCardNumber    = self.bankCardNumber.text;
    self.regestDO.termno            =[User shareUser].termno;
    [self.regestDO registerBankNameRequestWithTrancode:kTrancode_Province];
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
    if (!self.regestDO) {
        self.regestDO = [[RegisterDO alloc] init];
    }
    self.regestDO.termno = [User shareUser].termno;
    self.regestDO.delegate = self;
    [self.regestDO registerCityNameRequestWithTrancode:kTrancode_City andProvinceID:provinceID];
    
   // [self.regestDO registerCityNameRequestWithRequester:request];
    
    
    //[self.regestDO registerCityNameRequestWithTrancode:kTrancode_City andRequestMessage:dic];
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
        self.accountSubbranch.text = kNil;
        self.subbranchID = kNil;
    }
    lab.text = cityDO.cityName;
    self.cityID = cityDO.cityID;
}

- (void)registerSubbranchRequest
{
    if (!self.regestDO) {
        self.regestDO = [[RegisterDO alloc] init];
    }
    //self.regestDO.termno = [User shareUser].termno;
    self.regestDO.delegate = self;

    
    [self.regestDO registerSubbranchRequestWithTrancode:kTrancode_Subbranch andProvinceID:self.provinceID andCityID:self.cityID andBankID:self.bankID];
    NSLog(@"bankID=%@",self.bankID);
    
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

- (IBAction)provinceSelect:(id)sender {
    UIButton * buttonSelected = (UIButton *)sender;
    self.selectButtonIndex = buttonSelected.tag;
    if (self.bankID.length != kTextLengthZero) {
        [UIComponentService showHudWithStatus:kPleaseWait];
        isFromBankCardChanged = NO ;
        [self performSelector:@selector(bankNameRequest:) withObject:self.bankCardNumber.text afterDelay:kDelayTime];
    } else {
        [self showWarmingWithMessage:@"银行卡有误"];
    }
}

- (IBAction)citySelect:(id)sender {
    if (self.accountProvince.text.length == kTextLengthZero) {
        [self showWarmingWithMessage:@"请先选择省份"];
        return;
    }
    UIButton * buttonSelected = (UIButton *)sender;
    self.selectButtonIndex = buttonSelected.tag;
    [UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(registerCityRequest:) withObject:self.provinceID afterDelay:kDelayTime];
}

- (IBAction)subbranchSelect:(id)sender {
    if (self.accountCity.text.length == kTextLengthZero) {
        [self showWarmingWithMessage:@"请先选择城市"];
        return;
    }
    UIButton * buttonSelected = (UIButton *)sender;
    self.selectButtonIndex = buttonSelected.tag;
    [UIComponentService showHudWithStatus:kPleaseWait];
    [self performSelector:@selector(registerSubbranchRequest) withObject:nil afterDelay:kDelayTime];
}

- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    [self chickBankNumberTextField];
}


- (void)chickBankNumberTextField
{
    if (!hasBecomeFirstRespond) {
        UITextField * textField = (UITextField *)[self.view viewWithTag:7];
        BOOL isBankCard = [BaseModel checkCardNo:self.bankCardNumber.text];
        if (!isBankCard) {
            [self showWarmingWithMessage:@"银行卡有误"];
            return;
        }
        isFromBankCardChanged = YES;
        [UIComponentService showHudWithStatus:kPleaseWait];
        [self performSelector:@selector(bankNameRequest:) withObject:textField.text afterDelay:kDelayTime];
        hasBecomeFirstRespond = NO;
    }
}

- (void)registerSucessWithMessage:(NSString *)message
{
    [UIComponentService showSuccessHudWithStatus:message];
    [self performSelector:@selector(popViewController) withObject:nil afterDelay:1.5f];
}

-(void)registerResponseFailWithMessage:(NSString *)message
{
    
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
    
    if (self.IDcard == textField)
    {
        if ([toBeString length] > 18) {
            textField.text = [toBeString substringToIndex:18];
            return NO;
        }
    }
    return YES;
}

@end
