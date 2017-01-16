//
//  User.m
//  FindMe
//
//  Created by Nasim on 1/16/17.
//  Copyright © 2017 Nasim. All rights reserved.
//

#import "User.h"

@interface User()
@property (nonatomic, copy, readwrite) NSString* UserName;
@property (nonatomic, copy, readwrite) NSString* UserEmail;
@property (nonatomic, copy, readwrite) NSString* UserPassword;
@property (nonatomic, copy, readwrite) NSString* UserAddress;
@end


NSString * const UserEmailKey = @"kUserEmailKey";
NSString * const UserPasswordKey = @"kUserPasswordKey";

@implementation User
- (instancetype)init {
    self = [super init];
    if (self != nil) {
        self.UserName = nil;
        self.UserEmail = nil;
        self.UserPassword = nil;
        self.UserAddress = nil;
    }
    
    return self;
}

- (void)SetName:(NSString* )Name {
    self.UserName = Name;
}

- (void)SetEmail:(NSString* )Email {
    self.UserEmail = Email;
}

- (void)SetPassword:(NSString* )Pass {
    self.UserPassword = Pass;
}

- (void)SetAddress:(NSString* )Address {
    self.UserAddress = Address;
}

+ (void)UserStore:(User* )User {
    if (User.UserName.length > 0 &&
        User.UserEmail > 0 &&
        User.UserPassword > 0 &&
        User.UserAddress.length > 0) {
        
        NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setValue:User.UserEmail forKey:UserEmailKey];
        [userDefault setValue:User.UserPassword forKey:UserPasswordKey];
    }
}

+ (BOOL)IsValid:(User* )User {
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    NSString* Email = [userDefault objectForKey:UserEmailKey];
    NSString* Password = [userDefault objectForKey:UserPasswordKey];
    
    NSLog(@"%@ %@", Email, Password);
    if (Email.length > 0 && [Email isEqualToString:User.UserEmail] &&
        Password.length > 0 && [Email isEqualToString:User.UserPassword]) {
        return YES;
    }
    return NO;
}

@end

