//
//  RandomViewController.m
//  honsulzip
//
//  Created by 박종찬 on 2017. 3. 9..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "RandomViewController.h"
#import "JCRandomRollLabel.h"
#import "JCRandomRollImageView.h"
#import "HSRecipe.h"
#import "HSRecipeDataCenter.h"
#import "DetailViewController.h"


@interface NSString (Hangul)

- (NSString *)linearHangul;

@end

@implementation NSString (Hangul)

- (NSString *)linearHangul {
    NSArray<NSArray<NSString *> *> *hangul = @[@[@"ㄱ",@"ㄲ",@"ㄴ",@"ㄷ",@"ㄸ",@"ㄹ",@"ㅁ",@"ㅂ",@"ㅃ",@"ㅅ",@"ㅆ",@"ㅇ",@"ㅈ",@"ㅉ",@"ㅊ",@"ㅋ",@"ㅌ",@"ㅍ",@"ㅎ"],
                                               @[@"ㅏ",@"ㅐ",@"ㅑ",@"ㅒ",@"ㅓ",@"ㅔ",@"ㅕ",@"ㅖ",@"ㅗ",@"ㅘ",@"ㅙ",@"ㅚ",@"ㅛ",@"ㅜ",@"ㅝ",@"ㅞ",@"ㅟ",@"ㅠ",@"ㅡ",@"ㅢ",@"ㅣ"],
                                               @[@"",@"ㄱ",@"ㄲ",@"ㄳ",@"ㄴ",@"ㄵ",@"ㄶ",@"ㄷ",@"ㄹ",@"ㄺ",@"ㄻ",@"ㄼ",@"ㄽ",@"ㄾ",@"ㄿ",@"ㅀ",@"ㅁ",@"ㅂ",@"ㅄ",@"ㅅ",@"ㅆ",@"ㅇ",@"ㅈ",@"ㅊ",@"ㅋ",@"ㅌ",@"ㅍ",@"ㅎ"]];
    
    NSString *result = @"";
    for (NSInteger i = 0;i < self.length; i++) {
        NSInteger code = [self characterAtIndex:i] - 44032;
        if (code > -1 && code < 11172) {
            NSInteger choIdx = code / 21 / 28;
            NSInteger jungIdx = code % (21 * 28) / 28;
            NSInteger jongIdx = code % 28;
            result = [NSString stringWithFormat:@"%@%@%@%@", result, hangul[0][choIdx], hangul[1][jungIdx], hangul[2][jongIdx]];
        }
        else {
            result = [result stringByAppendingString:[NSString stringWithFormat:@"%C", [self characterAtIndex:i]]];
        }
    }
    return result;
}

@end



@interface RandomViewController ()
<JCRandomRollImageDelegate>

@property (weak, nonatomic) IBOutlet UIView *randomImageBorder;
@property (weak, nonatomic) IBOutlet JCRandomRollImageView *randomImage;
@property (weak, nonatomic) IBOutlet JCRandomRollLabel *randomLabel;
@property (weak, nonatomic) IBOutlet UIButton *makeButton;

@property NSMutableArray *recipeIDArray;
@property NSMutableArray *imageArray;
@property NSMutableArray *textArray;


@end


@implementation RandomViewController

-(void)viewDidLoad {
    
    self.title = @"랜덤 추천";
    
    UIColor *tintColorFromView =  [[UIApplication sharedApplication] keyWindow].tintColor;
    
    
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.randomImage.layer setCornerRadius:self.randomImage.bounds.size.width/2];
    [self.randomImage.layer setBorderColor:[tintColorFromView CGColor]];
    [self.randomImage.layer setBorderWidth:1];
    self.randomImage.delegate = self;
    
    [self.randomImageBorder.layer setCornerRadius:self.randomImageBorder.bounds.size.width/2];
    [self.randomImageBorder.layer setBorderColor:[tintColorFromView CGColor]];
    [self.randomImageBorder.layer setBorderWidth:2];
    
    [self.makeButton.layer setCornerRadius:self.makeButton.bounds.size.height / 2];
    [self.makeButton setBackgroundColor:tintColorFromView];
//    [self.makeButton setBackgroundColor:[UIColor lightGrayColor]];

    
    self.recipeIDArray = [[NSMutableArray alloc] init];
    self.imageArray = [[NSMutableArray alloc] init];
    self.textArray = [[NSMutableArray alloc] init];
    NSArray *recipeArray = [[HSRecipeDataCenter sharedData] recipeDataArray];

    for (NSInteger i = 0; i<recipeArray.count; i++) {
        [self.recipeIDArray addObject:[NSNumber numberWithInteger:i]];
        [self.imageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",(long)i]]];
        
        NSString *resultName = [[[[HSRecipeDataCenter sharedData] recipeDataArray] objectAtIndex:i] name];
        
        NSString *resultNameLineared = [resultName linearHangul];
        
        NSString *linearLast = [resultNameLineared substringFromIndex:resultNameLineared.length-1];
        
        NSArray<NSArray<NSString *> *> *hangul = @[@[@"ㄱ",@"ㄲ",@"ㄴ",@"ㄷ",@"ㄸ",@"ㄹ",@"ㅁ",@"ㅂ",@"ㅃ",@"ㅅ",@"ㅆ",@"ㅇ",@"ㅈ",@"ㅉ",@"ㅊ",@"ㅋ",@"ㅌ",@"ㅍ",@"ㅎ"],
                                                   @[@"ㅏ",@"ㅐ",@"ㅑ",@"ㅒ",@"ㅓ",@"ㅔ",@"ㅕ",@"ㅖ",@"ㅗ",@"ㅘ",@"ㅙ",@"ㅚ",@"ㅛ",@"ㅜ",@"ㅝ",@"ㅞ",@"ㅟ",@"ㅠ",@"ㅡ",@"ㅢ",@"ㅣ"],
                                                   @[@"",@"ㄱ",@"ㄲ",@"ㄳ",@"ㄴ",@"ㄵ",@"ㄶ",@"ㄷ",@"ㄹ",@"ㄺ",@"ㄻ",@"ㄼ",@"ㄽ",@"ㄾ",@"ㄿ",@"ㅀ",@"ㅁ",@"ㅂ",@"ㅄ",@"ㅅ",@"ㅆ",@"ㅇ",@"ㅈ",@"ㅊ",@"ㅋ",@"ㅌ",@"ㅍ",@"ㅎ"]];
        
        if ([hangul[2] containsObject:linearLast]) {
            [self.textArray addObject:[resultName stringByAppendingString:@"을"]];
        } else {
            [self.textArray addObject:[resultName stringByAppendingString:@"를"]];
        }
        
        
    }
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
            [self runRandomSuggest];
    });
    
    [self becomeFirstResponder];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(event.type == UIEventSubtypeMotionShake)
    {
        if (!self.randomImage.rolling) {
            [self.recipeIDArray removeLastObject];
            [self.imageArray removeLastObject];
            [self.textArray removeLastObject];
            
            [self runRandomSuggest];
        }
        
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void)runRandomSuggest {
    [self.recipeIDArray addObject:[NSNumber numberWithInteger:(arc4random()%9)]];
    [self.imageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",[self.recipeIDArray.lastObject integerValue]]]];
    
    NSString *resultName = [[[[HSRecipeDataCenter sharedData] recipeDataArray] objectAtIndex:[self.recipeIDArray.lastObject integerValue]] name];
    
    NSString *resultNameLineared = [resultName linearHangul];
    
    NSString *linearLast = [resultNameLineared substringFromIndex:resultNameLineared.length-1];
    
    NSArray<NSArray<NSString *> *> *hangul = @[@[@"ㄱ",@"ㄲ",@"ㄴ",@"ㄷ",@"ㄸ",@"ㄹ",@"ㅁ",@"ㅂ",@"ㅃ",@"ㅅ",@"ㅆ",@"ㅇ",@"ㅈ",@"ㅉ",@"ㅊ",@"ㅋ",@"ㅌ",@"ㅍ",@"ㅎ"],
                                               @[@"ㅏ",@"ㅐ",@"ㅑ",@"ㅒ",@"ㅓ",@"ㅔ",@"ㅕ",@"ㅖ",@"ㅗ",@"ㅘ",@"ㅙ",@"ㅚ",@"ㅛ",@"ㅜ",@"ㅝ",@"ㅞ",@"ㅟ",@"ㅠ",@"ㅡ",@"ㅢ",@"ㅣ"],
                                               @[@"",@"ㄱ",@"ㄲ",@"ㄳ",@"ㄴ",@"ㄵ",@"ㄶ",@"ㄷ",@"ㄹ",@"ㄺ",@"ㄻ",@"ㄼ",@"ㄽ",@"ㄾ",@"ㄿ",@"ㅀ",@"ㅁ",@"ㅂ",@"ㅄ",@"ㅅ",@"ㅆ",@"ㅇ",@"ㅈ",@"ㅊ",@"ㅋ",@"ㅌ",@"ㅍ",@"ㅎ"]];
    
    if ([hangul[2] containsObject:linearLast]) {
        [self.textArray addObject:[resultName stringByAppendingString:@"을"]];
    } else {
        [self.textArray addObject:[resultName stringByAppendingString:@"를"]];
    }
    

    
    
    [self.randomLabel rollWithArray:self.textArray timeIntervel:0.05 repeatNumb:2];
    [self.randomImage rollWithImageArray:self.imageArray timeIntervel:0.05 repeatNumb:2];
    
}


- (void)randomImageView:(JCRandomRollImageView *)imageView willStartRollingWithTimeInterval:(NSTimeInterval)interval {
    
    [self.makeButton setHidden:YES];
    
}

- (void)randomImageView:(JCRandomRollImageView *)imageView didEndRollingWithLastItem:(UIImage *)info {
    
    [self.makeButton setHidden:NO];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DetailViewSegue"]) {
        DetailViewController *detailViewController = segue.destinationViewController;
        detailViewController.recipeID = [[self.recipeIDArray lastObject] integerValue];
    }
}



@end
