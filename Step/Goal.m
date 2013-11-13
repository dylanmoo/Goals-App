//
//  Goal.m
//  Step
//
//  Created by Dylan Moore on 11/12/13.
//  Copyright (c) 2013 Dylan Moore. All rights reserved.
//

#import "Goal.h"
#import "Step.h"


@implementation Goal

@dynamic completed;
@dynamic created_at;
@dynamic name;
@dynamic updated_at;
@dynamic currentIndex;
@dynamic steps;

- (void)addStepsObject:(Step *)value{
    NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.steps];
    [tempSet addObject:value];
    self.steps = tempSet;
}

- (void)insertObject:(Step *)value inStepsAtIndex:(NSUInteger)idx{
    NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.steps];
    [tempSet insertObject:value atIndex:idx];
    self.steps = tempSet;
}

@end
