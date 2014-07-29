//
//  FeastViewController.m
//  feasts
//
//  Created by Alexey Smirnov on 7/26/14.
//  Copyright (c) 2014 Alexey Smirnov. All rights reserved.
//

#import "FeastViewController.h"

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
    self.description.attributedText = self.descriptionStr;

    CGFloat fixedWidth = self.description.frame.size.width;
    CGSize newSize = [self.description sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = self.description.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    self.description.frame = newFrame;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
