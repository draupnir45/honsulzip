//
//  JCRandomRollImageView.h
//  JCCustomClasses
//
//  Created by 박종찬 on 2017. 3. 10..
//  Copyright © 2017년 박종찬. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JCRandomRollImageView;

@protocol JCRandomRollImageDelegate <NSObject>

@optional

- (void)randomImageView:(JCRandomRollImageView *)imageView didEndRollingWithLastItem:(UIImage *)info;
- (void)randomImageView:(JCRandomRollImageView *)imageView willStartRollingWithTimeInterval:(NSTimeInterval)interval;

@end


@interface JCRandomRollImageView : UIImageView

@property BOOL rolling;
@property (nonatomic, weak) id <JCRandomRollImageDelegate> delegate;

- (void)rollWithImageArray:(NSArray <UIImage *>*)array timeIntervel:(NSTimeInterval)timeInterval;
- (void)rollWithImageArray:(NSArray <UIImage *>*)array timeIntervel:(NSTimeInterval)timeInterval repeatNumb:(NSInteger)repeatNumb;

@end
