//
//  TileMap
//
//  Created by Juan Suárez on 4/05/16.
//  Copyright © 2016 Juan Suárez. All rights reserved.
//


#import <MapKit/MapKit.h>


@interface TileOverlayView : MKOverlayRenderer {
    CGFloat tileAlpha;
}

@property (nonatomic, assign) CGFloat tileAlpha;

- (id)initWithOverlay:(id <MKOverlay>)overlay;

@end
