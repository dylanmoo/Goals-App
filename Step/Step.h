//
//  Step.h
//  Step
//
//  Created by Dylan Moore on 11/11/13.
//  Copyright (c) 2013 Dylan Moore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Goal;

@interface Step : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * created_at;
@property (nonatomic, retain) NSDate * updated_at;
@property (nonatomic, retain) NSNumber * completed;
@property (nonatomic, retain) Goal *goal;

@end
