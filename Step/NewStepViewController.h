//
//  NewStepViewController.h
//  Banana
//
//  Created by Dylan Moore on 10/16/13.
//  Copyright (c) 2013 Dylan Moore. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewStepDelegate <NSObject>

-(void)newStep:(NSString*)stepString forGoalIndex:(int)goalIndex andStepIndex:(int)stepIndex;

@end

@interface NewStepViewController : UIViewController <UIGestureRecognizerDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *stepButton;
@property (weak, nonatomic) IBOutlet UITextView *stepTextView;
@property (strong, nonatomic) NSObject<NewStepDelegate> *delegate;

-(void)setGoalIndex:(int)goalIndex andStepIndex:(int)stepIndex;

@end
