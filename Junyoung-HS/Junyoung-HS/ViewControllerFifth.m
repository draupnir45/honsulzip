//
//  ViewControllerFifth.m
//  Junyoung-HS
//
//  Created by ji jun young on 2017. 3. 9..
//  Copyright © 2017년 Fastcampus. All rights reserved.
//

#import "ViewControllerFifth.h"

@interface ViewControllerFifth ()
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;

@end

@implementation ViewControllerFifth

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.button1.layer setCornerRadius:10];
    [self.button1.layer setBorderWidth:1];
    self.button1.layer.borderColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    
    [self.button2.layer setCornerRadius:10];
    [self.button2.layer setBorderWidth:1];
    self.button2.layer.borderColor = [UIColor colorWithRed:255/255.0 green:77/255.0 blue:0/255.0 alpha:1.0].CGColor;

    //Width = 1
    //self.yourView.layer.borderColor = UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).CGColor
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
