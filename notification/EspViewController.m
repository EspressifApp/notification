
//
//  EspViewController.m
//  notification
//
//  Created by 白 桦 on 9/9/15.
//  Copyright (c) 2015 白 桦. All rights reserved.
//

#import "EspViewController.h"
#import "ESPUser.h"

@interface EspViewController()
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UILabel *labelStatus;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnRegisterUnregister;
@property (assign, nonatomic) __block BOOL isLogin;
@property (assign, nonatomic) __block BOOL isRegister;
@property (nonatomic, strong) UIButton *_doneButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@end

// the three constants are used to hide soft-keyboard when user tap Enter or Return
#define HEIGHT_KEYBOARD 216
#define HEIGHT_TEXT_FIELD 30
#define HEIGHT_SPACE (6+HEIGHT_TEXT_FIELD)


@implementation EspViewController

- (IBAction)tapLogin:(id)sender {
    [self doLoginBtnAction];
}

- (IBAction)tapRegisterUnregister:(id)sender {
    if (self.isRegister)
    {
        [self doUnregisterAction];
    }
    else
    {
        [self doRegisterAction];
    }
}

- (void)enableLoginBtn
{
    self.isLogin = NO;
    [self.btnLogin setTitle:@"Login" forState:UIControlStateNormal];
    self.labelStatus.text = @"Logout";
}

- (void)loginSuc
{
    self.isLogin = YES;
    self.isRegister = NO;
    self.labelStatus.text = @"Login/Unregister";
    [self.btnRegisterUnregister setTitle:@"Register" forState:UIControlStateNormal];
}

- (void)enableRegisterBtn
{
    self.isRegister = NO;
    [self.btnRegisterUnregister setTitle:@"Register" forState:UIControlStateNormal];
    self.labelStatus.text = @"Login/Unregister";
}

- (void)enableUnregisterBtn
{
    self.isRegister = YES;
    [self.btnRegisterUnregister setTitle:@"Unregister" forState:UIControlStateNormal];
    self.labelStatus.text = @"Login/Register";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"EspViewController viewDidLoad()");
    self.tfEmail.delegate = self;
    self.tfEmail.keyboardType = UIKeyboardTypeASCIICapable;
    self.tfPassword.delegate = self;
    self.tfPassword.keyboardType = UIKeyboardTypeASCIICapable;
    [self enableRegisterBtn];
    [self enableLoginBtn];
}

- (void)doLoginBtnAction
{
    NSLog(@"EspViewController doLoginBtnAction");
    
    [self.indicator startAnimating];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSString *email = self.tfEmail.text;
        NSString *password = self.tfPassword.text;
        
        ESPUser *user = [ESPUser sharedInstance];
        ESPLoginResultEnum loginResult = [user doActionInternetUserLoginWithEmail:email password:password];
        NSString *alertViewTitle = @"Login";
        NSString *alertViewMessage = nil;
        switch (loginResult)
        {
            case LOGIN_SUC:
                NSLog(@"EspViewController doLoginBtnAction LOGIN_SUC");
                alertViewMessage = @"login suc";
                break;
            case LOGIN_PASSWORD_ERR:
                NSLog(@"EspViewController doLoginBtnAction LOGIN_PASSWORD_ERR");
                alertViewMessage = @"login password error";
                break;
            case LOGIN_NETWORK_UNACCESSIBLE:
                NSLog(@"EspViewController doLoginBtnAction LOGIN_NETWORK_UNACCESSIBLE");
                alertViewMessage = @"login network unaccessible error";
                break;
            case LOGIN_NOT_REGISTER:
                NSLog(@"EspViewController doLoginBtnAction LOGIN_NOT_REGISTER");
                alertViewMessage = @"login not register error";
                break;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:alertViewTitle message:alertViewMessage delegate:nil cancelButtonTitle:@"I know" otherButtonTitles:nil];
            [alertView show];
            [self.indicator stopAnimating];
            if (loginResult==LOGIN_SUC)
            {
                [self loginSuc];
            }
        });
    });
}

- (void)doRegisterAction
{
    NSLog(@"EspViewController doRegisterAction");
    if (!self.isLogin)
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Register" message:@"Please login firstly" delegate:nil cancelButtonTitle:@"I know" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    
    [self.indicator startAnimating];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        ESPUser *user = [ESPUser sharedInstance];
        NSString *userKey = user.userKey;
        NSString *apnsToken = user.apnsToken;
        NSString *deviceToken = user.deviceToken;
        ESPApnsRegisterResultEnum apnsRegisterResult = [user doActionInternetUserApnsRegisterWithUserKey:userKey AndApnsToken:apnsToken AndDeviceToken:deviceToken];
        NSString *alertViewTitle = @"ApnsRegister";
        NSString *alertViewMessage = nil;
        
        switch (apnsRegisterResult) {
            case APNS_REGISTER_APNS_TOKEN_ERR:
                NSLog(@"EspViewController doRegisterAction APNS_REGISTER_APNS_TOKEN_ERR");
                alertViewMessage = @"apns register apns token error";
                break;
            case APNS_REGISTER_NETWORK_UNACCESSIBLE:
                NSLog(@"EspViewController doRegisterAction APNS_REGISTER_NETWORK_UNACCESSIBLE");
                alertViewMessage = @"apns register apns network unaccessible error";
                break;
            case APNS_REGISTER_SUC:
                NSLog(@"EspViewController doRegisterAction APNS_REGISTER_SUC");
                alertViewMessage = @"apns register suc";
                break;
            case APNS_REGISTER_USER_KEY_ERR:
                NSLog(@"EspViewController doRegisterAction APNS_REGISTER_USER_KEY_ERR");
                alertViewMessage = @"apns register user key error";
                break;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:alertViewTitle message:alertViewMessage delegate:nil cancelButtonTitle:@"I know" otherButtonTitles:nil];
            [alertView show];
            [self.indicator stopAnimating];
            if (apnsRegisterResult==APNS_REGISTER_SUC) {
                [self enableUnregisterBtn];
            }
        });
    });
}

- (void)doUnregisterAction
{
    NSLog(@"EspViewController doUnregisterAction");
    if (!self.isLogin)
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Unregister" message:@"Please login firstly" delegate:nil cancelButtonTitle:@"I know" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    
    [self.indicator startAnimating];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        ESPUser *user = [ESPUser sharedInstance];
        NSString *apnsToken = user.apnsToken;
        NSString *deviceToken = user.deviceToken;
        ESPApnsUnregisterResultEnum apnsRegisterResult = [user doActionInternetUserApnsUnregisterWithApnsToken:apnsToken andDeviceToken:deviceToken];
        NSString *alertViewTitle = @"ApnsUnregister";
        NSString *alertViewMessage = nil;
        
        switch (apnsRegisterResult) {
            case APNS_UNREGISTER_APNS_TOKEN_ERR:
                NSLog(@"EspViewController doRegisterAction APNS_UNREGISTER_APNS_TOKEN_ERR");
                alertViewMessage = @"apns unregister apns token error";
                break;
            case APNS_UNREGISTER_NETWORK_UNACCESSIBLE:
                NSLog(@"EspViewController doRegisterAction APNS_UNREGISTER_NETWORK_UNACCESSIBLE");
                alertViewMessage = @"apns unregister apns network unaccessible error";
                break;
            case APNS_UNREGISTER_SUC:
                NSLog(@"EspViewController doRegisterAction APNS_UNREGISTER_SUC");
                alertViewMessage = @"apns unregister suc";
                break;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:alertViewTitle message:alertViewMessage delegate:nil cancelButtonTitle:@"I know" otherButtonTitles:nil];
            [alertView show];
            [self.indicator stopAnimating];
            if (apnsRegisterResult==APNS_REGISTER_SUC) {
                [self enableRegisterBtn];
            }
        });
    });
}


#pragma mark - the follow codes are just to make soft-keyboard disappear at necessary time

// when out of pwd textview, resign the keyboard
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![self.tfEmail isExclusiveTouch])
    {
        [self.tfEmail resignFirstResponder];
    }
    if (![self.tfPassword isExclusiveTouch]) {
        [self.tfPassword resignFirstResponder];
    }
}

#pragma mark -  the follow three methods are used to make soft-keyboard disappear when user finishing editing

// when textField begin editing, soft-keyboard apeear, do the callback
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y - (self.view.frame.size.height - (HEIGHT_KEYBOARD+HEIGHT_SPACE));
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    if(offset > 0)
    {
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    [UIView commitAnimations];
}

// when user tap Enter or Return, disappear the keyboard
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

// when finish editing, make view restore origin state
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void) addButtonToKeyboard {
    // create custom button
    if (self._doneButton == nil) {
        self._doneButton  = [[UIButton alloc] initWithFrame:CGRectMake(0, 163, 106, 53)];
    }
    else {
        [self._doneButton setHidden:NO];
    }
    
    [self._doneButton addTarget:self action:@selector(doneButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    // locate keyboard view
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    UIView* keyboard = nil;
    for(int i=0; i<[tempWindow.subviews count]; i++) {
        keyboard = [tempWindow.subviews objectAtIndex:i];
        // keyboard found, add the button
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
            if([[keyboard description] hasPrefix:@"<UIPeripheralHost"] == YES)
                [keyboard addSubview:self._doneButton];
        } else {
            if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)
                [keyboard addSubview:self._doneButton];
        }
    }
}

- (void) doneButtonClicked:(id)Sender {
    //Write your code whatever you want to do on done button tap
    //Removing keyboard or something else
    
    if (![self.tfEmail isExclusiveTouch]) {
        [self.tfEmail resignFirstResponder];
    }
    if (![self.tfPassword isExclusiveTouch]) {
        [self.tfPassword resignFirstResponder];
    }
}

@end
