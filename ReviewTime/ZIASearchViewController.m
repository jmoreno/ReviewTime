//
//  ZIASearchViewController.m
//  MonitorRank
//
//  Created by Javi on 04/08/12.
//  Copyright (c) 2012 Zink In Apps!. All rights reserved.
//

#import "ZIASearchViewController.h"
#import "ZIAApplication.h"
#import "AFNetworking/AFJSONRequestOperation.h"

@interface ZIASearchViewController ()

@property (strong, nonatomic) NSTimer *searchTimer;

@end

@implementation ZIASearchViewController

@synthesize searchResults = _searchResults;
@synthesize searchBar = _searchBar;
@synthesize searchTimer = _searchTimer;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLocale *locale = [NSLocale currentLocale];
    _countryForSearch = [locale objectForKey: NSLocaleCountryCode];
//    if (!_developerId) {
//        _searchBar.scopeButtonTitles = @[ @"iOS", @"Mac", NSLocalizedString(@"Developer", @"Developer") ];
//        _searchBar.placeholder = NSLocalizedString(@"Search for an iOS application", @"Search for an iOS application");
//    } else {
//        _searchBar.hidden = YES;
//        [self searchInAppStoreApplicationsFromDeveloper:_developerId];
//    }

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    ZIAApplication *anApplication = (ZIAApplication *)[_searchResults objectAtIndex:indexPath.row];
    cell.textLabel.text = anApplication.trackName;
    cell.detailTextLabel.text = anApplication.artistName;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    NSLog(@"me debería ir de aquí");
    ZIAApplication *theApplication = (ZIAApplication *)[_searchResults objectAtIndex:indexPath.row];
    [self.delegate searchViewControllerDidFinishWithApplication:theApplication];
}

#pragma mark - SearchBar Delegate

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self searchInAppStoreApplicationWithName:searchString];
//  Para no atropellar la busqueda y evitar que continuamente se estén haciendo peticiones de busqueda utilizamos un timer.
//    if (self.searchTimer) {
//        [self.searchTimer invalidate];
//        self.searchTimer = nil;
//    }
//    self.searchTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(searchTimerPopped:) userInfo:searchString repeats:FALSE];
    return NO;
}

-(void) searchTimerPopped:(NSTimer *)sTimer {
    // code to fire off the asynchronous web call to do the search
    [self searchInAppStoreApplicationWithName:sTimer.userInfo];
}

-(void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    switch (selectedScope) {
        case 0:
            _searchBar.placeholder = NSLocalizedString(@"Search for an iOS application", @"Search for an iOS application");
            break;
            
        case 1:
            _searchBar.placeholder = NSLocalizedString(@"Search for a Mac application", @"Search for a Mac application");
            break;
            
        default:
            break;
    }
    [self searchInAppStoreApplicationWithName:searchBar.text];
}

#pragma mark - Searching in App Store

- (void)searchInAppStoreApplicationWithName:(NSString *)appName
{
    
    NSString *entity = nil;
    switch (_searchBar.selectedScopeButtonIndex) {
        case 0:
            entity = @"software";
            break;
            
        case 1:
            entity = @"macSoftware";
            break;
            
        default:
            break;
    }
    
    NSString *urlPath = [NSString stringWithFormat:@"http://itunes.apple.com/search?term=%@&country=%@&entity=%@", appName, _countryForSearch, entity];
    urlPath = [urlPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *queryURL =  [NSURL URLWithString:urlPath];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:queryURL];
    
    NSLog(@"URL: %@", [queryURL description]);
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSInteger resultCount = [[JSON valueForKey:@"resultCount"] integerValue];
        if (resultCount > 0) {
            NSArray *results = [JSON valueForKey:@"results"];
            if (_searchResults == nil) {
                _searchResults = [[NSMutableArray alloc] initWithCapacity:0];
            } else {
                [_searchResults removeAllObjects];
            }
            for (NSDictionary *result in results) {
                [_searchResults addObject:[ZIAApplication applicationWithDictionaryRepresentation:result]];
                [self.searchDisplayController.searchResultsTableView reloadData];
            }
        } else {
            //            NSLog(@"response: %@", [JSON description]);
            [_searchResults removeAllObjects];
            [self.searchDisplayController.searchResultsTableView reloadData];
        }
    } failure:nil];
    
    [operation start];
}

- (IBAction)cancelSearch:(id)sender {
    NSLog(@"me debería ir de aquí");
    [self.delegate searchViewControllerDidFinishWithApplication:nil];
}
@end
