//
//  SignUpViewController.m
//  FindMe
//
//  Created by Nasim on 1/16/17.
//  Copyright © 2017 Nasim. All rights reserved.
//

#import "SignUpViewController.h"
#import "Constant.h"
#import "User.h"


#define kSIGNINVC_NAME_FIELD_TAG 112
#define kSIGNINVC_EMAIL_FIELD_TAG 113
#define kSIGNINVC_PASSWORD_FIELD_TAG 114
#define kSIGNINVC_ADDRESS_VIEW_TAG 115



@interface SignUpViewController () <UITextFieldDelegate, UITextViewDelegate>
@property (nonatomic, strong) User* User;
@end

@implementation SignUpViewController

- (void)dealloc {
    self.User = nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kOFF_WHITE_COLOR;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(DismissViewController:)];
    
    self.User = [[User alloc] init];
    
    [self SetupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)SetupViews {
    CGRect mainFrame = [[UIScreen mainScreen] bounds];
    CGSize fieldSize = CGSizeMake(mainFrame.size.width - 60, 44);
    
    UITextField* NameField = [[UITextField alloc] initWithFrame:
                                CGRectMake(30, 100, fieldSize.width, fieldSize.height)];
    NameField.tag = kSIGNINVC_NAME_FIELD_TAG;
    NameField.layer.cornerRadius = 6;
    [NameField.layer setBorderColor:kLIGHT_BLUE_COLOR.CGColor];
    [NameField.layer setBorderWidth:1.0];
    NameField.backgroundColor = kMILD_BLUE_COLOR;
    NameField.placeholder = @"Full Name";
    NameField.returnKeyType = UIReturnKeyNext;
    NameField.delegate = self;
    [self.view addSubview:NameField];
    
    UITextField* EmailField = [[UITextField alloc] initWithFrame:
                                 CGRectMake(30, (NameField.frame.origin.y + 50), fieldSize.width, fieldSize.height)];
    EmailField.tag = kSIGNINVC_EMAIL_FIELD_TAG;
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
    PasswordField.tag = kSIGNINVC_PASSWORD_FIELD_TAG;
    PasswordField.layer.cornerRadius = 6;
    [PasswordField.layer setBorderColor:kLIGHT_BLUE_COLOR.CGColor];
    [PasswordField.layer setBorderWidth:1.0];
    PasswordField.secureTextEntry = YES;
    PasswordField.backgroundColor = kMILD_BLUE_COLOR;
    PasswordField.placeholder = @"Password";
    PasswordField.returnKeyType = UIReturnKeyNext;
    PasswordField.delegate = self;
    [self.view addSubview:PasswordField];
    
    
    UITextView* AddressView = [[UITextView alloc] initWithFrame:CGRectMake(30, PasswordField.frame.origin. y + 50, PasswordField.frame.size.width, 90)];
    AddressView.tag = kSIGNINVC_ADDRESS_VIEW_TAG;
    AddressView.layer.cornerRadius = 6;
    [AddressView.layer setBorderColor:kLIGHT_BLUE_COLOR.CGColor];
    [AddressView.layer setBorderWidth:1.0];
    AddressView.backgroundColor = kMILD_BLUE_COLOR;
    AddressView.returnKeyType = UIReturnKeyDone;
    AddressView.delegate = self;
    [self.view addSubview:AddressView];
    
    
    UIButton *SignUpButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    SignUpButton.frame = CGRectMake(AddressView.frame.origin. x +  30, AddressView.frame.origin. y +  (AddressView.frame.size.height + 20), PasswordField.frame.size.width - 60, 21);
    [SignUpButton setTitle:@"Submit" forState:UIControlStateNormal];
    [SignUpButton setTitleColor:[UIColor redColor] forState: UIControlStateHighlighted];
    [SignUpButton addTarget:self action:@selector(SaveUserInfo) forControlEvents:UIControlEventTouchUpInside];
    [SignUpButton setTitleColor:kDEEP_BLUE_COLOR forState: UIControlStateNormal];
    [self.view addSubview:SignUpButton];
}


- (void)DismissViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)SaveUserInfo {
    
    [User UserStore:self.User];
    [self DismissViewController: nil];
}

#pragma mark --
#pragma mark -- UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if(textField.tag == kSIGNINVC_NAME_FIELD_TAG) {
        [self.User SetName: @""];
    }
    
    if (textField.tag == kSIGNINVC_EMAIL_FIELD_TAG) {
        [self.User SetEmail: @""];
    }
    
    if (textField.tag == kSIGNINVC_PASSWORD_FIELD_TAG) {
        [self.User SetPassword: @""];
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    if(textField.tag == kSIGNINVC_NAME_FIELD_TAG) {
        [self.User SetName:  textField.text];
    }
    
    if (textField.tag == kSIGNINVC_EMAIL_FIELD_TAG) {
        [self.User SetEmail: textField.text];
    }
    
    if (textField.tag == kSIGNINVC_PASSWORD_FIELD_TAG) {
        [self.User SetPassword: textField.text];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField.tag == kSIGNINVC_NAME_FIELD_TAG) {
        [textField resignFirstResponder];
        
        UITextField* EmailField = (UITextField*) [self.view viewWithTag:kSIGNINVC_EMAIL_FIELD_TAG];
        if (EmailField != nil) {
            [EmailField becomeFirstResponder];
        }
    }
    
    if (textField.tag == kSIGNINVC_EMAIL_FIELD_TAG) {
        [textField resignFirstResponder];
        
        UITextField* PasswordField = (UITextField*) [self.view viewWithTag:kSIGNINVC_PASSWORD_FIELD_TAG];
        if (PasswordField != nil) {
            [PasswordField becomeFirstResponder];
        }
    }
    
    if (textField.tag == kSIGNINVC_PASSWORD_FIELD_TAG) {
        [textField resignFirstResponder];
        UITextView* AddressView = (UITextView*) [self.view viewWithTag:kSIGNINVC_ADDRESS_VIEW_TAG];
        if (AddressView != nil) {
            [AddressView becomeFirstResponder];
        }
    }
    return YES;
}

#pragma mark --
#pragma mark -- UITextFieldDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self.User SetAddress:@""];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self.User SetAddress:textView.text];
}

- (BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text {
    if ([text isEqualToString:@"\n"]) {
        [self.User SetAddress:textView.text];
        [textView resignFirstResponder];
        [self SaveUserInfo];
        return NO;
    }
    return YES;
}
@end
