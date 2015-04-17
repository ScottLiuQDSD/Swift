//
//  ViewController.m
//  MoveMeDemo
//
//  Created by LiuScott on 15-3-27.
//  Copyright (c) 2015年 LiuScott. All rights reserved.
//

#import "ViewController.h"
#import "APLMoveMeView.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet APLMoveMeView *moveMeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // load the display strings
    NSURL * stringsFileURL = [[NSBundle mainBundle] URLForResource:@"DisplayStrings" withExtension:@"txt"];
    NSError *error;
    NSString *string = [NSString stringWithContentsOfURL:stringsFileURL encoding:NSUTF16BigEndianStringEncoding error: &error ];
    if (nil == string) {
        NSLog(@"Did you not load string file : %@", [error localizedDescription]);
    } else {
        NSArray *displayStrings = [string componentsSeparatedByString:@"\n"];
        self.moveMeView.displayStrings = displayStrings;
        [self.moveMeView setupNextDisplayString];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
