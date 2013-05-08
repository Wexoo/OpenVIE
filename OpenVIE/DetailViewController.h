//
//  DetailViewController.h
//  OpenVIE
//
//  Created by Philipp Weixlbaumer on 5/8/13.
//  Copyright (c) 2013 Philipp Weixlbaumer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
