//
//  HSTableViewCell.h
//  honsulzip
//
//  Created by 박종찬 on 2017. 3. 12..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HSTableViewCell;

@protocol HSTableViewCellDelegate <NSObject>

- (void)tableViewCell:(HSTableViewCell *)cell favBtnSelected:(BOOL)on;

@end



@interface HSTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UIView *shadeView;
@property (weak, nonatomic) IBOutlet UIImageView *drinkIconImageView;
@property (weak, nonatomic) IBOutlet UIButton *favoriteIcon;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property NSInteger recipeID;
@property id <HSTableViewCellDelegate> delegate;
@property (getter=isFavorite) BOOL favorite;

@end


