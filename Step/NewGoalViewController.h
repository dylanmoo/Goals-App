//
//  NewGoalViewController.h
//  Step
//
//  Created by Dylan Moore on 11/12/13.
//  Copyright (c) 2013 Dylan Moore. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewGoalDelegate <NSObject>

-(void)newGoal:(NSString*)goalString;

@end

@interface NewGoalViewController : UIViewController <UIGestureRecognizerDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *goalButton;
@property (weak, nonatomic) IBOutlet UITextView *goalTextView;
@property (strong, nonatomic) NSObject<NewGoalDelegate> *delegate;

@end
