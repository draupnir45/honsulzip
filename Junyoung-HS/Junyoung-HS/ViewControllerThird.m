//
//  ViewControllerThird.m
//  Junyoung-HS
//
//  Created by ji jun young on 2017. 3. 9..
//  Copyright © 2017년 Fastcampus. All rights reserved.
//

#import "ViewControllerThird.h"

@interface ViewControllerThird ()
@property (weak, nonatomic) IBOutlet UIImageView *imageName;

@end

@implementation ViewControllerThird

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.imageName.layer setCornerRadius:6];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
