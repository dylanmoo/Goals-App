//
//  GoalsViewController.h
//  Step
//
//  Created by Dylan Moore on 11/12/13.
//  Copyright (c) 2013 Dylan Moore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoalCollectionViewCell.h"
#import "NewStepViewController.h"
#import "NewGoalViewController.h"
#import <CoreData/CoreData.h>


@interface GoalsViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate,NewStepDelegate,NewGoalDelegate, GoalCollectionViewCellDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *goalCollectionView;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
