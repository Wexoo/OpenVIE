//
//  DataEntryDetail.m
//  OpenVIE
//
//  Created by Philipp Weixlbaumer on 5/9/13.
//  Copyright (c) 2013 Philipp Weixlbaumer. All rights reserved.
//

#import "DataEntryDetail.h"
#import "DataEntry.h"

@implementation DataEntryDetail

@synthesize data = _data;
@synthesize thumbImage = _thumbImage;
@synthesize fullImage = _fullImage;

-(id) initWithProperties:(NSString *)title rating:(float)rating coordX:(float)coordX coordY:(float)coordY thumbImage:(UIImage *)thumbImage fullImage:(UIImage *)fullImage
{
    if ((self = [super init])) {
        self.data = [[DataEntry alloc] initWithProperties:title coordX:coordX coordY:coordY rating:rating];
        self.thumbImage = thumbImage;
        self.fullImage = fullImage;
    }
    return self;
}

@end