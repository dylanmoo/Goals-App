//
//  PrintViewController.m
//  Banana
//
//  Created by Dylan Moore on 10/16/13.
//  Copyright (c) 2013 Dylan Moore. All rights reserved.
//

#import "NewStepViewController.h"
#import "MZFormSheetController.h"

@interface NewStepViewController ()

@end


@implementation NewStepViewController

@synthesize stepTextView;
@synthesize stepButton;
@synthesize delegate;

int goalIndex;
int stepIndex;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)cancelAddStep:(id)sender {
    [self.navigationController.formSheetController dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController *formSheetController) {
        
    }];
}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        [self newStepButtonPressed:nil];
        return NO;
    }else{
        return YES;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    [self.stepTextView setDelegate:self];
    
    [self.stepTextView performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.1f];
    
    [self.stepTextView setTextColor:[UIColor blackColor]];
	// Do any additional setup after loading the view.
}

-(void)setGoalIndex:(int)goalI andStepIndex:(int)stepI{
    goalIndex = goalI;
    stepIndex = stepI;
}


- (IBAction)newStepButtonPressed:(id)sender {
    NSLog(@"New Step Button Pressed");
    if(![stepTextView.text isEqualToString:@""]){
        [delegate newStep:stepTextView.text forGoalIndex:goalIndex andStepIndex:stepIndex];
        [self.navigationController.formSheetController dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController *formSheetController) {
        }];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No text" message:@"Need a step" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
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
