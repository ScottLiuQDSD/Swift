//
//  AppDelegate.m
//  TestMathLilb
//
//  Created by LiuScott on 15-3-10.
//  Copyright (c) 2015年 LiuScott. All rights reserved.
//

#import "AppDelegate.h"
#import "MathLib.h"
@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    int op1 = 4;
    int op2 = 5;
    int result = addMe(op1, op2);
    NSLog(@"%d", result);
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
