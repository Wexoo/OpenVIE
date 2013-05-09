//
//  DataEntryDetail.h
//  OpenVIE
//
//  Created by Philipp Weixlbaumer on 5/9/13.
//  Copyright (c) 2013 Philipp Weixlbaumer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DataEntry;

@interface DataEntryDetail : NSObject

@property (strong) DataEntry *data;
@property (strong) UIImage *thumbImage;
@property (strong) UIImage *fullImage;

- (id)initWithProperties:(NSString*)title
             rating:(float)rating
             coordX:(float)coordX
             coordY:(float)coordY
         thumbImage:(UIImage *)thumbImage
          fullImage:(UIImage *)fullImage;

@end
