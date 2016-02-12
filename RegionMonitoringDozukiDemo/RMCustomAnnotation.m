//
//  RMCustomAnnotation.m
//  RegionMonitoringDozukiDemo
//
//  Created by Amir on 5/8/14.
//  Copyright (c) 2014 Amir Saifi. All rights reserved.
//

#import "RMCustomAnnotation.h"

@implementation RMCustomAnnotation
@synthesize coordinate;

- (id)initWithLocation:(CLLocationCoordinate2D)coord {
    
    self = [super init];
    if (self) {
        coordinate = coord;
    }
    
    return self;
}


@end
