//
//  AddLocationViewController.h
//  FindMe
//
//  Created by Nasim on 1/16/17.
//  Copyright © 2017 Nasim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddLocationProtocol.h"

@interface AddLocationViewController : UIViewController
@property (nonatomic, weak) id <AddLocationProtocol> delegate;
@end
