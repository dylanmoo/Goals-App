//
//  GoalCollectionViewCell.h
//  Step
//
//  Created by Dylan Moore on 11/12/13.
//  Copyright (c) 2013 Dylan Moore. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoalCollectionViewCellDelegate <NSObject>

-(void)menuButtonPressedForGoal:(int)goalId;

@end

@interface GoalCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UITextField *goalTextField;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIScrollView *stepScrollView;
@property (strong, nonatomic) NSNumber *goalId;
@property (strong, nonatomic) NSObject<GoalCollectionViewCellDelegate> *delegate;

@end
