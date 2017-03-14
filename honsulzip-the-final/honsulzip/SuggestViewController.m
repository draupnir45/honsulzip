//
//  ViewController.m
//  honsulzip
//
//  Created by 박종찬 on 2017. 3. 9..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "SuggestViewController.h"
#import "HSRecipe.h"
#import "HSRecipeDataCenter.h"
#import "HSCustomCollectionTableViewCell.h"
#import "OnRowCollectionViewDataSource.h"
#import "SuggestViewBigHeader.h"
#import "SuggestViewSmallHeader.h"
#import "HSTableViewCell.h"
#import "HSUserDataController.h"
#import "DetailViewController.h"
#import "HSCollectionViewCell.h"
#import "FilterViewController.h"
#import "JCArrayFilter.h"

//#import "JCAlertController.h"

@interface SuggestViewController ()
<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, HSTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property OnRowCollectionViewDataSource *firstRowDataSource;
@property OnRowCollectionViewDataSource *secondRowDataSource;
@property NSArray *mainData;



@end


@implementation SuggestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"맞춤 추천";
    
    
//    self.mainData = [[HSRecipeDataCenter sharedData] recipeDataArray];
    
    self.firstRowDataSource = [[OnRowCollectionViewDataSource alloc] initWithDataArray:@[@7,@4,@6,@15,@11,@19,@25]];
    self.secondRowDataSource = [[OnRowCollectionViewDataSource alloc] initWithDataArray:@[@2,@8,@10,@30,@29,@9,@5]];
    
    
    [self.navigationController setNavigationBarHidden:YES];
    
    
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SuggestViewSectionBigHeader" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SuggestViewBigHeader"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SuggestViewSectionSmallHeader" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SuggestViewSmallHeader"];

    [self.tableView registerNib:[UINib nibWithNibName:@"HSTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HSTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HSCustomCollectionTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HSCustomCollectionTableViewCell"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    if (self.filtering) {
//        NSMutableArray *filteringArray = [self.mainData mutableCopy];
        NSMutableArray *resultArray = [[NSMutableArray alloc] init];
        
        for (NSString *criterion in self.drinkToFilter) {
            for (HSRecipe *item in self.mainData) {
                if (item.drink == [criterion integerValue]) {
                    [resultArray addObject:item];
                }
            }
        }
        
        for (NSString *criterion in self.recipeCostToFilter) {
            for (HSRecipe *item in resultArray) {
                if (item.cost == [criterion integerValue] && ![resultArray containsObject:item]) {
                    [resultArray addObject:item];
                }
            }
        }
        
        for (NSString *criterion in self.recipeTimeToFilter) {
            for (HSRecipe *item in resultArray) {
                if (item.time != [criterion integerValue] && ![resultArray containsObject:item]) {
                    [resultArray removeObject:item];
                }
            }
        }
        
        self.mainData = resultArray;
        
    } else {
        self.mainData = [[HSRecipeDataCenter sharedData] recipeDataArray];
    }
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointMake(0, 0)];
    

    
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.filtering) { return 1; }
    else { return 3; }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (self.filtering) {
        
        SuggestViewBigHeader *view = [tableView dequeueReusableCellWithIdentifier:@"SuggestViewBigHeader"];
        view.titleLabel.text = @"추천 메뉴";
        return view;
        
    } else {
        switch (section) {
            case 0:
            {
                SuggestViewSmallHeader *view = [tableView dequeueReusableCellWithIdentifier:@"SuggestViewSmallHeader"];
                view.titleLabel.text = @"편의점에서 해결할 수 있는";
                return view;
                break;
            }
                
            case 1:
            {
                SuggestViewSmallHeader *view = [tableView dequeueReusableCellWithIdentifier:@"SuggestViewSmallHeader"];
                view.titleLabel.text = @"이달의 제철 안주";
                return view;
                break;
            }
                
            default:
            {
                SuggestViewBigHeader *view = [tableView dequeueReusableCellWithIdentifier:@"SuggestViewBigHeader"];
                view.titleLabel.text = @"추천 메뉴";
                return view;
                break;
            }
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.filtering) {
        
        return 104;
        
    } else {
        
        switch (section) {
            case 0:
            case 1:
                return 72;
                break;
                
            default:
            {
                return 104;
                break;
            }
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [tableView dequeueReusableCellWithIdentifier:@"SectionFooterForSuggest"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.filtering) {
        return self.mainData.count;
    } else {
        switch (section) {
            case 0:
                return 1;
                break;
            case 1:
                return 1;
                break;
            default:
                return self.mainData.count;
                break;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.filtering) {
        HSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HSTableViewCell"];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        HSRecipe *item = [self.mainData objectAtIndex:indexPath.row];
        
        cell.titleImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",(long)item.recipeID]];
        
        switch (item.drink) {
            case HSDrinkSoju:
                cell.drinkIconImageView.image = [UIImage imageNamed:@"sojuIcon"];
                break;
            case HSDrinkBeer:
                cell.drinkIconImageView.image = [UIImage imageNamed:@"beerIcon"];
                break;
            case HSDrinkWine:
                cell.drinkIconImageView.image = [UIImage imageNamed:@"wineIcon"];
                break;
            default:
                break;
        }
        
        cell.titleLabel.text = item.name;
        cell.subTitleLabel.text = item.shortDescription;
        
        
        switch (item.time) {
            case HSRecipeTimeTo5Min:
                cell.timeLabel.text = @"5분";
                break;
            case HSRecipeTimeTo10Min:
                cell.timeLabel.text = @"10분";
                break;
            case HSRecipeTimeTo15Min:
                cell.timeLabel.text = @"15분";
                break;
            case HSRecipeTimeTo20Min:
                cell.timeLabel.text = @"20분";
                break;
            case HSRecipeTimeOver20Min:
                cell.timeLabel.text = @"20분 이상";
                break;
            default:
                NSLog(@"데이터 오류!");
                break;
        }
        
        cell.recipeID = item.recipeID;
        cell.delegate = self;
        
        NSDictionary *data = [[HSUserDataController sharedData] appData];
        NSArray *favArr = [data objectForKey:@"favorite"];
        if ([favArr containsObject:[NSNumber numberWithInteger:item.recipeID]]) {
            cell.favorite = YES;
            [cell.favoriteIcon setSelected:YES];
        } else {
            cell.favorite = NO;
            [cell.favoriteIcon setSelected:NO];
        }
        
        
        
        return cell;
    } else {
        if (indexPath.section == 0) {
            
            HSCustomCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HSCustomCollectionTableViewCell" forIndexPath:indexPath];
            
            cell.collectionView.delegate = self;
            cell.collectionView.dataSource = self.firstRowDataSource;
            cell.collectionView.tag = indexPath.row;
            [cell.collectionView setShowsHorizontalScrollIndicator:NO];
            [cell.collectionView registerNib:[UINib nibWithNibName:@"HSCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HSCollectionViewCell"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
        } else if (indexPath.section == 1) {
            
            
            HSCustomCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HSCustomCollectionTableViewCell" forIndexPath:indexPath];
                    [cell.collectionView registerNib:[UINib nibWithNibName:@"HSCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HSCollectionViewCell"];
            cell.collectionView.delegate = self;
            cell.collectionView.dataSource = self.secondRowDataSource;
            cell.collectionView.tag = indexPath.row;
            [cell.collectionView setShowsHorizontalScrollIndicator:NO];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
            
            
        } else {
            
            HSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HSTableViewCell"];
            
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            HSRecipe *item = [self.mainData objectAtIndex:indexPath.row];
            
            cell.titleImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",(long)item.recipeID]];
            
            switch (item.drink) {
                case HSDrinkSoju:
                    cell.drinkIconImageView.image = [UIImage imageNamed:@"sojuIcon"];
                    break;
                case HSDrinkBeer:
                    cell.drinkIconImageView.image = [UIImage imageNamed:@"beerIcon"];
                    break;
                case HSDrinkWine:
                    cell.drinkIconImageView.image = [UIImage imageNamed:@"wineIcon"];
                    break;
                default:
                    break;
            }
            
            cell.titleLabel.text = item.name;
            cell.subTitleLabel.text = item.shortDescription;
            
            
            switch (item.time) {
                case HSRecipeTimeTo5Min:
                    cell.timeLabel.text = @"5분";
                    break;
                case HSRecipeTimeTo10Min:
                    cell.timeLabel.text = @"10분";
                    break;
                case HSRecipeTimeTo15Min:
                    cell.timeLabel.text = @"15분";
                    break;
                case HSRecipeTimeTo20Min:
                    cell.timeLabel.text = @"20분";
                    break;
                case HSRecipeTimeOver20Min:
                    cell.timeLabel.text = @"20분 이상";
                    break;
                default:
                    NSLog(@"데이터 오류!");
                    break;
            }
            
            cell.recipeID = item.recipeID;
            cell.delegate = self;
            
            NSDictionary *data = [[HSUserDataController sharedData] appData];
            NSArray *favArr = [data objectForKey:@"favorite"];
            if ([favArr containsObject:[NSNumber numberWithInteger:item.recipeID]]) {
                cell.favorite = YES;
                [cell.favoriteIcon setSelected:YES];
            } else {
                cell.favorite = NO;
                [cell.favoriteIcon setSelected:NO];
            }
            
            
            
            return cell;
        }
    }


}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.filtering) {
        return 354;
    } else {
        switch (indexPath.section) {
            case 0:
                return 250;
                break;
            case 1:
                return 250;
                break;
            default:
                return 354;
                break;
        }
    }
}
#pragma mark - TableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"showDetailSegue" sender:cell];
}


#pragma mark - CollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"showDetailSegue" sender:cell];

}





#pragma mark - HSTableViewCellDelegate

-(void)tableViewCell:(HSTableViewCell *)cell favBtnSelected:(BOOL)on {
    
    NSDictionary *data = [[HSUserDataController sharedData] appData];
    NSArray *favArr = [data objectForKey:@"favorite"];
    NSMutableArray *mutableFavArr = [favArr mutableCopy];
    
    if (on) {
        [mutableFavArr addObject:[NSNumber numberWithInteger:cell.recipeID]];
    } else {
        [mutableFavArr removeObject:[NSNumber numberWithInteger:cell.recipeID]];
    }
    
    [[[HSUserDataController sharedData] appData] setObject:mutableFavArr forKey:@"favorite"];
    
    [[HSUserDataController sharedData] saveData];
    
    
}


#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetailSegue"]) {
        DetailViewController *detailViewController = segue.destinationViewController;
        HSCollectionViewCell *cell = sender;
        detailViewController.recipeID = cell.recipeID;
    } else if ([segue.identifier isEqualToString:@"FilterViewSegue"]) {
        FilterViewController *filterViewController = segue.destinationViewController;
        if (self.filtering) {
            filterViewController.drinkToFilter = [self.drinkToFilter mutableCopy];
            filterViewController.recipeTimeToFilter = [self.recipeTimeToFilter mutableCopy];
            filterViewController.recipeCostToFilter = [self.recipeCostToFilter mutableCopy];
        }
        filterViewController.controller = self;
    }
}

@end
