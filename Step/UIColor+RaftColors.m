//
//  UIColor+RaftColors.m
//  Raft
//
//  Created by Daniel Graupensperger on 7/26/13.
//  Copyright (c) 2013 Raft. All rights reserved.
//

#import "UIColor+RaftColors.h"

@implementation UIColor (RaftColors)

+ (UIColor *)rollMeGreen {
    //Green
    //RGB: 32,207,128
    //return [UIColor colorWithRed:.831372549 green:.62745098 blue:.156862745 alpha:1];
    return [UIColor colorWithRed:.125490196 green:.811764706 blue:.501960784 alpha:1];
        //return [UIColor redColor];
}

+ (UIColor *)rollMePink{
    //Pink
    //RGB: 240,84,118
    return [UIColor colorWithRed:.941176471 green:.329411765 blue:.462745098 alpha:1];
}

+ (UIColor*)rollMeYellow{
    //Yellow
    //RGB: 255,202,79
    return [UIColor colorWithRed:1 green:.792156863 blue:.309803922 alpha:1];
}

+ (UIColor*)rollMeBlue{
    //Blue
    //RGB: 84,102,240
    return [UIColor colorWithRed:.329411765 green:.4 blue:.941176471 alpha:1];
}

+ (UIColor*)rollMeBlueWithPercentDistance:(float)percent{
    //Blue
    //RGB: 84,102,240
    if(percent>100){
        percent = 100;
    }else if(percent<0){
        percent = 0;
    }
    //float r = .329411765+ ((1-.329411765)*percent);
    //float g = .4 + ((1-.4)*percent);
    //float b = .941176471 + ((1-.941176471)*percent);
    return [UIColor colorWithRed:.329411765*percent green:.4*percent blue:.941176471*percent alpha:1];
    //return [UIColor colorWithRed:.125490196*percent green:.811764706*percent blue:.501960784*percent alpha:1];
    //return [UIColor colorWithRed:.941176471*percent green:.329411765*percent blue:.462745098 *percent alpha:1];
   // return [UIColor colorWithRed:r green:g blue:b alpha:1];
}


@end
