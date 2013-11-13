//
//  GoalCollectionViewCell.m
//  Step
//
//  Created by Dylan Moore on 11/12/13.
//  Copyright (c) 2013 Dylan Moore. All rights reserved.
//

#import "GoalCollectionViewCell.h"

@implementation GoalCollectionViewCell

@synthesize stepScrollView;
@synthesize goalTextField;
@synthesize menuButton;
@synthesize delegate;
@synthesize goalId;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)prepareForReuse{
    for(UIView *view in self.stepScrollView.subviews){
        [view removeFromSuperview];
    }
    [self.goalTextField setText:@""];
    [self.goalTextField setTag:-1];
}

-(IBAction)menuButtonPressed:(id)sender{
    [delegate menuButtonPressedForGoal:self.goalTextField.tag];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
