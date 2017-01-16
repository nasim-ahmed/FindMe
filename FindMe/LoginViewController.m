//
//  LoginViewController.m
//  FindMe
//
//  Created by Nasim on 1/16/17.
//  Copyright © 2017 Nasim. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"
#import "Constant.h"
#import "SignUpViewController.h"
#import "HomeViewController.h"

#define kLOGINVC_EMAIL_FIELD_TAG 111
#define kLOGINVC_PASSWORD_FIELD_TAG 112

@interface LoginViewController () <UITextFieldDelegate>
@property (nonatomic, strong) User* User;
@end

@implementation LoginViewController

- (void)dealloc {
    self.User = nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kOFF_WHITE_COLOR;
    
    self.User = [[User alloc] init];
    
    [self SetupViews];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self HideNavigationBar];
}

- (void)HideNavigationBar {
    if (self.navigationController.navigationBar) {
        self.navigationController.navigationBar.hidden = TRUE;
    }
}

- (void)SetupViews {
    CGRect mainFrame = [[UIScreen mainScreen] bounds];
    
    
    CGSize fieldSize = CGSizeMake(mainFrame.size.width - 60, 44);
    
    UITextField* EmailField = [[UITextField alloc] initWithFrame:
                                 CGRectMake(30, 150, fieldSize.width, fieldSize.height)];
    EmailField.tag = kLOGINVC_EMAIL_FIELD_TAG;
    EmailField.layer.cornerRadius = 6;
    [EmailField.layer setBorderColor:kLIGHT_BLUE_COLOR.CGColor];
    [EmailField.layer setBorderWidth:1.0];
    EmailField.backgroundColor = kMILD_BLUE_COLOR;
    EmailField.placeholder = @"Email";
    EmailField.returnKeyType = UIReturnKeyNext;
    EmailField.delegate = self;
    [self.view addSubview:EmailField];
    
    UITextField* PasswordField = [[UITextField alloc] initWithFrame:
                                    CGRectMake(30, (EmailField.frame.origin.y + 50), fieldSize.width, fieldSize.height)];
    PasswordField.tag = kLOGINVC_PASSWORD_FIELD_TAG;
    PasswordField.layer.cornerRadius = 6;
    [PasswordField.layer setBorderColor:kLIGHT_BLUE_COLOR.CGColor];
    [PasswordField.layer setBorderWidth:1.0];
    PasswordField.backgroundColor = kMILD_BLUE_COLOR;
    PasswordField.placeholder = @"Password";
    PasswordField.secureTextEntry = YES;
    PasswordField.returnKeyType = UIReturnKeyDone;
    PasswordField.delegate = self;
    [self.view addSubview:PasswordField];
    
    
    UIButton *LogInButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    LogInButton.frame = CGRectMake(PasswordField.frame.origin. x + 30, PasswordField.frame.origin. y + 70, PasswordField.frame.size.width - 60, 21);
    [LogInButton setTitle:@"LogIn" forState:UIControlStateNormal];
    [LogInButton setTitleColor:[UIColor redColor] forState: UIControlStateHighlighted];
    [LogInButton addTarget:self action:@selector(LoginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [LogInButton setTitleColor:kDEEP_BLUE_COLOR forState: UIControlStateNormal];
    [self.view addSubview:LogInButton];
    
    UIButton *SignUpButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    SignUpButton.frame = CGRectMake(LogInButton.frame.origin. x, LogInButton.frame.origin. y + 40, LogInButton.frame.size.width, LogInButton.frame.size.height);
    [SignUpButton setTitle:@"Sign Up?" forState:UIControlStateNormal];
    [SignUpButton addTarget:self action:@selector(SignUpButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [SignUpButton setTitleColor:kDEEP_BLUE_COLOR forState: UIControlStateHighlighted];
    [SignUpButton setTitleColor:[UIColor redColor] forState: UIControlStateNormal];
    [self.view addSubview:SignUpButton];
}

- (void)LoginButtonAction:(id)sender {
    [self UserSuccessCheck];
}

- (void)SignUpButtonAction:(id)sender {
    SignUpViewController* signUpViewController = [[SignUpViewController alloc] init];
    UINavigationController* NavigationController = [[UINavigationController alloc] initWithRootViewController:signUpViewController];
    [self presentViewController:NavigationController animated:YES completion: NULL];
}


- (void)UserSuccessCheck {
    if ([User IsValid: self.User]) {
        HomeViewController *homeViewController = [[HomeViewController alloc] init];
        [self.navigationController pushViewController:homeViewController animated:YES];
    } else {
        
        UIAlertController* allertController = [UIAlertController alertControllerWithTitle:@"Authentication Failure" message: @"Check your Email or Password" preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle: @"OK" style:UIAlertActionStyleDefault handler:nil];
        [allertController addAction:ok];
        
        [self presentViewController:allertController animated:YES completion:nil];
        
    }
}

#pragma mark --
#pragma mark -- UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField.tag == kLOGINVC_EMAIL_FIELD_TAG) {
        [self.User SetEmail: @""];
    }
    
    if (textField.tag == kLOGINVC_PASSWORD_FIELD_TAG) {
        [self.User SetPassword: @""];
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    if(textField.tag == kLOGINVC_EMAIL_FIELD_TAG) {
        [self.User SetEmail: textField.text];
    }
    
    if (textField.tag == kLOGINVC_PASSWORD_FIELD_TAG) {
        [self.User SetPassword: textField.text];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField.tag == kLOGINVC_EMAIL_FIELD_TAG) {
        [textField resignFirstResponder];
        
        UITextField* PasswordField = (UITextField*) [self.view viewWithTag:kLOGINVC_PASSWORD_FIELD_TAG];
        if (PasswordField != nil) {
            [PasswordField becomeFirstResponder];
        }
    }
    
    if (textField.tag == kLOGINVC_PASSWORD_FIELD_TAG) {
        [textField resignFirstResponder];
        [self UserSuccessCheck];
    }
    
    return YES;
}
@end

