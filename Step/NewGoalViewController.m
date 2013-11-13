//
//  NewGoalViewController.m
//  Step
//
//  Created by Dylan Moore on 11/12/13.
//  Copyright (c) 2013 Dylan Moore. All rights reserved.
//

#import "NewGoalViewController.h"
#import "MZFormSheetController.h"

@interface NewGoalViewController ()

@end

@implementation NewGoalViewController

@synthesize goalTextView;
@synthesize goalButton;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)cancelAddGoal:(id)sender {
    [self.navigationController.formSheetController dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController *formSheetController) {
        
    }];
}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        [self newGoalButtonPressed:nil];
        return NO;
    }else{
        return YES;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.goalTextView setDelegate:self];
    
    [self.goalTextView performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.1f];
    
    [self.goalTextView setTextColor:[UIColor blackColor]];
	// Do any additional setup after loading the view.
}

- (IBAction)newGoalButtonPressed:(id)sender {
    NSLog(@"New Goal Button Pressed");
    if(![goalTextView.text isEqualToString:@""]){
        [self.navigationController.formSheetController dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController *formSheetController) {
            [delegate newGoal:goalTextView.text];
        }];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No text" message:@"Need a goal" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
