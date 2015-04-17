//
//  ViewController.m
//  CustomDrawing
//
//  Created by LiuScott on 15-3-26.
//  Copyright (c) 2015年 LiuScott. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property UIImage * anImage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self drawRect: CGRectMake(0, 0, 100, 100)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) drawRect: (CGRect) rect {
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"swipe.png" ofType:@"png"];
    UIImage *myImageObj = [[UIImage alloc] initWithContentsOfFile:imagePath];
    self.anImage = myImageObj;
    [self.anImage drawAtPoint:CGPointMake(10, 10)];
}


@end
