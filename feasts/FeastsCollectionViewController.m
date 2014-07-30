//
//  FeastsCollectionViewController.m
//  feasts
//
//  Created by Alexey Smirnov on 7/30/14.
//  Copyright (c) 2014 Alexey Smirnov. All rights reserved.
//

#import "FeastsCollectionViewController.h"
#import "ViewController.h"

@interface FeastsCollectionViewController () {
    NSArray *titles;
    
}

@end

@implementation FeastsCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"feasts" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    titles = [dict objectForKey:@"Titles"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return titles.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.image = [UIImage imageNamed: [[NSString alloc] initWithFormat:@"icon%02d.png", indexPath.row+1] ];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Feast"]) {
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];

        ViewController *controller = segue.destinationViewController;
        controller.feastIndex = indexPath.row;
    }
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
