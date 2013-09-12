//
//  MapViewController.h
//  DwollaV2
//
//  Created by Nick Schulze on 2/22/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Place.h"
#import "CommandCenter.h"

@class MapViewController;
@protocol MapDelegate <NSObject>

@optional
@required
-(void)mapDetail:(Place*)place;
-(void)hideMap;

@end


@interface MapViewController : UIViewController <MKMapViewDelegate>
{
    MKMapView* map;
    CGRect screenBounds;
    id <MapDelegate> delegate;
    NSMutableArray* places;
    int tag;
    CommandCenter* command;
}

@property (retain) id<MapDelegate> delegate;

- (void)centerMap:(CLLocation*) user_location;

- (void)addToMap:(Place*)place;

- (void)goToDetail:(UIButton*)sender;

- (void)slideIn;

- (void)slideOut;

- (void)destroy;

- (void)addCommandCenter:(CommandCenter*)_command;

@end
