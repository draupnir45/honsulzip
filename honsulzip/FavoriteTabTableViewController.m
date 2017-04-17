//
//  FavoriteTabTableViewController.m
//  honsulzip
//
//  Created by 박종찬 on 2017. 4. 16..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "FavoriteTabTableViewController.h"
#import "OnRowCollectionViewDataSource.h"
#import "HSCustomCollectionTableViewCell.h"
#import "SuggestViewSmallHeader.h"

@interface FavoriteTabTableViewController ()

@property NSArray *dataArray;
@property NSArray *dataSources;

@end

@implementation FavoriteTabTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[
                       @{@"drink":@"맥주",@"recipeIDs":@[@2,@1,@3]},
                       @{@"drink":@"소주",@"recipeIDs":@[@18,@13,@7]},
                       @{@"drink":@"양주",@"recipeIDs":@[@12,@1,@3]},
                       @{@"drink":@"와인",@"recipeIDs":@[@2,@1,@3]},
                       @{@"drink":@"막걸리",@"recipeIDs":@[@2,@1,@3]},
                       @{@"drink":@"칵테일",@"recipeIDs":@[@2,@1,@3]},
                       @{@"drink":@"소맥",@"recipeIDs":@[@2,@1,@3]}
                       ];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSMutableArray *dataSources = [[NSMutableArray alloc] init];
    for (NSDictionary *item in self.dataArray) {
        OnRowCollectionViewDataSource *dataSource = [[OnRowCollectionViewDataSource alloc] initWithDataArray:[item objectForKey:@"recipeIDs"]];
        [dataSources addObject:dataSource];
    }
    self.dataSources = dataSources;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HSCustomCollectionTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HSCustomCollectionTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SuggestViewSectionSmallHeader" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SuggestViewSmallHeader"];
//    [[self.dataArray[section] objectForKey:@"recipeIDs"] count]
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HSCustomCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HSCustomCollectionTableViewCell" forIndexPath:indexPath];
    
//    cell.collectionView.delegate = self;
    cell.collectionView.dataSource = self.dataSources[indexPath.row];
    cell.collectionView.tag = indexPath.row;
    [cell.collectionView setShowsHorizontalScrollIndicator:NO];
    [cell.collectionView registerNib:[UINib nibWithNibName:@"HSCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HSCollectionViewCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SuggestViewSmallHeader *view = [tableView dequeueReusableCellWithIdentifier:@"SuggestViewSmallHeader"];
    view.titleLabel.text = [NSString stringWithFormat:@"%@ (%ld)",[self.dataArray[section] objectForKey:@"drink"],[[self.dataArray[section] objectForKey:@"recipeIDs"] count]];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 72;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [tableView dequeueReusableCellWithIdentifier:@"SectionFooterForSuggest"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
