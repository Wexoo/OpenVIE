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
@property (strong) NSString *apiId;
@property (assign) float coordX;
@property (assign) float coordY;
@property (assign) int district;
@property (assign) BOOL favorite;


- (id) initWithProperties:(NSString *)title
                    apiId:(NSString *)apiId
                   coordX:(float) coordX
                   coordY:(float) coordY
                 district:(float)district;
@end
