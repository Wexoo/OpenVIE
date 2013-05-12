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

-(id) initWithProperties:(NSString *)title
                   apiId:(NSString *)apiId
                district:(int)district
                  coordX:(float)coordX
                  coordY:(float)coordY
              thumbImage:(UIImage *)thumbImage
               fullImage:(UIImage *)fullImage
{
    if ((self = [super init])) {
        self.data = [[DataEntry alloc] initWithProperties:title apiId:apiId coordX:coordX coordY:coordY district:district];
        self.data.favorite = NO;
        self.thumbImage = thumbImage;
        self.fullImage = fullImage;
    }
    return self;
}

-(id) initWithProperties:(NSString *)title
                   apiId:(NSString *)apiId
                district:(int)district
                  coordX:(float)coordX
                  coordY:(float)coordY
{
    return [self initWithProperties:title apiId:apiId district:district coordX:coordX coordY:coordY thumbImage:nil fullImage:nil];
}


@end