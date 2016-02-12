//
//  RMCustomAnnotation.h
//  RegionMonitoringDozukiDemo
//
//  Created by Amir on 5/8/14.
//  Copyright (c) 2014 Amir Saifi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface RMCustomAnnotation : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
}

- (id)initWithLocation:(CLLocationCoordinate2D)coord;

@end
