//
//  RandomViewController.m
//  honsulzip
//
//  Created by 박종찬 on 2017. 3. 9..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "RandomViewController.h"

@interface RandomViewController ()

@property (weak, nonatomic) IBOutlet UIView *randomImageBorder;
@property (weak, nonatomic) IBOutlet UIImageView *randomImage;
@property (weak, nonatomic) IBOutlet UIButton *makeButton;
@property NSArray *imgArray;


@end


@implementation RandomViewController

-(void)viewDidLoad {
    
    UIColor *tintColorFromView =  [[UIApplication sharedApplication] keyWindow].tintColor;
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.randomImage.layer setCornerRadius:self.randomImage.bounds.size.width/2];
    [self.randomImage.layer setBorderColor:[tintColorFromView CGColor]];
    [self.randomImage.layer setBorderWidth:1];
    
    [self.randomImageBorder.layer setCornerRadius:self.randomImageBorder.bounds.size.width/2];
    [self.randomImageBorder.layer setBorderColor:[tintColorFromView CGColor]];
    [self.randomImageBorder.layer setBorderWidth:2];
    
    [self.makeButton.layer setCornerRadius:self.makeButton.bounds.size.height / 2];
    [self.makeButton setBackgroundColor:tintColorFromView];
    
    NSMutableArray *imageArr = [[NSMutableArray alloc] init];

    [imageArr addObject:[UIImage imageNamed:@"recipe1.jpg"]];
    [imageArr addObject:[UIImage imageNamed:@"recipe2.jpg"]];
    
    self.imgArray = imageArr;
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self runRandomSuggest];
    [self becomeFirstResponder];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(event.type == UIEventSubtypeMotionShake)
    {
        NSLog(@"called");
        [self runRandomSuggest];
        
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void)runRandomSuggest {
//    [UIImage imageNamed:[NSString stringWithFormat:@"recipe%ld.jpg",i]]
    

    
    for (NSInteger i = 0;  i < 31; i++) {
        
        
        [NSTimer scheduledTimerWithTimeInterval:0.07*i target:self selector:@selector(changethis) userInfo:nil repeats:NO];
//        self.randomImage.image = [imageArr objectAtIndex:i%2];
        

//        [NSThread sleepForTimeInterval:1.0f];
        
    }
    
//    NSTimeInterva
}

- (void)changethis {
    
    if (self.randomImage.image == [self.imgArray objectAtIndex:0]) {
            self.randomImage.image = [self.imgArray objectAtIndex:1];
    } else {
            self.randomImage.image = [self.imgArray objectAtIndex:0];
    }

}


@end
