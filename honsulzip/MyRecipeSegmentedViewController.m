//
//  MyRecipeSegmentedViewController.m
//  honsulzip
//
//  Created by 박종찬 on 2017. 4. 16..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "MyRecipeSegmentedViewController.h"
#import "UIColor+HSAdditions.h"

@interface MyRecipeSegmentedViewController ()
@property (weak, nonatomic) IBOutlet UIButton *favoriteRecipeButton;
@property (weak, nonatomic) IBOutlet UIButton *myRecipeButton;
@property (weak, nonatomic) IBOutlet UIView *customSegmentedControl;

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
    }
}

- (IBAction)myRecipeTapped:(UIButton *)sender {
    if (!sender.selected) {
        sender.selected = YES;
        sender.backgroundColor = [UIColor hs_mainColor];
        self.favoriteRecipeButton.selected = NO;
        self.favoriteRecipeButton.backgroundColor = [UIColor whiteColor];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
