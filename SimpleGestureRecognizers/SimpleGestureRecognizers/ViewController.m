//
//  ViewController.m
//  SimpleGestureRecognizers
//
//  Created by LiuScott on 15-3-23.
//  Copyright (c) 2015年 LiuScott. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) IBOutlet UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, strong) IBOutlet UISwipeGestureRecognizer * swipeLeftRecognizer;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.segmentedControl selectedSegmentIndex] == 0) {
        [self.view addGestureRecognizer:self.swipeLeftRecognizer];
    } else {
        [self.view removeGestureRecognizer:self.swipeLeftRecognizer];
    }
    
    // For illustrative purposes, set exclusive touch for the segmented control.
    [self.segmentedControl setExclusiveTouch:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}


- (IBAction)takeLeftSwipeRecognitionEnabledFrom:(UISegmentedControl *)aSegmentedControl {
    if ([aSegmentedControl selectedSegmentIndex] == 0) {
        [self.view addGestureRecognizer:self.swipeLeftRecognizer];
    } else {
        [self.view removeGestureRecognizer:self.swipeLeftRecognizer];
    }
}

- (BOOL) gestureRecognizer: (UIGestureRecognizer *) gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // disallow recognition of tap gestures in the segmented control.
    if ((touch.view == self.segmentedControl) && (gestureRecognizer == self.tapRecognizer)) {
        return NO;
    }
    return  YES;
}

#pragma mark -
#pragma mark Responding to gestures

/* In response to a tap gesture, show the image view appropriately then make it fade out in place. */
- (IBAction) showGestureForTapRecognizer:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:self.view];
    
    [self drawImageForGestureRecognizer:recognizer atPoint:location];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.imageView.alpha = 0.0;
    }];
}

/* In responce to a swipe gesture, show the image view appropriately then move the image view in the direction of the swipe as it fades out. */
- (IBAction) showGestureForSwipeRecognizer:(UISwipeGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:self.view];
    
    [self drawImageForGestureRecognizer:recognizer atPoint:location];
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        location.x -= 220.0;
    } else {
        location.x += 220.0;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.imageView.alpha = 0.0;
        self.imageView.center = location;
    }];
}

/* In responce to a rotation gesture, show the image view at the rotation given by the recognizer. At the end of the gesture, make the image fade out in place while rotating back to horizontal. */
- (IBAction) showGestureForRotationRecognizer:(UIRotationGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:self.view];
    
    CGAffineTransform transform = CGAffineTransformMakeRotation([recognizer rotation]);
    
    self.imageView.transform = transform;
    
    [self drawImageForGestureRecognizer:recognizer atPoint:location];
    /* If the resture has ended or is cancelled, begin the animation back to horizontal and fade out. */
    if (([recognizer state] == UIGestureRecognizerStateEnded) || ([recognizer state] == UIGestureRecognizerStateCancelled)) {
        [UIView animateWithDuration:0.5 animations:^{
            self.imageView.alpha = 0.0;
            self.imageView.transform = CGAffineTransformIdentity;
        }];
    } else {
        location.x += 220.0;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.imageView.alpha = 0.0;
    }];
}

/* Set the appropriate image for the image view for the given gesture recognizer, move the image view to the given point, then display the image view by setting its alpha to 1.0. */
- (void) drawImageForGestureRecognizer:(UIGestureRecognizer *)recognizer atPoint:(CGPoint) centerPointer {
    NSString *imageName;
    if ([recognizer isMemberOfClass:[UITapGestureRecognizer class]]) {
        imageName = @"tap.png";
    } else if ([recognizer isMemberOfClass:[UIRotationGestureRecognizer class]]) {
        imageName = @"rotation.png";
    } else if ([recognizer isMemberOfClass:[UISwipeGestureRecognizer class]]) {
        imageName = @"swipe.png";
    }
    self.imageView.image = [UIImage imageNamed:imageName];
    self.imageView.center = centerPointer;
    self.imageView.alpha = 1.0;
}







@end
