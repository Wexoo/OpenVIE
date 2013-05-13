//
//  DetailViewController.m
//  OpenVIE
//
//  Created by Philipp Weixlbaumer on 5/8/13.
//  Copyright (c) 2013 Philipp Weixlbaumer. All rights reserved.
//

#import "DetailViewController.h"
#import "DataEntry.h"
#import "DataEntryDetail.h"
#import "SVProgressHUD.h"

#define METERS_PER_MILE 1609.344

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)configureView
{
    if (self.detailItem) {
        self.detailDescriptionLabel.text = self.detailItem.data.title;
        self.titleLabel.text = self.detailItem.data.title;
        [self.favoriteCheck setOn:self.detailItem.data.favorite];
        //        self.rateView.rating = self.detailItem.data.district;
        //        self.imageView.image = self.detailItem.fullImage;
        
    }
}

- (void)viewWillAppear:(BOOL)animated {
    // 1
    CLLocationCoordinate2D zoomLocation;
    NSLog(@"lat: %f - long: %f", self.detailItem.data.coordX, self.detailItem.data.coordY);
    zoomLocation.latitude = self.detailItem.data.coordX;
    zoomLocation.longitude= self.detailItem.data.coordY;
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    // 3
    [_detailMapView setRegion:viewRegion animated:YES];
    
    [_detailMapView addAnnotation:self.detailItem.data];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"DataEntry";
    if ([annotation isKindOfClass:[DataEntry class]]) {
        
        MKAnnotationView *annotationView = (MKAnnotationView *) [_detailMapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            
            annotationView.image = [UIImage imageNamed:@"arrest.png"];
            annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        } else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    DataEntry *location = (DataEntry *)view.annotation;
    
    NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
    [location.mapItem openInMapsWithLaunchOptions:launchOptions];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (IBAction)favoriteSwitched:(UISwitch *)sender {
    self.detailItem.data.favorite = sender.isOn;
}

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}
@end
