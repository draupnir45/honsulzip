//
//  MyRecipeViewController.m
//  honsulzip
//
//  Created by 박종찬 on 2017. 3. 14..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "MyRecipeViewController.h"
#import "HSCustomCollectionTableViewCell.h"
#import "OnRowCollectionViewDataSource.h"
#import "HSRecipeDataCenter.h"
#import "HSRecipe.h"
#import "SuggestViewSmallHeader.h"
#import "DetailViewController.h"
#import "HSCollectionViewCell.h"

@interface MyRecipeViewController ()
<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *drinkArray;
@property NSArray <HSRecipe *> *dataArray;
@property NSArray <NSDictionary *> *dataSourceArray;

@end

@implementation MyRecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.drinkArray = @[@"맥주", @"소주", @"와인"];
    self.dataArray = [[HSRecipeDataCenter sharedData] recipeDataArray];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"HSCustomCollectionTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HSCustomCollectionTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SuggestViewSectionSmallHeader" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SuggestViewSmallHeader"];
    
    
    NSMutableArray *dataSourceArray = [[NSMutableArray alloc] init];

    
    for (NSInteger row = 0; row < self.drinkArray.count; row++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < self.dataArray.count; i++) {
            if ([self.dataArray[i] drink] == row) {
                [array addObject:[NSNumber numberWithInteger: self.dataArray[i].recipeID]];
            }
        }
        
        if (array.count != 0) {
            OnRowCollectionViewDataSource *dataSource = [[OnRowCollectionViewDataSource alloc] initWithDataArray:array];
            NSDictionary *dataSourceDictionary = @{ @"dataSource":dataSource, @"section":[self.drinkArray objectAtIndex:row]};
            [dataSourceArray addObject:dataSourceDictionary];
        }
        
    }
    
    self.dataSourceArray = dataSourceArray;
    

    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourceArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SuggestViewSmallHeader *view = [tableView dequeueReusableCellWithIdentifier:@"SuggestViewSmallHeader"];
    view.titleLabel.text = [self.dataSourceArray[section] objectForKey:@"section"];
    
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [tableView dequeueReusableCellWithIdentifier:@"SectionFooterForSuggest"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 72;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HSCustomCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HSCustomCollectionTableViewCell" forIndexPath:indexPath];
    
    cell.collectionView.delegate = self;
    cell.collectionView.dataSource = [self.dataSourceArray[indexPath.section] objectForKey:@"dataSource"];
    
    [cell.collectionView setShowsHorizontalScrollIndicator:NO];
    [cell.collectionView registerNib:[UINib nibWithNibName:@"HSCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HSCollectionViewCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250;
}

#pragma mark - CollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"showDetailSegue" sender:cell];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetailSegue"]) {
        DetailViewController *detailViewController = segue.destinationViewController;
        HSCollectionViewCell *cell = sender;
        detailViewController.recipeID = cell.recipeID;
    }
}

@end
