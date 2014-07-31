//
//  ViewController.m
//  feasts
//
//  Created by Alexey Smirnov on 7/28/14.
//  Copyright (c) 2014 Alexey Smirnov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

NSArray *titles;
NSArray *subtitles;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"后退" style:UIBarButtonItemStyleBordered target:self action:@selector(goBack:)];
    
    self.navigationItem.leftBarButtonItem = backButton;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"feasts" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    titles = [dict objectForKey:@"Titles"];
    subtitles = [dict objectForKey:@"Subtitles"];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    FeastViewController *startingViewController = [self viewControllerAtIndex:self.feastIndex];
    
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((FeastViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((FeastViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [titles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (FeastViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([titles count] == 0) || (index >= [titles count])) {
        return nil;
    }

    // Create a new view controller and pass suitable data.
    FeastViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentController"];

    NSURL *path = [[NSBundle mainBundle]
                   URLForResource:[[NSString alloc] initWithFormat:@"feast%02u", index+1]
                   withExtension:@"rtf"];
    
    NSMutableAttributedString *res = [[NSMutableAttributedString alloc]   initWithFileURL:path options:@{NSDocumentTypeDocumentAttribute:NSRTFTextDocumentType} documentAttributes:nil error:nil];
    
    [res beginEditing];
    
    [res enumerateAttribute:NSFontAttributeName inRange:NSMakeRange(0, res.length) options:0 usingBlock:^(id value, NSRange range, BOOL *stop) {
        if (value) {
            UIFont *oldFont = (UIFont *)value;
            
            int fontSize;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                fontSize = 18;
            } else {
                fontSize = 32;
            }
            UIFont *newFont = [oldFont fontWithSize:fontSize];
            [res removeAttribute:NSFontAttributeName range:range];
            [res addAttribute:NSFontAttributeName value:newFont range:range];
        }
    }];
 
    [res endEditing];
    
    controller.descriptionStr = res;
    controller.iconStr = [[NSString alloc] initWithFormat:@"icon%02u.png", index+1];
    controller.titleText = [titles objectAtIndex:index];
    controller.pageIndex = index;
    controller.navItem = self.navigationItem;
    
    return controller;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [titles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return self.feastIndex;
}


@end
