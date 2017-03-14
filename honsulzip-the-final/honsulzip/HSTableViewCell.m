//
//  HSTableViewCell.m
//  honsulzip
//
//  Created by 박종찬 on 2017. 3. 12..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "HSTableViewCell.h"
#import "HSUserDataController.h"

@implementation HSTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.titleImageView.layer setCornerRadius:6];
    [self.shadeView.layer setCornerRadius:6];

    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)favSelected:(UIButton *)sender {
    
    self.favorite = !self.isFavorite;
    [sender setSelected:self.favorite];
    
    [self.delegate tableViewCell:self favBtnSelected:self.isFavorite];
    
}

@end
