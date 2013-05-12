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
@synthesize apiId = _apiId;
@synthesize coordX = _coordX;
@synthesize coordY = _coordY;
@synthesize district = _district;
@synthesize favorite = _favorite;


- (id) initWithProperties:(NSString *)title
                    apiId:(NSString *)apiId
                   coordX:(float)coordX
                   coordY:(float)coordY
                 district:(float)district
{
    if ((self = [super init])) {
        self.title = title;
        self.coordX = coordX;
        self.coordY = coordY;
        self.district = district;
    }
    return self;
}

@end
