//
//  Person.m
//  AtlAtlMapKitDemo
//
//  Created by Michael Dautermann on 4/22/13.
//  Copyright (c) 2013 Michael Dautermann. All rights reserved.
//

#import "Person.h"

@interface Person ()
{
    UIImage * myImage;
}

@end

@implementation Person

// chances are pretty slim the person's coordinates are going to change
// from launch to launch of the app, but I want to be able to allow
// people to be able to easily change the address (whether in the file on disk or
// in code), so here we'll re-determine the coordinates each time
// the app is launched.
- (void) determineCoordinatesWithCLGeocoder: (CLGeocoder *) geocoder
{
    // this assumes all these fields are valid
    NSString * wholeAddress = [[NSString alloc] initWithFormat: @"%@, %@ %@ %@", self.streetAddress, self.city, self.state, self.zipCode];
    [geocoder geocodeAddressString: wholeAddress completionHandler:^(NSArray *placemarks, NSError *error) {
        if([placemarks count] > 0)
        {
            CLPlacemark * ourPlacemark = [placemarks objectAtIndex: 0];
            
            self.coordinate = ourPlacemark.location.coordinate;
            self.content.coordinate = ourPlacemark.location.coordinate;
            NSLog( @"found coordinates for %@", wholeAddress);
        } else {
            NSLog( @"error is %@", [error localizedDescription]);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"geocoder_finished" object:self userInfo: NULL];
    }];
}

- (NSString *) title
{
     NSString * fullName = [[NSString alloc] initWithFormat: @"%@ %@", self.firstName, self.lastName];
     return(fullName);
}

- (void) setImageFromFile: (NSString *) fileName andParentVC: (ViewController *) parentVC
{
    myImage = [UIImage imageNamed: fileName];
    self.content.values = [[NSDictionary alloc] initWithObjectsAndKeys:myImage, @"image", parentVC, @"parent", self, @"person", nil];
}

- (UIImage *) image
{
    return myImage;
}

#pragma mark archiving / unarchiving methods

// these methods are in here in case I decide to save the Person objects to a file on disk
- (id) initWithCoder: (NSCoder *) coder
{
	self = [super init];
    
	_firstName = [coder decodeObjectForKey: @"first_name"];
	_lastName = [coder decodeObjectForKey: @"last_name"];
    _streetAddress = [coder decodeObjectForKey: @"address"];
    _city = [coder decodeObjectForKey: @"city"];
    _state = [coder decodeObjectForKey: @"state"];
    _zipCode = [coder decodeObjectForKey: @"zipcode"];
    _phoneNumber = [coder decodeObjectForKey: @"phone"];
    _email = [coder decodeObjectForKey: @"email"];
	return self;
}

- (void) encodeWithCoder: (NSCoder *)coder
{
	[coder encodeObject: self.firstName forKey: @"first_name"];
	[coder encodeObject: self.lastName forKey: @"last_name"];
	[coder encodeObject: self.streetAddress forKey: @"address"];
	[coder encodeObject: self.city forKey: @"city"];
	[coder encodeObject: self.state forKey: @"state"];
	[coder encodeObject: self.zipCode forKey: @"zipcode"];
	[coder encodeObject: self.phoneNumber forKey: @"phone"];
	[coder encodeObject: self.email forKey: @"email"];
}

- (NSData *) dataOfType: (NSString *) aType error: (NSError **) outError
{
    return([NSKeyedArchiver archivedDataWithRootObject: self ]);
}

@end
