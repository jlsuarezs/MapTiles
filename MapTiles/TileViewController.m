//
//  TileViewController.m
//  MapTiles
//
//  Created by Juan Suárez on 11/05/16.
//  Copyright © 2016 Juan Suárez. All rights reserved.
//

#import "TileViewController.h"
#import <MapKit/MapKit.h>
#import "TileOverlay.h"
#import "TileOverlayView.h"

@interface TileViewController ()

@property (strong, nonatomic) IBOutlet MKMapView *map;

@end

@implementation TileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Initialize the TileOverlay with tiles in the application's bundle's resource directory.
    // Any valid tiled image directory structure in there will do.
    NSString *tileDirectory = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Tiles"];
    
    TileOverlay *overlay = [[TileOverlay alloc] initWithTileDirectory:tileDirectory];
    [self.map addOverlay:overlay];
    
    // zoom in by a factor of two from the rect that contains the bounds
    // because MapKit always backs up to get to an integral zoom level so
    // we need to go in one so that we don't end up backed out beyond the
    // range of the TileOverlay.
    MKMapRect visibleRect = [self.map mapRectThatFits:overlay.boundingMapRect];
    visibleRect.size.width /= 2;
    visibleRect.size.height /= 2;
    visibleRect.origin.x += visibleRect.size.width / 2;
    visibleRect.origin.y += visibleRect.size.height / 2;
    self.map.visibleMapRect = visibleRect;
    
    // Annotations - Examples
    MKPointAnnotation *pinA = [MKPointAnnotation new];
    pinA.coordinate = CLLocationCoordinate2DMake(-37.86957287911382, 175.3535234928131);
    pinA.title = @"A1";
    [self.map addAnnotation:pinA];
    
    MKPointAnnotation *pinB = [MKPointAnnotation new];
    pinB.coordinate = CLLocationCoordinate2DMake(-37.869500888732134,	175.35353422164917);
    pinB.title = @"A2";
    [self.map addAnnotation:pinB];
    
    MKPointAnnotation *pinC = [MKPointAnnotation new];
    pinC.coordinate = CLLocationCoordinate2DMake(-37.869568644387435,	175.3533786535263);
    pinC.title = @"A3";
    [self.map addAnnotation:pinC];
}

#pragma marker - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *identifier = @"MyAnnotationView";
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    MKAnnotationView *view = (id)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (view) {
        view.annotation = annotation;
    } else {
        view = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        view.canShowCallout = true;
        view.image = [UIImage imageNamed:@"interactive"];
        
        UIButton *disclosure = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [disclosure addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disclosureTapped:)]];
        view.rightCalloutAccessoryView = disclosure;
    }
    
    return view;
}

- (TileOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    TileOverlayView *view = [[TileOverlayView alloc] initWithOverlay:overlay];
    return view;
}

#pragma marker - Callout

- (IBAction) disclosureTapped:(id)sender
{
    NSLog(@"You tapped the callout button!");
}

@end
