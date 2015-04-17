//
//  APLMoveMeView.m
//  MoveMeDemo
//
//  Created by LiuScott on 15-3-27.
//  Copyright (c) 2015年 LiuScott. All rights reserved.
//

#import "APLMoveMeView.h"
#import "APLPlacardView.h"

//import QuartzCore For Animations
#import <QuartzCore/QuartzCore.h>

@interface APLMoveMeView ()
@property (nonatomic, strong) IBOutlet APLPlacardView *placardView;
@property (nonatomic) NSUInteger nextDisplayStringIndex;

@end

@implementation APLMoveMeView

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // we only support single touches, so angObject retrieves just that touch from touches
    UITouch *touch = [touches anyObject];
    //only move the placard view if the touch was in the placard view.
    if ([touch view] != self.placardView) {
        // in case of a double tap outside the placard view, update the placard's display string.
        if ([touch tapCount] == 2) {
            [self setupNextDisplayString];
        }
        return;
    }
    //Animate the first touch
    CGPoint touchPoint = [touch locationInView:self];
    [self animateFirstTouchAtPoint:touchPoint];
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    //if the touch was in the placardView, move the placardView to its location.
    if ([touch view] == self.placardView) {
        CGPoint location = [touch locationInView:self];
        self.placardView.center = location;
        return;
    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    //if the touch was in the placardView, bounce it back to the center.
    if ([touch view] == self.placardView) {
        /*
         Disable user interaction so subsqquent touches don't interfere with animation until the placard has returned to the center. Interaction is reenabled in animationDidStop:finished:.
         */
        self.userInteractionEnabled = NO;
        [self animatePlacardViewToCenter];
        return;
    }
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    /*
     To impose as little impact on the device as possible, simply set the placard view's center and transformation to the original values.
     */
    self.placardView.center = self.center;
    self.placardView.transform = CGAffineTransformIdentity;
}

/*
 First of two possible implementations of animateFirstTouchAt Point: illustrating different behaviors.
 To choose the second, replace '1' with '0' below.
 */
#define GROW_FACTOR 1.2f
#define SHRINK_FACTOR 1.1f

#if 1

/**
    "Pulse" the placard view by scaling up then down, then move the placard to under the finger.
 
 */

-(void) animateFirstTouchAtPoint:(CGPoint) touchPoint {
    /*
     This illustrates using UIView's built-in animation. We want, though, to animate the same property (transform) twice -- first to sacle up, then to shrink. you can't animate the same property more then once using the built-in animation -- the last one wins. So we'll set a delegate action to be invoked after the first animation has finished. it well complete the sequence.
     
     The touch point is passed in an NSValue object as the context to beginAnimations:. To make sure the object survives until the delegate method, pass the reference as retained.
     */
#define GROW_ANIMATION_DURATION_SECONDS 0.15
    
    NSValue *touchPointValue = [NSValue valueWithCGPoint:touchPoint];
    
    [UIView beginAnimations:nil context:(__bridge_retained void *)touchPointValue];
    [UIView setAnimationDuration:GROW_ANIMATION_DURATION_SECONDS];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(growAnimationDidStop:finished:context:)];
    CGAffineTransform transform = CGAffineTransformMakeScale(GROW_FACTOR, GROW_FACTOR);
    self.placardView.transform = transform;
    [UIView commitAnimations];
}

- (void) growAnimationDidStop:(NSString *) annimationID finished:(NSNumber *) finished context:(void *) context {
#define MOVE_ANIMATION_DURAION_SECONDS 0.15
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:MOVE_ANIMATION_DURAION_SECONDS];
    self.placardView.transform = CGAffineTransformMakeScale(SHRINK_FACTOR, SHRINK_FACTOR);
    
    /*
     MOve the placardView to under the touch.
     we passed the location wrapped in an NSValue as the context. Get the point from the Value, and transfer ownweship to ARC to balance the bridge retain in touchesBegin:withEvent:.
     */
    NSValue *touchPointValue = (__bridge_transfer NSValue *)context;
    self.placardView.center = [touchPointValue CGPointValue];
    [UIView commitAnimations];
}
#else
/*
 Alternate behavior.
 The preceding implementation grows the placard in place then moves it to the new location and shrinks it at the same time.  An alternative is to move the placard for the total duration of the grow and shrink operations; this gives a smoother effect.
 
 */


/**
 Create two separate animations. The first animation is for the grow and partial shrink. The grow animation is performed in a block. The method uses a completion block that itself includes an animation block to perform the shrink. The second animation lasts for the total duration of the grow and shrink animations and contains a block responsible for performing the move.
 */
-(void) animateFirstTouchAtPoint:(CGPoint) touchPoint {

#define GROW_ANIMATION_DURATION_SECONDS 0.15
#define SHRINK_ANIMATION_DURATION_SECONDS 0.15
    
    [UIView animateWithDuration:GROW_ANIMATION_DURATION_SECONDS animations:^{
        CGAffineTransform transform = CGAffineTransformMakeScale(GROW_FACTOR, GROW_FACTOR);
        self.placardView.transform = transform;
    }
                     completion:^(BOOL finished){
                         
                         [UIView animateWithDuration:(NSTimeInterval)SHRINK_ANIMATION_DURATION_SECONDS animations:^{
                             self.placardView.transform = CGAffineTransformMakeScale(SHRINK_FACTOR, SHRINK_FACTOR);
                         }];
                         
                     }];
    
    [UIView animateWithDuration:(NSTimeInterval)GROW_ANIMATION_DURATION_SECONDS + SHRINK_ANIMATION_DURATION_SECONDS animations:^{
        self.placardView.center = touchPoint;
    }];

}

#endif

/**
 Bounce the placard back to center
 */
-(void) animatePlacardViewToCenter {
    APLPlacardView *placardView = self.placardView;
    CALayer *welcomeLayer = placardView.layer;
    
    //create a keyframe animation to follow a path back to the center.
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    bounceAnimation.removedOnCompletion = NO;
    CGFloat animationDuration = 1.5f;
    
    //create the path for bounces.
    UIBezierPath * bouncePath = [[UIBezierPath alloc] init];
    
    CGPoint centerPoint = self.center;
    CGFloat midX = centerPoint.x;
    CGFloat midY = centerPoint.y;
    CGFloat originalOffetX = placardView.center.x - midX;
    CGFloat originalOffetY = placardView.center.y - midY;
    CGFloat offsetDivider = 4.0f;
    
    BOOL stopBouncing = NO;
    
    // start the path at the placard's current location.
    [bouncePath moveToPoint:CGPointMake(placardView.center.x, placardView.center.y)];
    [bouncePath addLineToPoint:CGPointMake(midX, midY)];
    
    // add to the bounce path in decreasing excursions from the center.
    while (stopBouncing != YES) {
        CGPoint excursion = CGPointMake(midX + originalOffetX/offsetDivider, midY + originalOffetY/offsetDivider);
        [bouncePath addLineToPoint:excursion];
        [bouncePath addLineToPoint:centerPoint];
        offsetDivider += 4;
        animationDuration += 1/offsetDivider;
        if ((abs(originalOffetX/offsetDivider) < 6) && (abs(originalOffetY/offsetDivider) < 6)) {
            stopBouncing = YES;
        }
    }
    bounceAnimation.path = [bouncePath CGPath];
    bounceAnimation.duration = animationDuration;
    
    //create a basic animation to restore the size of the placard.
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    transformAnimation.removedOnCompletion = YES;
    transformAnimation.duration = animationDuration;
    transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    //create an animation group to combine the keyframe and basic animations
    CAAnimationGroup * theGroup = [CAAnimationGroup animation];
    
    // set self as the delegate to allow for a callback to reenable user interaction.
    theGroup.delegate = self;
    theGroup.duration = animationDuration;
    theGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    theGroup.animations = @[bounceAnimation, transformAnimation];
    
    // add the animation group to the layer
    [welcomeLayer addAnimation:theGroup forKey:@"animatePlacardViewToCenter"];
    
    // set the placard view's center and transformation to the original value in preparation for the end of the animation.
    placardView.center = centerPoint;
    placardView.transform = CGAffineTransformIdentity;
}

/**
 animation delegate method called when the animation's finished: restore the transform and reenable user interaction.
 */
- (void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.placardView.transform = CGAffineTransformIdentity;
    self.userInteractionEnabled = YES;
}

- (void) setupNextDisplayString {
    NSUInteger nextIndex = self.nextDisplayStringIndex;
    NSString *displayString = self.displayStrings[nextIndex];
    [self.placardView setDisplayString:displayString];
    
    nextIndex ++;
    if (nextIndex >= [self.displayStrings count]) {
        nextIndex = 0;
    }
    self.nextDisplayStringIndex = nextIndex;
    self.placardView.center = self.center;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
