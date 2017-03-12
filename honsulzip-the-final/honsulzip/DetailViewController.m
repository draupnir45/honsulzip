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
#import "HSRecipe.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIButton *recipeDetailBtn;
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ingrediants;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HSRecipe *item = [[[HSRecipeDataCenter sharedData] recipeDataArray] objectAtIndex:self.recipeID];
    
    self.titleImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",self.recipeID]];
    self.titleLabel.text = item.name;
    self.subTitleLabel.text = item.shortDescription;
    
    
    
    UIColor *tintColorFromView =  [[UIApplication sharedApplication] keyWindow].tintColor;
    [self.recipeDetailBtn.layer setCornerRadius:self.recipeDetailBtn.bounds.size.height / 2
     ];
    [self.recipeDetailBtn setBackgroundColor:tintColorFromView];
    
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
    
    self.ingrediants.text = item.ingrediants;
    
    
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

-(void)unwindForSegue:(UIStoryboardSegue *)unwindSegue towardsViewController:(UIViewController *)subsequentVC {
    if ([subsequentVC isMemberOfClass:[RandomViewController class]]) {
        //일단대기
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
