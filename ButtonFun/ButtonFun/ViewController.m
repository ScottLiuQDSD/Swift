//
//  ViewController.m
//  ButtonFun
//
//  Created by LiuScott on 15-3-10.
//  Copyright (c) 2015年 LiuScott. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *statusText;
@property (weak, nonatomic) IBOutlet UIButton *btnPressed;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@synthesize statusText;
- (IBAction)btnPressed:(id)sender {
    NSString *title = [sender titleForState:UIControlStateNormal];
    NSString *newText = [[NSString alloc] initWithFormat:@"%@ button pressed.", title];
    statusText.text = newText;
}
- (IBAction)btnTouchUpInside:(id)sender {
    NSString *title = [sender titleForState:UIControlStateNormal];
    NSString *newText = [[NSString alloc] initWithFormat:@"%@ button touch up inside.", title];
    statusText.text = newText;
}

@end
