//
//  CityBikeData.h
//  OpenVIE
//
//  Created by Philipp Weixlbaumer on 5/9/13.
//  Copyright (c) 2013 Philipp Weixlbaumer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface DataEntry : NSObject <MKAnnotation>

@property (strong) NSString *title;
@property (strong) NSString *apiId;
@property (assign) double coordX;
@property (assign) double coordY;
@property (assign) int district;
@property (assign) BOOL favorite;


- (id) initWithProperties:(NSString *)title
                    apiId:(NSString *)apiId
                   coordX:(double) coordX
                   coordY:(double) coordY
                 district:(int)district;

- (MKMapItem*)mapItem;

@end
