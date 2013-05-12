//
//  DetailViewController.h
//  OpenVIE
//
//  Created by Philipp Weixlbaumer on 5/8/13.
//  Copyright (c) 2013 Philipp Weixlbaumer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataEntryDetail;

@interface DetailViewController : UIViewController <UINavigationControllerDelegate>

@property (strong, nonatomic) DataEntryDetail *detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *favoriteCheck;

- (IBAction)favoriteSwitched:(UISwitch *)sender;
@end