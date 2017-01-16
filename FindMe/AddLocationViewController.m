//
//  AddLocationViewController.m
//  FindMe
//
//  Created by Nasim on 1/16/17.
//  Copyright © 2017 Nasim. All rights reserved.
//

#import "AddLocationViewController.h"
#import "Constant.h"


#define kADDLOCATIONVC_TITLE_FIELD_TAG 112
#define kADDLOCATIONVC_SUBTITLE_FIELD_TAG 113
#define kADDLOCATIONVC_LAT_FIELD_TAG 114
#define kADDLOCATIONVC_LON_FIELD_TAG 115

#define kADDLOCATIONVC_INVALID_LAT 115
#define kADDLOCATIONVC_INVALID_LATLON -200.0




@interface AddLocationViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) MKPointAnnotation* Annotation;
@end

@implementation AddLocationViewController

- (void)dealloc {
    self.Annotation = nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kOFF_WHITE_COLOR;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(DismissViewController:)];
    self.title = @"Add Location";
    
    [self SetupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)DismissViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)SetupViews {
    CGRect mainFrame = [[UIScreen mainScreen] bounds];
    CGSize fieldSize = CGSizeMake(mainFrame.size.width - 60, 44);
    
    UITextField* LocTitleField = [[UITextField alloc] initWithFrame:
                                    CGRectMake(30, 100, fieldSize.width, fieldSize.height)];
    LocTitleField.tag = kADDLOCATIONVC_TITLE_FIELD_TAG;
    LocTitleField.layer.cornerRadius = 6;
    [LocTitleField.layer setBorderColor:kLIGHT_BLUE_COLOR.CGColor];
    [LocTitleField.layer setBorderWidth:1.0];
    LocTitleField.backgroundColor = kMILD_BLUE_COLOR;
    LocTitleField.placeholder = @"Enter Place Name";
    LocTitleField.returnKeyType = UIReturnKeyNext;
    LocTitleField.delegate = self;
    [self.view addSubview:LocTitleField];
    
    UITextField* LocLatField = [[UITextField alloc] initWithFrame:
                                  CGRectMake(30, (LocTitleField.frame.origin.y + 50), fieldSize.width/3, fieldSize.height)];
    LocLatField.tag = kADDLOCATIONVC_LAT_FIELD_TAG;
    LocLatField.layer.cornerRadius = 6;
    [LocLatField.layer setBorderColor:kLIGHT_BLUE_COLOR.CGColor];
    [LocLatField.layer setBorderWidth:1.0];
    LocLatField.keyboardType = UIKeyboardTypeDecimalPad;
    LocLatField.backgroundColor = kMILD_BLUE_COLOR;
    LocLatField.placeholder = @"Lattitude";
    LocLatField.returnKeyType = UIReturnKeyNext;
    LocLatField.delegate = self;
    [self.view addSubview:LocLatField];
    
    
    UITextField* LocLonField = [[UITextField alloc] initWithFrame:
                                  CGRectMake(fieldSize.width - (fieldSize.width/4), (LocTitleField.frame.origin.y + 50), fieldSize.width/3, fieldSize.height)];
    LocLonField.tag = kADDLOCATIONVC_LON_FIELD_TAG;
    LocLonField.layer.cornerRadius = 6;
    [LocLonField.layer setBorderColor:kLIGHT_BLUE_COLOR.CGColor];
    [LocLonField.layer setBorderWidth:1.0];
    LocLonField.keyboardType = UIKeyboardTypeDecimalPad;
    LocLonField.backgroundColor = kMILD_BLUE_COLOR;
    LocLonField.placeholder = @"Longitude";
    LocLonField.returnKeyType = UIReturnKeyNext;
    LocLonField.delegate = self;
    [self.view addSubview:LocLonField];
    
    
    UITextField* LocSubTitleField = [[UITextField alloc] initWithFrame:
                                       CGRectMake(30, (LocLonField.frame.origin.y + 50), fieldSize.width, fieldSize.height)];
    LocSubTitleField.tag = kADDLOCATIONVC_SUBTITLE_FIELD_TAG;
    LocSubTitleField.layer.cornerRadius = 6;
    [LocSubTitleField.layer setBorderColor:kLIGHT_BLUE_COLOR.CGColor];
    [LocSubTitleField.layer setBorderWidth:1.0];
    LocSubTitleField.backgroundColor = kMILD_BLUE_COLOR;
    LocSubTitleField.placeholder = @"Place Category";
    LocSubTitleField.returnKeyType = UIReturnKeyDone;
    LocSubTitleField.delegate = self;
    [self.view addSubview:LocSubTitleField];
    
    
    
    UIButton *SubmitButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    SubmitButton.frame = CGRectMake(LocSubTitleField.frame.origin. x +  30, LocSubTitleField.frame.origin. y +  (LocSubTitleField.frame.size.height + 20), LocSubTitleField.frame.size.width - 60, 21);
    [SubmitButton setTitle:@"Submit" forState:UIControlStateNormal];
    [SubmitButton setTitleColor:[UIColor redColor] forState: UIControlStateHighlighted];
    [SubmitButton addTarget:self action:@selector(SubmitLocationActin:) forControlEvents:UIControlEventTouchUpInside];
    [SubmitButton setTitleColor:kDEEP_BLUE_COLOR forState: UIControlStateNormal];
    [self.view addSubview:SubmitButton];
}


- (void)SubmitLocationActin:(UIButton* )sender {
    
    if ([self.delegate respondsToSelector:@selector(AddAnnotation:)] &&
        CLLocationCoordinate2DIsValid(self.Annotation.coordinate)) {
        
        __weak AddLocationViewController* weakSelf = self;
        [self dismissViewControllerAnimated:YES completion:^ {
            [weakSelf.delegate AddAnnotation:weakSelf.Annotation];
        }];
    }
}

- (MKPointAnnotation* )Annotation {
    if(_Annotation == nil) {
        _Annotation = [[MKPointAnnotation alloc] init];
    }
    return _Annotation;
}


#pragma mark --
#pragma mark -- UITextFieldDelegate


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if(textField.tag == kADDLOCATIONVC_TITLE_FIELD_TAG) {
        self.Annotation.title = @"";
    }
    
    if (textField.tag == kADDLOCATIONVC_LAT_FIELD_TAG) {
        [self.Annotation setCoordinate:CLLocationCoordinate2DMake(kADDLOCATIONVC_INVALID_LATLON, self.Annotation.coordinate.longitude)];
    }
    
    if (textField.tag == kADDLOCATIONVC_LON_FIELD_TAG) {
        [self.Annotation setCoordinate:CLLocationCoordinate2DMake(self.Annotation.coordinate.latitude, kADDLOCATIONVC_INVALID_LATLON)];
    }
    
    if (textField.tag == kADDLOCATIONVC_SUBTITLE_FIELD_TAG) {
        self.Annotation.subtitle = @"";
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    if(textField.tag == kADDLOCATIONVC_TITLE_FIELD_TAG) {
        self.Annotation.title = textField.text;
    }
    
    if (textField.tag == kADDLOCATIONVC_LAT_FIELD_TAG) {
        [self.Annotation setCoordinate:CLLocationCoordinate2DMake(textField.text.doubleValue, self.Annotation.coordinate.longitude)];
    }
    
    if (textField.tag == kADDLOCATIONVC_LON_FIELD_TAG) {
        [self.Annotation setCoordinate:CLLocationCoordinate2DMake(self.Annotation.coordinate.latitude, textField.text.doubleValue)];
    }
    
    if (textField.tag == kADDLOCATIONVC_SUBTITLE_FIELD_TAG) {
        self.Annotation.subtitle = textField.text;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField.tag == kADDLOCATIONVC_TITLE_FIELD_TAG) {
        [textField resignFirstResponder];
        
        UITextField* LocLatField = (UITextField*) [self.view viewWithTag:kADDLOCATIONVC_LAT_FIELD_TAG];
        if (LocLatField != nil) {
            [LocLatField becomeFirstResponder];
        }
    }
    
    if (textField.tag == kADDLOCATIONVC_LAT_FIELD_TAG) {
        [textField resignFirstResponder];
        
        UITextField* LocLonField = (UITextField*) [self.view viewWithTag:kADDLOCATIONVC_LON_FIELD_TAG];
        if (LocLonField != nil) {
            [LocLonField becomeFirstResponder];
        }
    }
    
    if (textField.tag == kADDLOCATIONVC_LON_FIELD_TAG) {
        [textField resignFirstResponder];
        UITextField* LocSubTitleField = (UITextField*) [self.view viewWithTag:kADDLOCATIONVC_SUBTITLE_FIELD_TAG];
        if (LocSubTitleField != nil) {
            [LocSubTitleField becomeFirstResponder];
        }
    }
    
    if (textField.tag == kADDLOCATIONVC_SUBTITLE_FIELD_TAG) {
        [textField resignFirstResponder];
        
        [self SubmitLocationActin:nil];
    }
    return YES;
}

@end
