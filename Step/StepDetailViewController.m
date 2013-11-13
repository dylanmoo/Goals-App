//
//  StepDetailViewController.m
//  Step
//
//  Created by Dylan Moore on 11/10/13.
//  Copyright (c) 2013 Dylan Moore. All rights reserved.
//

#import "StepDetailViewController.h"
#import "Step.h"
#import "StepCell.h"
#import "UIColor+RaftColors.h"

@interface StepDetailViewController ()
- (void)configureView;
@end

@implementation StepDetailViewController

#pragma mark - Managing the detail item

- (void)setGoal:(Goal*)newGoal
{
    if (_goal != newGoal) {
        _goal = newGoal;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.goal) {
        [self.navigationItem setTitle:self.goal.name];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    [self.navigationItem.rightBarButtonItem setAction:@selector(insertNewObject:)];
    
    if(self.goal.steps.count==0){
        //Automatically add a first step
        [self firstStepPressed:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)firstStepPressed:(id)sender{
    [self.navigationItem.backBarButtonItem setEnabled:NO];
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    Step *newStep = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    [newStep setValue:[NSDate date] forKey:@"created_at"];
    [newStep setValue:[NSDate date] forKey:@"updated_at"];
    [newStep setGoal:self.goal];
    [self.goal addStepsObject:newStep];
    
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

}

- (void)insertNewObject:(id)sender
{
    [self.navigationItem.backBarButtonItem setEnabled:NO];
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    Step *newStep = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    [newStep setValue:[NSDate date] forKey:@"created_at"];
    [newStep setValue:[NSDate date] forKey:@"updated_at"];
    [newStep setGoal:self.goal];
    [self.goal addStepsObject:newStep];
    
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StepCell *cell = (StepCell*)[tableView dequeueReusableCellWithIdentifier:@"StepCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    StepCell *cell = (StepCell*)[tableView cellForRowAtIndexPath:indexPath];
    [self completeCell:cell atIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }else if(editingStyle == UITableViewCellEditingStyleNone){
        NSLog(@"Editing style none");
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath{
    NSLog(@"Move Row at index to index");
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 94;
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
     NSEntityDescription *entity = [NSEntityDescription entityForName:@"Step" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"goal = %@",self.goal]];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
     NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"completed" ascending:YES];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"updated_at" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor2,sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"completed" cacheName:self.goal.name];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:(StepCell*)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [anObject setUpdated_at:[NSDate date]];
            NSError *error = nil;
            if (![self.managedObjectContext save:&error]) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
 {
 // In the simplest, most efficient, case, reload the table view.
 [self.tableView reloadData];
 }
 */

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text isEqualToString:@"\n"]){
        [self textViewDidEndEditing:textView];
        return NO;
    }else{
        return YES;
    }
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if(textView.text){
        return YES;
    }else{
            return NO;
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"Return text view");
    
        [self.navigationItem.backBarButtonItem setEnabled:YES];
        [textView resignFirstResponder];
        //Section 0 only because only incomplete steps can be edited
        Step *step = [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:(textView.tag-1) inSection:0]];
        [step setName:textView.text];
        // Save the context.
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        [textView setEditable:NO];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"Return text field");
    if(textField.text){
        [self.navigationItem.backBarButtonItem setEnabled:YES];
        [textField resignFirstResponder];
        //Section 0 only because only incomplete steps can be edited
        Step *step = [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:(textField.tag-1) inSection:0]];
        [step setName:textField.text];
        // Save the context.
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        [textField setEnabled:NO];
        return YES;
    }else{
        return NO;
    }
}

- (void)configureCell:(StepCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Step *step = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell.textField setTag:(indexPath.row+1)];
    if(step.name){
        [cell.textField setText:step.name];
        if(step.completed.boolValue){
            [cell.completedLabel setBackgroundColor:[UIColor rollMeGreen]];
            [cell.textField setEditable:NO];
        }else{
            [cell.completedLabel setBackgroundColor:[UIColor lightGrayColor]];
            [cell.textField setEditable:YES];
        }

    }else{
        [cell.textField setEditable:YES];
        [cell.textField becomeFirstResponder];
    }
}

- (void)completeCell:(StepCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Step *step = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //Toggle completed
    if(step.completed.boolValue){
        [step setCompleted:[NSNumber numberWithBool:NO]];
        [cell.completedLabel setBackgroundColor:[UIColor lightGrayColor]];
        [cell.textField setEditable:YES];
    }else{
        [step setCompleted:[NSNumber numberWithBool:YES]];
        [cell.completedLabel setBackgroundColor:[UIColor rollMeGreen]];
        [cell.textField setEditable:NO];
    }
    
    [step setUpdated_at:[NSDate date]];
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

@end
