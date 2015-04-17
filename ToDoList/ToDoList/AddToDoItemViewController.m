//
//  AddToDoItemViewController.m
//  ToDoList
//
//  Created by LiuScott on 15-3-19.
//  Copyright (c) 2015年 LiuScott. All rights reserved.
//

#import "AddToDoItemViewController.h"

@interface AddToDoItemViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property UIImagePickerController *_imagePicker;
@property (nonatomic, strong) IBOutlet UITapGestureRecognizer * tapRecognizer;

@end

@implementation AddToDoItemViewController
@synthesize _imagePicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action: @selector(respondToTapGesture:)];
    tapRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapRecognizer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (sender != self.saveButton) {
        return;
    }
    if (self.textField.text.length > 0) {
        self.toDoItem = [[ToDoItem alloc] init];
        self.toDoItem.itemName = self.textField.text;
        self.toDoItem.completed = NO;
    }
}

-(IBAction)takeCameraIamge:(UIButton *)cameraBtn {
    BOOL cameraSupport = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if (!cameraSupport) {
        NSLog(@"Not Support camera......");
    } else {
        [self takePhoto];
    }
}
-(void) takePhoto {
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
    }
    _imagePicker.delegate = self;
    _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    _imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    _imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    _imagePicker.allowsEditing = YES;
    
    NSArray* availableMediaType = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    for (NSString *string in availableMediaType) {
        NSLog(@"%@", string);
    }
    
    [self presentModalViewController:_imagePicker animated: YES];
}
- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
    [[picker parentViewController] dismissViewControllerAnimated:YES completion:nil];
    dispatch_queue_t sessionQueue = dispatch_queue_create("session queue", DISPATCH_QUEUE_SERIAL);
    
}
- (IBAction) showGestureForTapRecognizer:(UITapGestureRecognizer *) recognizer {
    CGPoint location = [recognizer locationInView:self.view];
    
    [self drawImageForGestureRecognizer atPoint:location];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.imageView.alpha = 0.0;
    }];
    NSLog(@"tap recognizer");
}
@end
