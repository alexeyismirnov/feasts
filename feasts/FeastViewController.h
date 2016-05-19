//
//  FeastViewController.h
//  feasts
//
//  Created by Alexey Smirnov on 7/26/14.
//  Copyright (c) 2014 Alexey Smirnov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeastViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UITextView *descr;

@property NSUInteger pageIndex;
@property (nonatomic) NSString* iconStr;
@property (nonatomic) UINavigationItem* navItem;
@property (nonatomic) NSString* titleText;
@property (nonatomic) NSAttributedString* descriptionStr;

@end
