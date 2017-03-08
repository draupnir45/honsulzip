//
//  ViewControllerFourth.m
//  Junyoung-HS
//
//  Created by ji jun young on 2017. 3. 9..
//  Copyright © 2017년 Fastcampus. All rights reserved.
//

#import "ViewControllerFourth.h"

@interface ViewControllerFourth ()
@property (weak, nonatomic) IBOutlet UIImageView *imageName1;
@property (weak, nonatomic) IBOutlet UIImageView *imageName2;
@property (weak, nonatomic) IBOutlet UIImageView *imageName3;



@end

@implementation ViewControllerFourth

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.imageName1.layer setCornerRadius:6];
    [self.imageName2.layer setCornerRadius:6];
    [self.imageName3.layer setCornerRadius:6];
    
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
