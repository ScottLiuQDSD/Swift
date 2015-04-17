//
//  AddToDoItemViewController.h
//  ToDoList
//
//  Created by LiuScott on 15-3-19.
//  Copyright (c) 2015年 LiuScott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoItem.h"

@interface AddToDoItemViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property ToDoItem *toDoItem;

- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker;

@end
