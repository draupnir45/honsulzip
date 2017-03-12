//
//  FilterViewController.m
//  honsulzip
//
//  Created by 박종찬 on 2017. 3. 13..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "FilterViewController.h"
#import "FilterCollectionViewCell.h"
#import "UICollectionViewLeftAlignedLayout.h"

@interface FilterViewController ()
<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *filterButton;

@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"FilterCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"FilterCollectionViewCell"];
    [self.collectionView setCollectionViewLayout:[[UICollectionViewLeftAlignedLayout alloc] init]];
    
    UIColor *tintColorFromView =  [[UIApplication sharedApplication] keyWindow].tintColor;
    [self.filterButton.layer setCornerRadius:self.filterButton.bounds.size.height / 2];
    [self.filterButton setBackgroundColor:tintColorFromView];
    
    
//    [self.collectionView setTransform:CGAffineTransformMakeScale(-1, 1)];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FilterCollectionViewCell" forIndexPath:indexPath];
    
    cell.label.text = @"asfasfda";
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    [(NSString*)[arrayOfStats objectAtIndex:indexPath.row] sizeWithAttributes:NULL]
    UIFont *font = [UIFont systemFontOfSize:17];
    CGSize textSize = [@"asfasfda" sizeWithAttributes:@{NSFontAttributeName:font}];
    
    

    return CGSizeMake(textSize.width + 32, 32);
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
