//
//  Goal.m
//  Step
//
//  Created by Dylan Moore on 11/11/13.
//  Copyright (c) 2013 Dylan Moore. All rights reserved.
//

#import "Goal.h"
#import "Step.h"


@implementation Goal

@dynamic name;
@dynamic created_at;
@dynamic completed;
@dynamic steps;

- (void)addStepsObject:(Step *)value{
    NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.steps];
    [tempSet addObject:value];
    self.steps = tempSet;
}

@end
