//
//  FirstRowCollectionDataSource.h
//  honsulzip
//
//  Created by 박종찬 on 2017. 3. 12..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class HSRecipe;

@interface OnRowCollectionViewDataSource : NSObject
<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property NSArray *dataArray;
- (instancetype)initWithDataArray:(NSArray <HSRecipe *> *)dataArray;
@property CGSize cellSize;

@end
