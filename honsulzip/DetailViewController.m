//
//  DetailViewController.m
//  honsulzip
//
//  Created by 박종찬 on 2017. 3. 9..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "DetailViewController.h"
#import "RandomViewController.h"
#import "HSRecipeDataCenter.h"
#import "HSUserDataCenter.h"
#import "HSRecipe.h"
#import "RateView.h"
#import "NSMutableAttributedString+JCAdditions.h"

@interface DetailViewController ()
<RateViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *myRecipeButton;
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ingrediants;
@property (weak, nonatomic) IBOutlet RateView *starRatingView;
@property (weak, nonatomic) IBOutlet UILabel *detailRecipeLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HSRecipe *item = [[[HSRecipeDataCenter sharedData] recipeDataArray] objectAtIndex:self.recipeID];
    
    self.titleImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",self.recipeID]];
    self.titleLabel.text = item.name;
    self.subTitleLabel.text = item.shortDescription;
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];

    switch (item.time) {
        case HSRecipeTimeTo5Min:
            self.timeLabel.text = @"5분";
            break;
        case HSRecipeTimeTo10Min:
            self.timeLabel.text = @"10분";
            break;
        case HSRecipeTimeTo15Min:
            self.timeLabel.text = @"15분";
            break;
        case HSRecipeTimeTo20Min:
            self.timeLabel.text = @"20분";
            break;
        case HSRecipeTimeOver20Min:
            self.timeLabel.text = @"20분 이상";
            break;
        default:
            NSLog(@"데이터 오류!");
            break;
    }
    
    self.ingrediants.attributedText = [NSMutableAttributedString attrStringWithString:item.ingrediants lineSpacing:4.0 paragraphSpacing:20.0];
    
    self.starRatingView.rating = item.rating;
    self.starRatingView.delegate = self;
    self.starRatingView.editable = YES;
    self.starRatingView.maxRating = 5;
    
    self.detailRecipeLabel.attributedText = [NSMutableAttributedString attrStringWithString:item.detail lineSpacing:4.0 paragraphSpacing:20.0];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)rateView:(RateView *)rateView ratingDidChange:(CGFloat)rating {
    if (rating == 0) {
        self.myRecipeButton.selected = NO;
        [self setBookMark:NO];
    } else {
        [[HSUserDataCenter sharedData] setStarRatingWithRecipeID:self.recipeID rating:(NSInteger)rating];
        self.myRecipeButton.selected = YES;
        [self setBookMark:YES];
    }
}

- (IBAction)myRecipeSelected:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self setBookMark:sender.selected];
}

- (void)setBookMark:(BOOL)on {
    if (on) {
        [[HSUserDataCenter sharedData] addBookmarkWithRecipeID:self.recipeID];
    } else {
        [[HSUserDataCenter sharedData] removeBookmarkWithRecipeID:self.recipeID];
    }
}

@end
