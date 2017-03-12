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


@implementation OnRowCollectionViewDataSource

- (instancetype)initWithDataArray:(NSArray <HSRecipe *> *)dataArray
{
    self = [super init];
    if (self) {
        self.dataArray = dataArray;
    }
    return self;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HSCollectionViewCell" forIndexPath:indexPath];
    
    HSRecipe *item = self.dataArray[indexPath.row];
    
    
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


@end
