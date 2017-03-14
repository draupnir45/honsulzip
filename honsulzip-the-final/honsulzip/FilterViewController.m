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
#import "SuggestViewSmallHeader.h"
#import "FilterCollectionReusableView.h"
#import "SuggestViewController.h"

@interface FilterViewController ()
<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIButton *filterButton;
@property NSArray *dataArray;

@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.tintColor = [[UIApplication sharedApplication] keyWindow].tintColor;
    
    NSArray *dataArray = @[
                           @{@"section":@"술 종류", @"items":@[@"맥주",@"소주",@"와인",@"양주",@"막걸리",@"칵테일",@"소맥"]},
                           @{@"section":@"시간", @"items":@[ @"5분", @"10분", @"15분", @"20분", @"20분 이상"]},
                           @{@"section":@"비용", @"items":@[ @"2,000원 이내", @"5,000원 이내", @"10,000원 이내", @"10,000원 이상"]}
                           ];
    self.dataArray = dataArray;
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"FilterCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"FilterCollectionViewCell"];
    [self.collectionView setCollectionViewLayout:[[UICollectionViewLeftAlignedLayout alloc] init]];
    
    

    [self.collectionView registerNib:[UINib nibWithNibName:@"FilterCollectionReusableView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FilterCollectionReusableView"];
    
    
    UIColor *tintColorFromView =  [[UIApplication sharedApplication] keyWindow].tintColor;
    [self.filterButton.layer setCornerRadius:self.filterButton.bounds.size.height / 2];
    [self.filterButton setBackgroundColor:tintColorFromView];
    
    if (self.drinkToFilter.count + self.recipeTimeToFilter.count + self.recipeCostToFilter.count < 1) {
        self.drinkToFilter = [[NSMutableArray alloc] init];
        self.recipeTimeToFilter = [[NSMutableArray alloc] init];
        self.recipeCostToFilter = [[NSMutableArray alloc] init];
    }

    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self.dataArray[section] objectForKey:@"items"] count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        FilterCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FilterCollectionReusableView" forIndexPath:indexPath];
        NSString *title = [[self.dataArray objectAtIndex:indexPath.section] objectForKey:@"section"];
        headerView.titleLabel.text = title;
        
        reusableview = headerView;
    }
    
    
    return reusableview;
    
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FilterCollectionViewCell" forIndexPath:indexPath];

    cell.label.text = [[[self.dataArray objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row];
    cell.label.textColor = self.view.tintColor;
    
    switch (indexPath.section) {
        case 0:
        {
            if ([self.drinkToFilter containsObject:[NSNumber numberWithInteger:indexPath.row]]) {
                cell.on = YES;
            }
            
        }
            break;
        case 1:
        {
            if ([self.recipeTimeToFilter containsObject:[NSNumber numberWithInteger:indexPath.row]]) {
                cell.on = YES;
            }
            
        }
            break;
        case 2:
        {
            if ([self.recipeCostToFilter containsObject:[NSNumber numberWithInteger:indexPath.row]]) {
                cell.on = YES;
            }
            
        }
            break;
            
        default:
            break;
    }
    
    [self updateCellColor:cell];

    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    [(NSString*)[arrayOfStats objectAtIndex:indexPath.row] sizeWithAttributes:NULL]
    UIFont *font = [UIFont systemFontOfSize:17];
    CGSize textSize = [[[[self.dataArray objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row] sizeWithAttributes:@{NSFontAttributeName:font}];
    
    

    return CGSizeMake(textSize.width + 32, 32);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.collectionView.frame.size.width, 88.f);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FilterCollectionViewCell *cell = (FilterCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.on = !cell.on;
    [self updateCellColor:cell];
    switch (indexPath.section) {
        case 0:
        {
            if (![self.drinkToFilter containsObject:[NSNumber numberWithInteger:indexPath.row]]) {
                [self.drinkToFilter addObject:[NSNumber numberWithInteger:indexPath.row]];
            } else {
                [self.drinkToFilter removeObject:[NSNumber numberWithInteger:indexPath.row]];
            }
            
        }
            break;
        case 1:
        {
            if (![self.recipeTimeToFilter containsObject:[NSNumber numberWithInteger:indexPath.row]]) {
                [self.recipeTimeToFilter addObject:[NSNumber numberWithInteger:indexPath.row]];
            } else {
                [self.recipeTimeToFilter removeObject:[NSNumber numberWithInteger:indexPath.row]];
            }
            
        }
            break;
        case 2:
        {
            if (![self.recipeCostToFilter containsObject:[NSNumber numberWithInteger:indexPath.row]]) {
                [self.recipeCostToFilter addObject:[NSNumber numberWithInteger:indexPath.row]];
            } else {
                [self.recipeCostToFilter removeObject:[NSNumber numberWithInteger:indexPath.row]];
            }
            
        }
            break;
            
        default:
            break;
    }
    
}

-(void)setCellOn:(FilterCollectionViewCell *)cell {
    if (cell.on) {
        cell.backgroundSquare.backgroundColor = [UIColor whiteColor];
        cell.label.textColor = self.view.tintColor;
        cell.on = NO;
    } else {
    cell.backgroundSquare.backgroundColor = self.view.tintColor;
    cell.label.textColor = [UIColor whiteColor];
    cell.on = YES;
    }
    
}

-(void)setCell:(FilterCollectionViewCell *)cell on:(BOOL)on {
    cell.on = !cell.on;
    
    if (cell.on) {
        cell.backgroundSquare.backgroundColor = [UIColor whiteColor];
        cell.label.textColor = self.view.tintColor;
    } else {
        cell.backgroundSquare.backgroundColor = self.view.tintColor;
        cell.label.textColor = [UIColor whiteColor];
    }
    
}

- (void)updateCellColor:(FilterCollectionViewCell *)cell {
    if (cell.on) {
        cell.backgroundSquare.backgroundColor = self.view.tintColor;
        cell.label.textColor = [UIColor whiteColor];
        
    } else {
        cell.backgroundSquare.backgroundColor = [UIColor whiteColor];
        cell.label.textColor = self.view.tintColor;

    }
}


- (IBAction)saveBtnSelected:(id)sender {
    if (self.drinkToFilter.count + self.recipeCostToFilter.count + self.recipeTimeToFilter.count > 0) {
        self.controller.drinkToFilter = self.drinkToFilter;
        self.controller.recipeTimeToFilter = self.recipeTimeToFilter;
        self.controller.recipeCostToFilter = self.recipeCostToFilter;
        self.controller.filtering = YES;
    } else {
        self.controller.filtering = NO;
    }

    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}






@end
