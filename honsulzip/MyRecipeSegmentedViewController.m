//
//  MyRecipeSegmentedViewController.m
//  honsulzip
//
//  Created by 박종찬 on 2017. 4. 16..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "MyRecipeSegmentedViewController.h"
#import "UIColor+HSAdditions.h"
#import "MyRecipeCollectionViewController.h"
#import "FavoriteTabTableViewController.h"
#import "DetailViewController.h"
#import "CustomSegmentDelegate.h"

@interface MyRecipeSegmentedViewController ()
<CustomSegmentDelegate>

@property (weak, nonatomic) IBOutlet UIButton *favoriteRecipeButton;
@property (weak, nonatomic) IBOutlet UIButton *myRecipeButton;
@property (weak, nonatomic) IBOutlet UIView *customSegmentedControl;
@property (weak, nonatomic) IBOutlet UIView *favoriteTabViewController;
@property (weak, nonatomic) IBOutlet UIView *myRecipeTabViewController;
@property NSInteger recipeIDToShow;

@end

@implementation MyRecipeSegmentedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self.favoriteRecipeButton setTitleColor:[UIColor hs_mainColor] forState:UIControlStateNormal];
    [self.favoriteRecipeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.myRecipeButton setTitleColor:[UIColor hs_mainColor] forState:UIControlStateNormal];
    [self.myRecipeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.customSegmentedControl.layer setBorderColor:[[UIColor hs_mainColor] CGColor]];
    [self.customSegmentedControl.layer setCornerRadius:22.0];
    [self.customSegmentedControl.layer setBorderWidth:2.0];
    
}

- (void)updateSegment {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)favoriteTapped:(UIButton *)sender {
    if (!sender.selected) {
        sender.selected = YES;
        sender.backgroundColor = [UIColor hs_mainColor];
        self.myRecipeButton.selected = NO;
        self.myRecipeButton.backgroundColor = [UIColor whiteColor];
        
        [self.favoriteTabViewController setHidden:NO];
        [self.myRecipeTabViewController setHidden:YES];
    }
}

- (IBAction)myRecipeTapped:(UIButton *)sender {
    if (!sender.selected) {
        sender.selected = YES;
        sender.backgroundColor = [UIColor hs_mainColor];
        self.favoriteRecipeButton.selected = NO;
        self.favoriteRecipeButton.backgroundColor = [UIColor whiteColor];
        
        [self.favoriteTabViewController setHidden:YES];
        [self.myRecipeTabViewController setHidden:NO];
    }
}

- (void)goToDetailViewWith:(NSInteger)recipeID {
    self.recipeIDToShow = recipeID;
    [self performSegueWithIdentifier:@"detailViewSegue" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"detailViewSegue"]) {
        DetailViewController *detailViewController = segue.destinationViewController;
        detailViewController.recipeID = self.recipeIDToShow;
    } else if ([segue.identifier isEqualToString:@"embedFavoriteTable"]) {
        FavoriteTabTableViewController *VC = segue.destinationViewController;
        VC.delegate = self;
    } else if ([segue.identifier isEqualToString:@"embedMyRecipeCollection"]) {
        MyRecipeCollectionViewController *VC = segue.destinationViewController;
        VC.delegate = self;
    }
}


@end
