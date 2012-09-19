//
//  ZIAMainViewController.h
//  ReviewTime
//
//  Created by Javi on 19/09/12.
//  Copyright (c) 2012 Zink In Apps!. All rights reserved.
//

#import "ZIASearchViewController.h"
#import <Twitter/Twitter.h>
#import <Social/SLComposeViewController.h>
#import "BButton.h"


@interface ZIAMainViewController : UITableViewController <ZIASearchViewControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) IBOutlet UITextField *appName;
@property (strong, nonatomic) IBOutlet UITextField *appStoreLink;
@property (strong, nonatomic) IBOutlet UISegmentedControl *softwareType;
@property (strong, nonatomic) IBOutlet UILabel *reviewTime;
@property (strong, nonatomic) IBOutlet UIStepper *reviewTimeStepper;
@property (strong, nonatomic) IBOutlet BButton *tweetButton;

- (IBAction)tweetReviewTime:(id)sender;

@end
