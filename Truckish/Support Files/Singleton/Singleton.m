//
//  Singleton.m
//  Truckish
//
//  Created by Abhijit Paul on 08/06/18.
//  Copyright © 2018 Abhijit Paul. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

+ (UIView *) radiusOfView:(UIView *)view withRadius:(CGFloat)radius andShadow:(BOOL)shadow {
    // border radius
    [view.layer setCornerRadius:radius];
//    [view.layer setMasksToBounds:YES];
    // drop shadow
    if (shadow) {
        [view.layer setShadowColor:[UIColor lightGrayColor].CGColor];
        [view.layer setShadowOpacity:0.8];
        [view.layer setShadowRadius:radius];
        [view.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    }
    return view;
}

@end
