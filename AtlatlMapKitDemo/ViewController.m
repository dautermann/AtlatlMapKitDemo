//
//  ViewController.m
//  AtlAtlMapKitDemo
//
//  Created by Michael Dautermann on 4/22/13.
//  Copyright (c) 2013 Michael Dautermann. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>
#import "MyCalloutView.h"

@interface ViewController ()
{
    IBOutlet MKMapView * mapView;
    IBOutlet UIView * detailView;
    IBOutlet UIView * invisibleView;
    IBOutlet UITextView * detailsTextView;
    NSArray * personArray;
    CLGeocoder * geocoder;
    MKAnnotationView * annotationView;
    BOOL detailViewVisible;
}

- (IBAction) backToMapButtonTouched: (id) sender;
- (void) displayDetails: (id) sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray * personArrayBeingBuilt = [[NSMutableArray alloc] init];

	// Do any additional setup after loading the view, typically from a nib.
    
    Content *content = [Content new];
    content.iconURL = [[NSBundle mainBundle] URLForResource:@"blue-pin" withExtension:@"png"];
    content.calloutView = [MyCalloutView class];

    Person * newPerson = [[Person alloc] initWithContent: content];
    if(newPerson)
    {
        newPerson.firstName = @"Arnie";
        newPerson.lastName = @"Armchair";
        newPerson.streetAddress = @"15725 SW Greystone Ct";
        newPerson.city = @"Beaverton";
        newPerson.state = @"OR";
        newPerson.zipCode = @"97006";
        newPerson.phoneNumber = @"843-462-8528";
        newPerson.email = @"arnie@acmecompany.com";
        [newPerson setImageFromFile: @"1.png" andParentVC: self];
        [personArrayBeingBuilt addObject: newPerson];
    }

    content = [Content new];
    content.iconURL = [[NSBundle mainBundle] URLForResource:@"blue-pin" withExtension:@"png"];
    content.calloutView = [MyCalloutView class];
    newPerson = [[Person alloc] initWithContent: content];
    if(newPerson)
    {
        newPerson.firstName = @"Charlie";
        newPerson.lastName = @"Control";
        newPerson.streetAddress = @"15995 SW Walker Rd";
        newPerson.city = @"Beaverton";
        newPerson.state = @"OR";
        newPerson.zipCode = @"97006";
        newPerson.phoneNumber = @"714-823-0202";
        newPerson.email = @"charlie@gmail.com";
        [newPerson setImageFromFile: @"3.png" andParentVC: self];
        [personArrayBeingBuilt addObject: newPerson];
    }

    content = [Content new];
    content.iconURL = [[NSBundle mainBundle] URLForResource:@"blue-pin" withExtension:@"png"];
    content.calloutView = [MyCalloutView class];
    newPerson = [[Person alloc] initWithContent: content];
    if(newPerson)
    {
        newPerson.firstName = @"Reggie";
        newPerson.lastName = @"Roadwarrior";
        newPerson.streetAddress = @"14740 NW Cornell Rd";
        newPerson.city = @"Oak Hills";
        newPerson.state = @"OR";
        newPerson.zipCode = @"97229";
        newPerson.phoneNumber = @"909-888-1223";
        newPerson.email = @"reggie@yahoo.com";
        [newPerson setImageFromFile: @"4.png" andParentVC: self];
        [personArrayBeingBuilt addObject: newPerson];
    }
    
    content = [Content new];
    content.iconURL = [[NSBundle mainBundle] URLForResource:@"blue-pin" withExtension:@"png"];
    content.calloutView = [MyCalloutView class];
    newPerson = [[Person alloc] initWithContent: content];
    if(newPerson)
    {
        newPerson.firstName = @"Annie";
        newPerson.lastName = @"Administrator";
        newPerson.streetAddress = @"17210 SW Shaw St";
        newPerson.city = @"Aloha";
        newPerson.state = @"OR";
        newPerson.zipCode = @"97007";
        newPerson.phoneNumber = @"625-422-0012";
        newPerson.email = @"annie@aol.com";
        [newPerson setImageFromFile: @"2.png" andParentVC: self];
        [personArrayBeingBuilt addObject: newPerson];
    }
    
    content = [Content new];
    content.iconURL = [[NSBundle mainBundle] URLForResource:@"blue-pin" withExtension:@"png"];
    content.calloutView = [MyCalloutView class];
    newPerson = [[Person alloc] initWithContent: content];
    if(newPerson)
    {
        newPerson.firstName = @"Frank";
        newPerson.lastName = @"Forecast";
        newPerson.streetAddress = @"16415 NW Cornell Rd";
        newPerson.city = @"Beaverton";
        newPerson.state = @"OR";
        newPerson.zipCode = @"97006";
        newPerson.phoneNumber = @"619-556-2245";
        newPerson.email = @"frank@ymail.com";
        [newPerson setImageFromFile: @"6.png" andParentVC: self];
        [personArrayBeingBuilt addObject: newPerson];
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doNextGeolocation:) name:@"geocoder_finished" object:nil];

    personArray = [[NSArray alloc] initWithArray: personArrayBeingBuilt];

    geocoder = [[CLGeocoder alloc] init];
    if(geocoder)
    {
        for(Person * aPerson in personArray)
        {
            [aPerson determineCoordinatesWithCLGeocoder:geocoder];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CATransform3D) makeRotationAndPerspectiveTransform:(CGFloat) angle {
    CATransform3D transform = CATransform3DMakeRotation(angle, 1.0f, 0.0f, 0.0f);
    transform.m34 = 1.0 / -500;
    return transform;
}

- (void) flipDetailView
{
    BOOL detailsVisibleAndEnabled = detailView.hidden;
    
    
    [UIView animateWithDuration:.5 animations:^{
        
        invisibleView.userInteractionEnabled = detailsVisibleAndEnabled;
        detailView.userInteractionEnabled = detailsVisibleAndEnabled;
        detailView.hidden = !detailsVisibleAndEnabled;
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:invisibleView cache:FALSE];
        
    } completion:^(BOOL finished){
        
    }];
}

- (IBAction) backToMapButtonTouched: (id) sender
{
    [self flipDetailView];
}

- (void) displayDetails: (id) sender
{
    AtlAtlButton * button = (AtlAtlButton *) sender;
    
    Person * ourPerson = button.person;
    NSString * detailString;
    
    if(ourPerson)
    {
        // if any of these fields are nil, they'll appear as the string "(null)" in this string...
        detailString = [NSString stringWithFormat: @"%@ %@\n%@\n%@, %@ %@\n%@\n%@", ourPerson.firstName,
                                   ourPerson.lastName, ourPerson.streetAddress, ourPerson.city, ourPerson.state, ourPerson.zipCode,
                                   ourPerson.phoneNumber, ourPerson.email];
    } else {
        detailString = @"";
    }
    
    detailsTextView.text = detailString;

    [self flipDetailView];
}

- (void) doNextGeolocation: (NSNotification *) notification
{
    [mapView addAnnotation: notification.object];
    
    for(Person * aPerson in personArray)
    {
        if((aPerson.coordinate.latitude == 0) && (notification.object != aPerson))
        {
            [aPerson determineCoordinatesWithCLGeocoder: geocoder];
            return;
        }
    }

    // if we get to this point in code, that means we're done doing geolocating...
    //
    // let's zoom in to some region that encompasses all the map points
    //
    // http://stackoverflow.com/questions/4680649/zooming-mkmapview-to-fit-annotation-pins
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in mapView.annotations)
    {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    [mapView setVisibleMapRect:zoomRect animated:YES];
}

#pragma mark - MKMapViewDelegate

/**
 * Delegates the SELECTION to the view implementation.
 */
- (void)mapView:(MKMapView *)aMapView didSelectAnnotationView:(MKAnnotationView *)view
{
    // delegate the implementation to the annotation view
    if ([view conformsToProtocol:@protocol(AnnotationViewProtocol)]) {
        //debug(@"%@ conforms", NSStringFromClass([view class]));
        [((NSObject<AnnotationViewProtocol>*)view) didSelectAnnotationViewInMap:mapView];
    } else {
        //debug(@"%@ DOES NOT conform", NSStringFromClass([view class]));
    }
}


/**
 * Delegates the DESELECTION to the view implementation.
 */
- (void)mapView:(MKMapView *)aMapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    //debug(@"%@", [view class]);
    // delegate the implementation to the annotation view
    if ([view conformsToProtocol:@protocol(AnnotationViewProtocol)]) {
        [((NSObject<AnnotationViewProtocol>*)view) didDeselectAnnotationViewInMap:mapView];
    }
}


/**
 * Delegates CREATION of the view to the annotation.
 *
 * If the annotation doesn't conform to AnnotationProtocol,
 * a standard MKPinAnnotationView is returned.
 */
- (MKAnnotationView *)mapView:(MKMapView *)aMapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    // if this is a custom annotation
    if ([annotation conformsToProtocol:@protocol(AnnotationProtocol)]) {
        
        // delegate the implementation to it
        return [((NSObject<AnnotationProtocol>*)annotation) annotationViewInMap:mapView];
        
    } else {
        
        // else, return a standard annotation view
        static NSString *viewId = @"MKPinAnnotationView";
        MKAnnotationView *view = (MKPinAnnotationView*) [mapView dequeueReusableAnnotationViewWithIdentifier:viewId];
        if (view == nil) {
            view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:viewId];
        }
        return view;
    }
}


@end
