//
//  RMFirstViewController.m
//  RegionMonitoringDozukiDemo
//
//  Created by Amir on 5/7/14.
//  Copyright (c) 2014 Amir Saifi. All rights reserved.
//

#import "RMFirstViewController.h"

@interface RMFirstViewController ()

@end

@implementation RMFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.mapView setDelegate:self];
    self.mapView.showsUserLocation = YES;
    
    // Zooms and pans following User's GPS Location
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
