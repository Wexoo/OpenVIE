//
//  DetailViewController.h
//  OpenVIE
//
//  Created by Philipp Weixlbaumer on 5/8/13.
//  Copyright (c) 2013 Philipp Weixlbaumer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateView.h"

@class DataEntryDetail;

@interface DetailViewController : UIViewController <UITextFieldDelegate, RateViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) DataEntryDetail *detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet RateView *rateView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) UIImagePickerController * picker;


- (IBAction)addPictureTapped:(id)sender;
- (IBAction)titleFieldTextChanged:(id)sender;

@end