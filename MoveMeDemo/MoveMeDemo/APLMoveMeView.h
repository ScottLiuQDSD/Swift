//
//  APLMoveMeView.h
//  MoveMeDemo
//
//  Created by LiuScott on 15-3-27.
//  Copyright (c) 2015年 LiuScott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APLMoveMeView : UIView

@property (nonatomic, strong) NSArray *displayStrings;

- (void) setupNextDisplayString;

@end
