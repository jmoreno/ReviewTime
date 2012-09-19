//
//  ZIAMainViewController.m
//  ReviewTime
//
//  Created by Javi on 19/09/12.
//  Copyright (c) 2012 Zink In Apps!. All rights reserved.
//

#import "ZIAMainViewController.h"
#import "ZIAApplication.h"
#import "BButton.h"

@interface ZIAMainViewController ()

@end

@implementation ZIAMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [_reviewTimeStepper addTarget:self action:@selector(reviewTimeStepperHasChangedValue) forControlEvents:UIControlEventValueChanged
     ];
    if (_reviewTimeStepper.value == 1) {
        _reviewTime.text = [NSString stringWithFormat:@"%.0f day", _reviewTimeStepper.value];
    } else {
        _reviewTime.text = [NSString stringWithFormat:@"%.0f days", _reviewTimeStepper.value];
    }
    _tweetButton.color = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showSearchApp"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        ZIASearchViewController *searchViewController = [[navigationController viewControllers] objectAtIndex:0];
        searchViewController.delegate = self;        
    }
}

- (void)reviewTimeStepperHasChangedValue
{
    if (_reviewTimeStepper.value == 1) {
        _reviewTime.text = [NSString stringWithFormat:@"%.0f day", _reviewTimeStepper.value];
    } else {
        _reviewTime.text = [NSString stringWithFormat:@"%.0f days", _reviewTimeStepper.value];
    }
}

-(void)searchViewControllerDidFinishWithApplication:(ZIAApplication *)application
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (application) {
        _appName.text = application.trackName;
        _appStoreLink.text = application.trackViewURL;
        if ([application.kind isEqualToString:@"software"]) {
            _softwareType.selectedSegmentIndex = 0;
        } else {
            _softwareType.selectedSegmentIndex = 1;
        }
        [self.tableView reloadData];
    }
}

- (IBAction)tweetReviewTime:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *myTweet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        NSString *hashtag = nil;
        switch (_softwareType.selectedSegmentIndex) {
            case 0:
                hashtag = @"#iosreviewtime";
                break;
                
            case 1:
                hashtag = @"#macreviewtime";
                break;
                
            default:
                break;
        }
        
        NSString *nameFulfilled = @"";
        if ([_appName.text length] > 0) {
            nameFulfilled = [NSString stringWithFormat:@"for %@ ", _appName.text];
        }
        NSString *tweet = [NSString stringWithFormat:@"Last review %@took %@ %@", nameFulfilled, _reviewTime.text, hashtag];
        [myTweet setInitialText:tweet];
        if ([_appStoreLink.text length] > 0) {
            [myTweet addURL:[NSURL URLWithString:_appStoreLink.text]];
        }
        
        // Create the completion handler block.
        [myTweet setCompletionHandler:^(SLComposeViewControllerResult result) {
            // Dismiss the tweet composition view controller.
            if (result == SLComposeViewControllerResultDone) {
                [self saveReviewTimeTweet:tweet];
                
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [self presentViewController:myTweet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    
}

- (void)saveReviewTimeTweet:(NSString *)tweet
{
    
}

@end
