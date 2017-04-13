//
//  FirstRowCollectionDataSource.m
//  honsulzip
//
//  Created by 박종찬 on 2017. 3. 12..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "OnRowCollectionViewDataSource.h"
#import "HSCollectionViewCell.h"
#import "HSRecipe.h"
#import "HSRecipeDataCenter.h"


@implementation OnRowCollectionViewDataSource

- (instancetype)initWithDataArray:(NSArray <NSNumber *> *)dataArray
{
    self = [super init];
    if (self) {
        self.dataArray = dataArray;
        HSCollectionViewCell *cell = [[HSCollectionViewCell alloc] init];
        [cell awakeFromNib];
        self.cellSize = cell.bounds.size;
    }
    return self;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HSCollectionViewCell" forIndexPath:indexPath];
    
    HSRecipe *item = [[[HSRecipeDataCenter sharedData] recipeDataArray] objectAtIndex:[[self.dataArray objectAtIndex:indexPath.row] integerValue]];
    
    
    if (item.cost == HSRecipeCostTo10000Won) {
        cell.recipeCostLabel.text = @"예산: 만원 미만";
    } else if (item.cost == HSRecipeCostOver10000Won) {
        cell.recipeCostLabel.text = @"예산: 만원 이상";
    } else {
        cell.recipeCostLabel.text = [NSString stringWithFormat:@"예산: %ld천원 미만",item.cost/1000];
    }
    
    switch (item.time) {
        case HSRecipeTimeTo5Min:
            cell.recipeTimeLabel.text = @"시간: 5분 미만";
            break;
        case HSRecipeTimeTo10Min:
            cell.recipeTimeLabel.text = @"시간: 10분 미만";
            break;
        case HSRecipeTimeTo15Min:
            cell.recipeTimeLabel.text = @"시간: 15분 미만";
            break;
        case HSRecipeTimeTo20Min:
            cell.recipeTimeLabel.text = @"시간: 20분 미만";
            break;
        case HSRecipeTimeOver20Min:
            cell.recipeTimeLabel.text = @"시간: 20분 이상";
            break;
        default:
            NSLog(@"데이터 오류!");
            break;
    }
    
    cell.recipeTitleLabel.text = item.name;
    cell.squareThumb.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",(long)item.recipeID]];
    cell.tag = collectionView.tag;
    cell.recipeID = item.recipeID;
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.cellSize;
}



@end
