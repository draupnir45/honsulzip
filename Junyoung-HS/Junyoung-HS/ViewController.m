//
//  ViewController.m
//  Junyoung-HS
//
//  Created by ji jun young on 2017. 3. 9..
//  Copyright © 2017년 Fastcampus. All rights reserved.
//

#import "ViewController.h"
#import "HSRecipeDataCenter.h"
#import "HSRecipe.h"

@interface ViewController ()

@property NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *detail;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dataArray = [HSRecipeDataCenter sharedData].appData;
    HSRecipe *testRecipe = [[HSRecipe alloc]initWithData:self.dataArray[0]];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
