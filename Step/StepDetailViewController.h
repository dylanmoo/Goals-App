//
//  StepDetailViewController.h
//  Step
//
//  Created by Dylan Moore on 11/10/13.
//  Copyright (c) 2013 Dylan Moore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Goal.h"
#import "Step.h"

@interface StepDetailViewController : UITableViewController <NSFetchedResultsControllerDelegate,UITextViewDelegate>

@property (strong, nonatomic) Goal *goal;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (void)insertNewObject:(id)sender;

@end
