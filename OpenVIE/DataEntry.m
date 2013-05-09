//
//  CityBikeData.m
//  OpenVIE
//
//  Created by Philipp Weixlbaumer on 5/9/13.
//  Copyright (c) 2013 Philipp Weixlbaumer. All rights reserved.
//

#import "DataEntry.h"

@implementation DataEntry

@synthesize title = _title;
@synthesize coordX = _coordX;
@synthesize coordY = _coordY;
@synthesize rating = _rating;

- (id) initWithProperties:(NSString *)title
                   coordX:(float)coordX
                   coordY:(float)coordY
                   rating:(float)rating
{
    if ((self = [super init])) {
        self.title = title;
        self.coordX = coordX;
        self.coordY = coordY;
        self.rating = rating;
    }
    return self;
}

@end
