//
//  CustomSegmentDelegate.h
//  honsulzip
//
//  Created by 박종찬 on 2017. 4. 23..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CustomSegmentDelegate <NSObject>

-(void)goToDetailViewWith:(NSInteger)recipeID;

@end
