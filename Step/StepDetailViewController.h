//
//  StepDetailViewController.h
//  Step
//
//  Created by Dylan Moore on 11/10/13.
//  Copyright (c) 2013 Dylan Moore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StepDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
