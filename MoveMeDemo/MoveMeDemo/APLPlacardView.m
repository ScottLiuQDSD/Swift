//
//  APLPlacardView.m
//  MoveMeDemo
//
//  Created by LiuScott on 15-3-27.
//  Copyright (c) 2015年 LiuScott. All rights reserved.
//

#import "APLPlacardView.h"

@interface APLPlacardView()

@property (nonatomic, weak) IBOutlet UILabel *textLabel;

@end

@implementation APLPlacardView

-(void) setDisplayString:(NSString *)displayString {
    self.textLabel.text = displayString;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
