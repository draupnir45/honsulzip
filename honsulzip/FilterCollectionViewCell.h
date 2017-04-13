//
//  FilterCollectionViewCell.h
//  honsulzip
//
//  Created by 박종찬 on 2017. 3. 13..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *backgroundSquare;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property BOOL on;

@end
