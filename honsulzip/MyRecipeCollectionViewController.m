//
//  MyRecipeCollectionViewController.m
//  honsulzip
//
//  Created by 박종찬 on 2017. 4. 16..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "MyRecipeCollectionViewController.h"
#import "HSCollectionViewCell.h"
#import "Top3RecipeCollectionViewCell.h"
#import "HSUserDataCenter.h"
#import "HSRecipeDataCenter.h"
#import "HSRecipe.h"
#import "RateView.h"
#import "SuggestViewSmallHeader.h"
#import "MyRecipeCollectionReusableView.h"

@interface MyRecipeCollectionViewController ()
<UICollectionViewDelegateFlowLayout>

@property NSArray *sortedMyRecipes;

@end

@implementation MyRecipeCollectionViewController

static NSString * const cellIdentifier1 = @"Top3RecipeCollectionViewCell";
static NSString * const cellIdentifier2 = @"HSCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:cellIdentifier1 bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellIdentifier1];
    
    [self.collectionView registerNib:[UINib nibWithNibName:cellIdentifier2 bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellIdentifier2];
    
//    [self.collectionView registerNib:[UINib nibWithNibName:@"SuggestViewSectionSmallHeader" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SuggestViewSmallHeader"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyRecipeCollectionReusableView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyRecipeCollectionReusableView"];
    
    self.sortedMyRecipes = [[HSUserDataCenter sharedData] sortedMyRecipes];
    
    // Do any additional setup after loading the view.
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    if (self.sortedMyRecipes.count < 3) {
        return 1;
    } else {
        return 2;
    }

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of items
    
    if (self.sortedMyRecipes.count < 3) {
        return self.sortedMyRecipes.count;
    } else {
        switch (section) {
            case 0:
                return 3;
                break;
                
            default:
                return self.sortedMyRecipes.count - 3;
                break;
        }
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            Top3RecipeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier1 forIndexPath:indexPath];
            NSInteger recipeID = [[self.sortedMyRecipes[indexPath.row] objectForKey:@"recipeID"] integerValue];
            HSRecipe *item = [[[HSRecipeDataCenter sharedData] recipeDataArray] objectAtIndex:recipeID];
            cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",(long)item.recipeID]];
            cell.titleLabel.text = item.name;
            cell.starRating.rating = item.rating;
            cell.drinkIconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"drinkicon%ld",item.drink]];
            cell.tag = item.recipeID;
            return cell;
        }
            break;
            
        default:
        {
            HSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier2 forIndexPath:indexPath];
            NSInteger recipeID = [[self.sortedMyRecipes[indexPath.row+3] objectForKey:@"recipeID"] integerValue];
            HSRecipe *item = [[[HSRecipeDataCenter sharedData] recipeDataArray] objectAtIndex:recipeID];
            
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
            break;
    }
    
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return CGSizeMake(self.collectionView.frame.size.width - 32, 64);
            break;
            
        default:
            return CGSizeMake(self.collectionView.frame.size.width/2 - 24, self.collectionView.frame.size.width*3/4 - 36);
            break;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        MyRecipeCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyRecipeCollectionReusableView" forIndexPath:indexPath];
        view.titleLabel.text = @"나의 베스트 안주";
        reusableview = view;
    }
    
    
    return reusableview;
    
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return CGSizeMake(self.collectionView.frame.size.width, 70.f);
            break;
            
        default:
            return CGSizeZero;
            break;
    }

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [self.delegate goToDetailViewWith:cell.tag];
}

@end
