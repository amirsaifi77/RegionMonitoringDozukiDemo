//
//  RMSecondViewController.m
//  RegionMonitoringDozukiDemo
//
//  Created by Amir on 5/7/14.
//  Copyright (c) 2014 Amir Saifi. All rights reserved.
//

#import "RMSecondViewController.h"

@interface RMSecondViewController ()


@property (assign, nonatomic) CLLocationCoordinate2D cuestaCoordinate;
@property (assign, nonatomic) MKCoordinateSpan initialVisibleSpan;



@property (assign, nonatomic) MKCoordinateRegion initialVisibleRegion;


@property CLLocationManager * locManager;
@property CLCircularRegion * geoRegion;

@end

@implementation RMSecondViewController
@synthesize cuestaCoordinate;
@synthesize initialVisibleRegion;
@synthesize initialVisibleSpan;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.mapView setDelegate:self];
    
    
    self.locManager = [[CLLocationManager alloc]init];
    [self.locManager setDelegate:self];
    
    
    self.mapView.showsUserLocation = YES;
    
    cuestaCoordinate.latitude = 35.329499;
    cuestaCoordinate.longitude = -120.739939;
    
    initialVisibleSpan.latitudeDelta = .0217;
    initialVisibleSpan.longitudeDelta = .0217;
    
    initialVisibleRegion.center = cuestaCoordinate;
    initialVisibleRegion.span = initialVisibleSpan;
    
    
    self.mapView.region = initialVisibleRegion;
    
    
    [self createCuestaCoordinateAnnotation];
    [self drawCircularOverlay];
    
}

- (void) createCuestaCoordinateAnnotation
{
    MKPointAnnotation * cuestaCoordinateAnnotation = [[MKPointAnnotation alloc]init];
    cuestaCoordinateAnnotation.coordinate = cuestaCoordinate;
    cuestaCoordinateAnnotation.title = @"Cuesta College";
    
    [self.mapView addAnnotation:cuestaCoordinateAnnotation];
    
}

- (void) drawCircularOverlay
{
    MKCircle *cuestaCircularOverlay = [[MKCircle alloc]init];
    cuestaCircularOverlay = [MKCircle circleWithCenterCoordinate:cuestaCoordinate radius:400];
    
    [self.mapView addOverlay:cuestaCircularOverlay];
    
    // Register Graphic Overlay has a Region
    [self registerRegionWithCircularOverlay:cuestaCircularOverlay andIdentifier:@"Cuesta"];
}

    // Draws Circular Overlay
- (MKOverlayRenderer*)mapView:(MKMapView*)mapView rendererForOverlay:(id <MKOverlay>)overlay
{
    
    MKCircleRenderer * circleRenderer = [[MKCircleRenderer alloc]initWithCircle:overlay];
    circleRenderer.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.2];
    circleRenderer.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
    circleRenderer.lineWidth = 3;
    
    return circleRenderer;
}

    // Register region as a monitored region
- (void)registerRegionWithCircularOverlay:(MKCircle*)overlay andIdentifier:(NSString*)identifier {
    
    // If the overlay's radius is too large, registration fails automatically,
    // so clamp the radius to the max value.
    CLLocationDegrees radius = overlay.radius;
    if (radius > self.locManager.maximumRegionMonitoringDistance) {
        radius = self.locManager.maximumRegionMonitoringDistance;
    }
    
    // Create the geographic region to be monitored.
    self.geoRegion = [[CLCircularRegion alloc]
                                   initWithCenter:overlay.coordinate
                                   radius:radius
                                   identifier:identifier];
    [self.locManager startMonitoringForRegion:self.geoRegion];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



    // Receive alert on Region Monitoring status based on User's GPS
- (IBAction)requestButton:(id)sender {
    
    [self.locManager requestStateForRegion:self.geoRegion];
    
}


    // Called by requestButton, and when Current Location enters/exits monitored region
- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    if (state == CLRegionStateUnknown)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Unknown"
                              message:@"It is unknown whether you are in the region or not."
                              delegate:self
                              cancelButtonTitle:@"Okay"
                              otherButtonTitles:nil];
        
        [alert show];
    }
    else if (state == CLRegionStateInside)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Inside Region"
                              message:@"You are currently inside the region."
                              delegate:self
                              cancelButtonTitle:@"Okay"
                              otherButtonTitles:nil];
        
        [alert show];
    }
    else if (state == CLRegionStateOutside)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Outside of Region"
                              message:@"You are currently not in the region."
                              delegate:self
                              cancelButtonTitle:@"Okay"
                              otherButtonTitles:nil];
        
        [alert show];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Error"
                              message:@"An unexpected error occurred."
                              delegate:self
                              cancelButtonTitle:@"Okay"
                              otherButtonTitles:nil];
        
        [alert show];

    }
}

@end
