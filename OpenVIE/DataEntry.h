//
//  CityBikeData.h
//  OpenVIE
//
//  Created by Philipp Weixlbaumer on 5/9/13.
//  Copyright (c) 2013 Philipp Weixlbaumer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataEntry : NSObject

@property (strong) NSString *title;
@property (assign) float coordX;
@property (assign) float coordY;
@property (assign) float rating;

- (id) initWithProperties:(NSString *)title
                   coordX:(float) coordX
                   coordY:(float) coordY
                   rating:(float)rating;

@end
