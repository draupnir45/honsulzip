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

@property HSRecipeDataCenter *dataCenter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataCenter = [HSRecipeDataCenter sharedData];
    NSDictionary *dict = self.dataCenter.appData[0];
    
    HSRecipe *testRecipe = [[HSRecipe alloc] initWithData:dict];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
