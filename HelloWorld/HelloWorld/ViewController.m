//
//  ViewController.m
//  HelloWorld
//
//  Created by LiuScott on 15-3-10.
//  Copyright (c) 2015年 LiuScott. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnHello;
@property (weak, nonatomic) IBOutlet UILabel *lblText;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)btnHello:(id)sender {
    _lblText.text = @"Hello world.";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
