//
//  User.h
//  FindMe
//
//  Created by Nasim on 1/16/17.
//  Copyright © 2017 Nasim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic, readonly) NSString* UserName;
@property (nonatomic, readonly) NSString* UserEmail;
@property (nonatomic, readonly) NSString* UserPassword;
@property (nonatomic, readonly) NSString* UserAddress;

- (void)SetName:(NSString* )Name;
- (void)SetEmail:(NSString* )Email;
- (void)SetPassword:(NSString* )Pass;
- (void)SetAddress:(NSString* )Address;

+ (void)UserStore:(User* )User;
+ (BOOL)IsValid:(User* )User;
@end
