//
//  Person.h
//  AtlAtlMapKitDemo
//
//  Created by Michael Dautermann on 4/22/13.
//  Copyright (c) 2013 Michael Dautermann. All rights reserved.
//

#import <CoreLocation/CLGeocoder.h>
#import "Annotation.h"

@class ViewController;

@interface Person : Annotation <NSCoding>

- (void) determineCoordinatesWithCLGeocoder: (CLGeocoder *) geocoder;
- (UIImage *) image;
- (void) setImageFromFile: (NSString *) fileName andParentVC: (ViewController *) parentVC;

@property (strong) NSString * firstName;
@property (strong) NSString * lastName;
@property (strong) NSString * streetAddress;
@property (strong) NSString * city;
@property (strong) NSString * state;
@property (strong) NSString * zipCode;
@property (strong) NSString * phoneNumber;
@property (strong) NSString * email;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end
