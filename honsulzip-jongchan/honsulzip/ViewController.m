//
//  ViewController.m
//  honsulzip
//
//  Created by 박종찬 on 2017. 3. 9..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "ViewController.h"
#import "HSRecipe.h"
#import "HSRecipeDataCenter.h"

@interface ViewController ()

@property NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    HSRecipe *tempRecipe = [[HSRecipe alloc] init];
//    tempRecipe.name = @"숙주볶음";
//    tempRecipe.time = HSRecipeTimeTo10Min;
//    tempRecipe.cost = HSRecipeCostTo10000Won;
//    NSNumber *preferBetter = @2;
//    NSNumber *preferGood = @1;
//    NSNumber *preferNone = @0;
//    tempRecipe.drinkDict = @{
//                             @"맥주" : preferGood,
//                             @"소주" : preferBetter,
//                             @"와인" : preferNone,
//                             @"위스키" : preferNone,
//                             @"막걸리" : preferNone,
//                             @"소맥" : preferBetter,
//                             @"칵테일" : preferNone
//                             };
//    tempRecipe.ingrediantsArr = @[@"삼겹살", @"숙주", @"카놀라유", @"대파"];
//    tempRecipe.detailArr = @[@"먼저 삼겹살을 먹기 적당한 크기로 썰어줍니다.", @"카놀라유를 넣고 후라이팬을 달굽니다.", @"막 볶아버려욧"];
//    tempRecipe.imageName = @"recipe1";
    
    self.dataArray = [[HSRecipeDataCenter sharedData] appData];
    HSRecipe *testRecipe = [[HSRecipe alloc] initWithData:self.dataArray[0]];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
