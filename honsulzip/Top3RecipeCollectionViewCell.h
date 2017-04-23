//
//  Top3RecipeCollectionViewCell.h
//  honsulzip
//
//  Created by 박종찬 on 2017. 4. 23..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RateView;

@interface Top3RecipeCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet RateView *starRating;
@property (weak, nonatomic) IBOutlet UIImageView *drinkIconImageView;

@end
