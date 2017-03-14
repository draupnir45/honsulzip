//
//  JCRandomRollImageView.m
//  JCCustomClasses
//
//  Created by 박종찬 on 2017. 3. 10..
//  Copyright © 2017년 박종찬. All rights reserved.
//

#import "JCRandomRollImageView.h"

@interface JCRandomRollImageView ()

@property NSTimer *rollingTimer;
@property NSInteger rollingIndex;
@property NSArray *imgArray;
@property NSInteger repeatNumb;

@end


@implementation JCRandomRollImageView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.rolling = NO;
    
}


- (void)rollWithImageArray:(NSArray <UIImage *>*)array timeIntervel:(NSTimeInterval)timeInterval {

    self.imgArray = array;
    [self initializeRollingAnimationWithRepeatNumb:1 timeInterval:timeInterval];
    
    self.rollingTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    
    
}

- (void)rollWithImageArray:(NSArray <UIImage *>*)array timeIntervel:(NSTimeInterval)timeInterval repeatNumb:(NSInteger)repeatNumb {
    
    self.imgArray = array;
    [self initializeRollingAnimationWithRepeatNumb:repeatNumb timeInterval:timeInterval];
    
    NSInteger secsToRoll = timeInterval * array.count *repeatNumb;
    [self.delegate randomImageView:self willStartRollingWithTimeInterval:secsToRoll];
    self.rollingTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(changeImageRepeat) userInfo:nil repeats:YES];
    
    
    
}

- (void)changeImage {
    if (self.rollingIndex < self.imgArray.count) {
        self.image = self.imgArray[self.rollingIndex];
        self.rollingIndex++;
    } else {
        [self stopRolling];
    }
    
}

- (void)changeImageRepeat{
    if (self.rollingIndex < self.imgArray.count * self.repeatNumb) {
        self.image = self.imgArray[self.rollingIndex % self.imgArray.count];
        self.rollingIndex++;
    } else {
        [self stopRolling];
    }
    
}


- (void)initializeRollingAnimationWithRepeatNumb:(NSInteger)repeatNumb timeInterval:(NSTimeInterval)timeInterval{
    self.rolling = YES;
    self.rollingIndex = 0;
    self.repeatNumb = repeatNumb;
    NSInteger secsToRoll = timeInterval * self.imgArray.count *repeatNumb;
    [self.delegate randomImageView:self willStartRollingWithTimeInterval:secsToRoll];
    
}


- (void)stopRolling {
    [self.rollingTimer invalidate];
    self.rollingTimer = nil;
    [self.delegate randomImageView:self didEndRollingWithLastItem:[self.imgArray lastObject]];
    self.imgArray = @[];
    self.rollingIndex = 0;
    self.rolling = NO;
}



@end
