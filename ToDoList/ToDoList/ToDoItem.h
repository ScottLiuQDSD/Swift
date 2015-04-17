//
//  ToDoItem.h
//  ToDoList
//
//  Created by LiuScott on 15-3-19.
//  Copyright (c) 2015年 LiuScott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property NSString *itemName;
@property BOOL completed;
@property (readonly) NSDate *createionDate;

@end
