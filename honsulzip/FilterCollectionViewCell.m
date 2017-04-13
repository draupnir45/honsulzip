//
//  FilterCollectionViewCell.m
//  honsulzip
//
//  Created by 박종찬 on 2017. 3. 13..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "FilterCollectionViewCell.h"

@implementation FilterCollectionViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIColor *tintColorFromView =  [[UIApplication sharedApplication] keyWindow].tintColor;
    
    [self.backgroundSquare.layer setCornerRadius:16];
    [self.backgroundSquare.layer setBorderWidth:1];
    [self.backgroundSquare.layer setBorderColor:[tintColorFromView CGColor]];
    

    
    
}


@end
