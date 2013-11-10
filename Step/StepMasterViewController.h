//
//  StepMasterViewController.h
//  Step
//
//  Created by Dylan Moore on 11/10/13.
//  Copyright (c) 2013 Dylan Moore. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface StepMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
