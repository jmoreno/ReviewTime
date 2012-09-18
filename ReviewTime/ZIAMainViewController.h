//
//  ZIAMainViewController.h
//  ReviewTime
//
//  Created by Javi on 19/09/12.
//  Copyright (c) 2012 Zink In Apps!. All rights reserved.
//

#import "ZIAFlipsideViewController.h"

@interface ZIAMainViewController : UIViewController <ZIAFlipsideViewControllerDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@end
