//
//  CircleUIView.m
//  ASKME
//
//  Created by LUISMI on 21/12/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import "CircleUIView.h"
#include <math.h>
#import <QuartzCore/QuartzCore.h>

@implementation CircleUIView

@synthesize comenzar, finalizar, colorRellenoContador;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGFloat radius = 30;
    CGFloat starttime;
    CGFloat endtime;
    if (finalizar==0.0) {
        starttime = 0.0; //1 pm = 1/6 rad
        endtime = 0.0;  //6 pm = 1 rad
    }else{
        starttime = (comenzar*M_PI)/180; //1 pm = 1/6 rad
        endtime = (finalizar*M_PI)/180;  //6 pm = 1 rad
    }
    
    //draw arc
    CGPoint center = CGPointMake(radius,radius);
    UIBezierPath *arc = [UIBezierPath bezierPath]; //empty path
    [arc moveToPoint:center];
    CGPoint next;
    next.x = center.x + radius * cos(starttime);
    next.y = center.y + radius * sin(starttime);
    [arc addLineToPoint:next]; //go one end of arc
    [arc addArcWithCenter:center radius:radius startAngle:starttime endAngle:endtime clockwise:YES]; //add the arc
    [arc addLineToPoint:center]; //back to center
    
    [colorRellenoContador set];
    [arc fill];
}


@end
