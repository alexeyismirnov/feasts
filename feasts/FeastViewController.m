//
//  FeastViewController.m
//  feasts
//
//  Created by Alexey Smirnov on 7/26/14.
//  Copyright (c) 2014 Alexey Smirnov. All rights reserved.
//

#import "FeastViewController.h"
#import "FeastsShowIconController.h"

@interface FeastViewController ()

@end

@implementation FeastViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    self.navItem.title = self.titleText;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.icon.image = [UIImage imageNamed:self.iconStr];
    self.descr.attributedText = self.descriptionStr;

    CGFloat fixedWidth = self.descr.frame.size.width;
    CGSize newSize = [self.descr sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = self.descr.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    self.descr.frame = newFrame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showIcon:(UITapGestureRecognizer *)sender {
    
    FeastsShowIconController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowIconController"];
    
    controller.iconStr = self.iconStr;
    [self presentViewController:controller animated:true completion:nil];
}


@end
