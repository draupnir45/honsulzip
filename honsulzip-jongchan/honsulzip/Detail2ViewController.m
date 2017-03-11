//
//  DetailViewController.m
//  honsulzip
//
//  Created by 박종찬 on 2017. 3. 9..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "Detail2ViewController.h"
#import "RandomViewController.h"

@interface Detail2ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *recipeDetailBtn;

@end

@implementation Detail2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    UIColor *tintColorFromView =  [[UIApplication sharedApplication] keyWindow].tintColor;
    [self.recipeDetailBtn.layer setCornerRadius:self.recipeDetailBtn.bounds.size.height / 2
     ];
    [self.recipeDetailBtn setBackgroundColor:tintColorFromView];
    
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
