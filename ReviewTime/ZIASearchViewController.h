//
//  ZIASearchViewController.h
//  MonitorRank
//
//  Created by Javi on 04/08/12.
//  Copyright (c) 2012 Zink In Apps!. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZIAApplication;

@protocol ZIASearchViewControllerDelegate
- (void)searchViewControllerDidFinishWithApplication:(ZIAApplication *)application;
@end



@interface ZIASearchViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate>

@property (weak, nonatomic) id <ZIASearchViewControllerDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *searchResults;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSString *countryForSearch;

- (IBAction)cancelSearch:(id)sender;

@end
