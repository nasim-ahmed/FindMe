//
//  AddLocationProtocol.h
//  FindMe
//
//  Created by Nasim on 1/16/17.
//  Copyright © 2017 Nasim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@protocol AddLocationProtocol <NSObject>
@required
- (void)AddAnnotation:(MKPointAnnotation* )annotation;
@end
