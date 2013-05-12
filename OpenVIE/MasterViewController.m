//
//  MasterViewController.m
//  OpenVIE
//
//  Created by Philipp Weixlbaumer on 5/8/13.
//  Copyright (c) 2013 Philipp Weixlbaumer. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1

#define kLatestKivaLoansURL [NSURL URLWithString:@"http://data.wien.gv.at/daten/wfs?service=WFS&request=GetFeature&version=1.1.0&typeName=ogdwien:CITYBIKEOGD&srsName=EPSG:4326&outputFormat=json"] //2

#import "MasterViewController.h"
#import "DetailViewController.h"

#import "DataEntry.h"
#import "DataEntryDetail.h"


@interface MasterViewController ()
@property (nonatomic, strong)  NSMutableArray *openVieData;
@end


@implementation MasterViewController

@synthesize openVieData = _openVieData;

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    self.title = @"OpenVIE - List";
    
    if (!self.openVieData) {
    dispatch_async(kBgQueue, ^{
        NSString *url = [NSString stringWithContentsOfURL:kLatestKivaLoansURL encoding:NSISOLatin1StringEncoding error:nil];
        NSData* data = [url dataUsingEncoding:NSUTF8StringEncoding];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
    }
}

- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          options:kNilOptions
                          error:&error];
    
    if(error) NSLog(@"%@", error);
    
    for(NSDictionary *feature in [json objectForKey:@"features"]){
        NSDictionary *geometryArray = [feature objectForKey:@"geometry"];
        NSArray *coordArray = [geometryArray objectForKey:@"coordinates"];
        NSDictionary *propArray = [feature objectForKey:@"properties"];
        
        DataEntryDetail *newDataEntry = [[DataEntryDetail alloc] initWithProperties:[propArray objectForKey:@"STATION"]
                                                                              apiId:[feature objectForKey:@"id"]
                                                                           district:(int)[propArray objectForKey:@"BEZIRK"]
                                                                             coordX:(int)[coordArray objectAtIndex:0]
                                                                             coordY:(int)[coordArray objectAtIndex:1]
                                         thumbImage:[UIImage imageNamed:@"thumb_green.jpg"]
                                         fullImage:[UIImage imageNamed:@"thumb_green.jpg"]];
        [self insertNewObject:self newDataEntry:newDataEntry];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
           newDataEntry:(DataEntryDetail *)newDataEntry
{
    if (!self.openVieData) {
        self.openVieData = [[NSMutableArray alloc] init];
    }
    [self.openVieData insertObject:newDataEntry atIndex:0];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.openVieData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:@"DataEntryCell"];
    DataEntryDetail *dataEntry = [self.openVieData objectAtIndex:indexPath.row];
    cell.textLabel.text = dataEntry.data.title;
    cell.imageView.image = dataEntry.thumbImage;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.openVieData removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        DataEntryDetail *dataEntry = self.openVieData[indexPath.row];
        self.detailViewController.detailItem = dataEntry;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *detailController = segue.destinationViewController;
    DataEntryDetail *dataEntry = [self.openVieData objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    [detailController setDetailItem:dataEntry];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSDate *object = self.openVieData[indexPath.row];
//        [[segue destinationViewController] setDetailItem:object];
//    }
//}

@end
