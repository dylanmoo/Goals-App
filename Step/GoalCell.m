//
//  GoalCell.m
//  Step
//
//  Created by Dylan Moore on 11/10/13.
//  Copyright (c) 2013 Dylan Moore. All rights reserved.
//

#import "GoalCell.h"

@implementation GoalCell
@synthesize textField;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)prepareForReuse{
    textField.tag = 0;
    textField.text = @"";
    textField.layer.cornerRadius = 0;
    textField.layer.borderColor = self.tintColor.CGColor;
    textField.layer.borderWidth = 2;
}

@end
