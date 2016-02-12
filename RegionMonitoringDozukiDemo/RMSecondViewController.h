//
//  RMSecondViewController.h
//  RegionMonitoringDozukiDemo
//
//  Created by Amir on 5/7/14.
//  Copyright (c) 2014 Amir Saifi. All rights reserved.
//

#import <UIKit/UIKit.h>
 #import <MapKit/MapKit.h>



@interface RMSecondViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>



@property (strong, nonatomic) IBOutlet MKMapView *mapView;



- (IBAction)requestButton:(id)sender;

@end
