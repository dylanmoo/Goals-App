//
//  StepCell.h
//  Step
//
//  Created by Dylan Moore on 11/10/13.
//  Copyright (c) 2013 Dylan Moore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StepCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UITextView *textField;

@property (nonatomic, weak) IBOutlet UILabel *completedLabel;

@end
