//
//  ZIAFlipsideViewController.h
//  ReviewTime
//
//  Created by Javi on 19/09/12.
//  Copyright (c) 2012 Zink In Apps!. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZIAFlipsideViewController;

@protocol ZIAFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(ZIAFlipsideViewController *)controller;
@end

@interface ZIAFlipsideViewController : UIViewController

@property (weak, nonatomic) id <ZIAFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
