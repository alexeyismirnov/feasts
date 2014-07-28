//
//  ViewController.h
//  feasts
//
//  Created by Alexey Smirnov on 7/28/14.
//  Copyright (c) 2014 Alexey Smirnov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeastViewController.h"

@interface ViewController : UIViewController <UIPageViewControllerDataSource>
@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (nonatomic) int feastIndex;

@end
