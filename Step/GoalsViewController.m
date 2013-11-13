//
//  GoalsViewController.m
//  Step
//
//  Created by Dylan Moore on 11/12/13.
//  Copyright (c) 2013 Dylan Moore. All rights reserved.
//

#import "GoalsViewController.h"
#import "GoalCollectionViewCell.h"
#import "Goal.h"
#import "Step.h"
#import "UIColor+RaftColors.h"
#import "MZFormSheetController.h"
#import "NewStepViewController.h"

@interface GoalsViewController ()

@end

@implementation GoalsViewController

@synthesize goalCollectionView;
@synthesize managedObjectContext;

NSArray *goals;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(IBAction)addStepButtonPressed:(UIButton*)sender{
    NSLog(@"add step inside goal: %d and after step: %d",(sender.tag % 10),(sender.tag/10));
    [self showNewStepFormSheet:sender forGoalIndex:(sender.tag % 10) andStepIndex:(sender.tag/10)];
}

- (IBAction)showNewStepFormSheet:(UIButton *)sender forGoalIndex:(int)goalIndex andStepIndex:(int)stepIndex
{
    
    [[MZFormSheetBackgroundWindow appearance] setBackgroundBlurEffect:YES];
    [[MZFormSheetBackgroundWindow appearance] setBlurRadius:5.0];
    //[[MZFormSheetBackgroundWindow appearance] setBackgroundColor:[UIColor clearColor]];
    
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"newStep"];
    
    
    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithViewController:vc];
    
    formSheet.transitionStyle = MZFormSheetTransitionStyleSlideFromBottom;
    formSheet.shadowRadius = 2.0;
    formSheet.shadowOpacity = 0.3;
    formSheet.shouldDismissOnBackgroundViewTap = YES;
    formSheet.shouldCenterVerticallyWhenKeyboardAppears = YES;
    //    formSheet.shouldMoveToTopWhenKeyboardAppears = NO;
    
    formSheet.willPresentCompletionHandler = ^(UIViewController *presentedFSViewController) {
        // Passing data
        UINavigationController *navController = (UINavigationController *)presentedFSViewController;
        NewStepViewController *ns = (NewStepViewController*) navController.topViewController;
        [ns setDelegate:self];
        [ns setGoalIndex:goalIndex andStepIndex:stepIndex];
        
    };
    
    formSheet.willDismissCompletionHandler = ^(UIViewController *presentedFSViewController){
        
    };
    
    
    [self presentFormSheetController:formSheet animated:YES completionHandler:^(MZFormSheetController *formSheetController) {
        
    }];
}

-(void)newStep:(NSString*)stepString forGoalIndex:(int)goalIndex andStepIndex:(int)stepIndex{
    Step *step = [NSEntityDescription insertNewObjectForEntityForName:@"Step" inManagedObjectContext:self.managedObjectContext];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    [step setCreated_at:[NSDate date]];
    [step setUpdated_at:[NSDate date]];
    [step setName:stepString];
    
    if(!goalIndex){
        goalIndex = 0;
    }
    
    Goal *goal = [goals objectAtIndex:goalIndex];
    
    if((stepIndex+1)>=goal.steps.count){
        [goal addStepsObject:step];
    }else{
        [goal insertObject:step inStepsAtIndex:stepIndex+1];
    }
    
    
    // Save the context.
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    [self.goalCollectionView reloadData];
}


- (IBAction)newGoalPressed:(id)sender {
    if(goals.count<=8){
        [self showNewGoalFormSheet:nil];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hold on there" message:@"Sorry but to achieve your goals you must be focused on only a few at a time. Reach your other goals before adding another." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
    }
}

- (IBAction)showNewGoalFormSheet:(UIButton *)sender
{
    
    [[MZFormSheetBackgroundWindow appearance] setBackgroundBlurEffect:YES];
    [[MZFormSheetBackgroundWindow appearance] setBlurRadius:5.0];
    //[[MZFormSheetBackgroundWindow appearance] setBackgroundColor:[UIColor clearColor]];
    
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"newGoal"];
    
    
    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithViewController:vc];
    
    formSheet.transitionStyle = MZFormSheetTransitionStyleSlideFromTop;
    formSheet.shadowRadius = 2.0;
    formSheet.shadowOpacity = 0.3;
    formSheet.shouldDismissOnBackgroundViewTap = YES;
    formSheet.shouldCenterVerticallyWhenKeyboardAppears = YES;
    //formSheet.shouldMoveToTopWhenKeyboardAppears = YES;
    
    formSheet.willPresentCompletionHandler = ^(UIViewController *presentedFSViewController) {
        // Passing data
        UINavigationController *navController = (UINavigationController *)presentedFSViewController;
        NewGoalViewController *ng = (NewGoalViewController*) navController.topViewController;
        [ng setDelegate:self];
        
    };
    
    formSheet.willDismissCompletionHandler = ^(UIViewController *presentedFSViewController){
        
    };
    
    
    [self presentFormSheetController:formSheet animated:YES completionHandler:^(MZFormSheetController *formSheetController) {
        
    }];
}

-(void)newGoal:(NSString *)goalString{
    Goal *goal = [NSEntityDescription insertNewObjectForEntityForName:@"Goal" inManagedObjectContext:self.managedObjectContext];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    [goal setCreated_at:[NSDate date]];
    [goal setName:goalString];
    
    // Save the context.
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    [self reloadGoalsFromCoreData];
    
    [self.goalCollectionView reloadData];
    
    [self showFirstStepFormSheet:nil forGoalIndex:(goals.count-1)];
}

- (IBAction)showFirstStepFormSheet:(UIButton *)sender forGoalIndex:(int)goalIndex
{
    
    [[MZFormSheetBackgroundWindow appearance] setBackgroundBlurEffect:YES];
    [[MZFormSheetBackgroundWindow appearance] setBlurRadius:5.0];
    //[[MZFormSheetBackgroundWindow appearance] setBackgroundColor:[UIColor clearColor]];
    
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"newStep"];
    
    
    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithViewController:vc];
    
    formSheet.transitionStyle = MZFormSheetTransitionStyleSlideFromBottom;
    formSheet.shadowRadius = 2.0;
    formSheet.shadowOpacity = 0.3;
    formSheet.shouldDismissOnBackgroundViewTap = NO;
    formSheet.shouldCenterVerticallyWhenKeyboardAppears = YES;
    //    formSheet.shouldMoveToTopWhenKeyboardAppears = NO;
    
    formSheet.willPresentCompletionHandler = ^(UIViewController *presentedFSViewController) {
        // Passing data
        UINavigationController *navController = (UINavigationController *)presentedFSViewController;
        NewStepViewController *ns = (NewStepViewController*) navController.topViewController;
        [ns.navigationItem setTitle:@"Start with a small step"];
        [ns setDelegate:self];
        [ns setGoalIndex:goalIndex andStepIndex:0];
        [ns.stepButton setTitle:@"Add First Step" forState:UIControlStateNormal];
        
    };
    
    formSheet.willDismissCompletionHandler = ^(UIViewController *presentedFSViewController){
        
    };
    
    
    [self presentFormSheetController:formSheet animated:YES completionHandler:^(MZFormSheetController *formSheetController) {
        
    }];
}



-(int)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(goals.count>0){
        return goals.count;
    }else{
        return 0;
    }
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GoalCollectionViewCell *goalCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoalCell" forIndexPath:indexPath];
    [goalCell setDelegate:self];
    
    Goal *goal = [goals objectAtIndex:indexPath.row];
    [goalCell.goalTextField setText:goal.name];
    [goalCell.goalTextField setTag:indexPath.row];
    
    //NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"completed" ascending:NO];
    //NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"updated_at" ascending:YES];
    //NSArray *sortDescriptors = @[sortDescriptor2,sortDescriptor];
    //NSArray *allSteps = [goal.steps sortedArrayUsingDescriptors:sortDescriptors];
    NSArray *allSteps = [[NSArray alloc] initWithArray:goal.steps.set.allObjects];
    //Step *firstStep = [allSteps objectAtIndex:0];
    float height = goalCell.stepScrollView.bounds.size.height;
    int lastCompleted = goal.currentIndex.intValue;
    if(!lastCompleted){
        lastCompleted=0;
    }
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, height/2, (320*allSteps.count)-20, 2)];
    [lineLabel setBackgroundColor:[UIColor blackColor]];
    [goalCell.stepScrollView addSubview:lineLabel];
    for(int i=0; i<allSteps.count; i++){
        Step *step = [allSteps objectAtIndex:i];
        UITextView *textField = [[UITextView alloc] initWithFrame:CGRectMake((i*320)+10, 0, 300, height)];
        UIButton *addStepButton = [[UIButton alloc] initWithFrame:CGRectMake((i*320)+280, 40, 30, 30)];
        [addStepButton setTag:((i*10)+indexPath.row)];
        [addStepButton setTitle:@"+" forState:UIControlStateNormal];
        [addStepButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:20]];
        [addStepButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [addStepButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
        [addStepButton addTarget:self action:@selector(addStepButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [textField setEditable:NO];
        [textField setBackgroundColor:[UIColor whiteColor]];
        [textField setScrollEnabled:NO];
        [textField setFont:[UIFont fontWithName:@"HelveticaNeue" size:18]];
        [textField setContentInset:UIEdgeInsetsMake(5, 5, 5, 5)];
        textField.layer.borderColor = [UIColor blackColor].CGColor;
        textField.layer.borderWidth = 1;
        if(step.completed.boolValue == true){
            [textField setTextColor:[UIColor rollMeGreen]];
        }else{
            [textField setTextColor:[UIColor blackColor]];
        }
        [textField setText:step.name];
        [goalCell.stepScrollView addSubview:textField];
        [goalCell.stepScrollView addSubview:addStepButton];
    }
    
    [goalCell.stepScrollView setDelegate:self];
    [goalCell.stepScrollView setTag:indexPath.row];
    [goalCell.stepScrollView setContentSize:CGSizeMake(320*allSteps.count, height)];
    [goalCell.stepScrollView setContentOffset:CGPointMake(320*lastCompleted, 0)];
    [goalCell.stepScrollView setPagingEnabled:YES];
    [goalCell.stepScrollView setShowsHorizontalScrollIndicator:NO];
    
    
    return goalCell;
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(![scrollView isEqual:self.goalCollectionView]){
    Goal *goal = [goals objectAtIndex:scrollView.tag];
    int currentIndex = (int)scrollView.contentOffset.x/320;
    NSLog(@"Ended scrolling at index: %d",currentIndex);
    [goal setCurrentIndex:[NSNumber numberWithInt:currentIndex]];
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    }
}

-(void)reloadGoalsFromCoreData{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Goal" inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:entityDescription];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"created_at" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [request setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    goals = [[NSArray alloc] initWithArray:array];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self reloadGoalsFromCoreData];
    
    [self.goalCollectionView reloadData];
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField.text){
        [textField resignFirstResponder];
        //Should be tag of textfield
        Goal *goal = [goals objectAtIndex:textField.tag];
        [goal setName:textField.text];
        // Save the context.
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        return YES;
    }else{
        return NO;
    }
}

-(void)menuButtonPressedForGoal:(int)goalId{
    NSLog(@"Menu button pressed for %d",goalId);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
