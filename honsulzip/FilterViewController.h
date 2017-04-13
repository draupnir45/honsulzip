//
//  FilterViewController.h
//  honsulzip
//
//  Created by 박종찬 on 2017. 3. 13..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SuggestViewController;

@interface FilterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property SuggestViewController *controller;
@property NSMutableArray *drinkToFilter;
@property NSMutableArray *recipeTimeToFilter;
@property NSMutableArray *recipeCostToFilter;


@end
