//
//  CityBikeData.m
//  OpenVIE
//
//  Created by Philipp Weixlbaumer on 5/9/13.
//  Copyright (c) 2013 Philipp Weixlbaumer. All rights reserved.
//

#import "DataEntry.h"
#import <AddressBook/AddressBook.h>

@implementation DataEntry

@synthesize title = _title;
@synthesize apiId = _apiId;
@synthesize coordX = _coordX;
@synthesize coordY = _coordY;
@synthesize district = _district;
@synthesize favorite = _favorite;


- (id) initWithProperties:(NSString *)title
                    apiId:(NSString *)apiId
                   coordX:(double)coordX
                   coordY:(double)coordY
                 district:(int)district
{
    if ((self = [super init])) {
        self.title = title;
        self.coordX = coordX;
        self.coordY = coordY;
        self.district = district;
    }
    return self;
}

- (NSString *)title {
    return _title;
}

- (void)setTitle:(NSString *) title {
    _title = title;
}

- (NSString *)subtitle {
    return _apiId;
}

- (CLLocationCoordinate2D)coordinate {
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = _coordX;
    coordinate.longitude = _coordY;
    return coordinate;
}

- (MKMapItem*)mapItem {
    NSDictionary *addressDict = @{(NSString*)kABPersonAddressStreetKey : _apiId};
    
    MKPlacemark *placemark = [[MKPlacemark alloc]
                              initWithCoordinate:self.coordinate
                              addressDictionary:addressDict];
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name = self.title;
    
    return mapItem;
}

@end
