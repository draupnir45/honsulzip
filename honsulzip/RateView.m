//
//  RateView.m
//  CustomView
//
//  Created by Ray Wenderlich on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RateView.h"

@implementation RateView


- (void)baseInit {
    self.notSelectedImage = [UIImage imageNamed:@"starOff"];
    self.halfSelectedImage = nil;
    self.fullSelectedImage = [UIImage imageNamed:@"star"];
    self.rating = 0;
    self.editable = NO;    
    self.imageViews = [[NSMutableArray alloc] init];
    self.maxRating = 5;
    self.midMargin = 5;
    self.leftMargin = 0;
    self.minImageSize = CGSizeMake(5, 5);
    self.delegate = nil;    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self baseInit];
    }
    return self;
}

///리프레시하는 곳?
- (void)refresh {
    for(NSInteger i = 0; i < self.imageViews.count; ++i) {
        UIImageView *imageView = [self.imageViews objectAtIndex:i];
        if (self.rating >= i+1) {
            imageView.image = self.fullSelectedImage;
        } else if (self.rating > i) {
            imageView.image = self.halfSelectedImage;
        } else {
            imageView.image = self.notSelectedImage;
        }
    }
}


///별들을 자리에 맞게 넣음
- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.notSelectedImage == nil) return;
    
    CGFloat desiredImageWidth = (self.frame.size.width - (self.leftMargin*2) - (self.midMargin*self.imageViews.count)) / self.imageViews.count;
    CGFloat imageWidth = MAX(self.minImageSize.width, desiredImageWidth);
    CGFloat imageHeight = MAX(self.minImageSize.height, self.frame.size.height);
    
    for (NSInteger i = 0; i < self.imageViews.count; ++i) {
        
        UIImageView *imageView = [self.imageViews objectAtIndex:i];
        CGRect imageFrame = CGRectMake(self.leftMargin + i*(self.midMargin+imageWidth), 0, imageWidth, imageHeight);
        imageView.frame = imageFrame;
        
    }    
    
}

#pragma mark - Setter Override
//각각 할 일 하고 리프레시 찍어줌.

///전체 별 수에 따라 'imageViews' 어레이를 세팅, 이후 그 어레이에 의해 나머지가 작동
- (void)setMaxRating:(NSInteger)maxRating {
    _maxRating = maxRating;
    
    // Remove old image views
    for(NSInteger i = 0; i < self.imageViews.count; ++i) {
        UIImageView *imageView = (UIImageView *) [self.imageViews objectAtIndex:i];
        [imageView removeFromSuperview];
    }
    [self.imageViews removeAllObjects];
    
    // Add new image views
    for(NSInteger i = 0; i < maxRating; ++i) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.imageViews addObject:imageView];
        [self addSubview:imageView];
    }
    
    // Relayout and refresh
    [self setNeedsLayout];
    [self refresh];
}

- (void)setNotSelectedImage:(UIImage *)image {
    _notSelectedImage = image;
    [self refresh];
}

- (void)setHalfSelectedImage:(UIImage *)image {
    _halfSelectedImage = image;
    [self refresh];
}

- (void)setFullSelectedImage:(UIImage *)image {
    _fullSelectedImage = image;
    [self refresh];
}

- (void)setRating:(CGFloat)rating {
    _rating = rating;
    [self refresh];
}

#pragma mark - Touch Handling

- (void)handleTouchAtLocation:(CGPoint)touchLocation {
    if (!self.editable) return; ///에디터블하지 않다면 무시
    
    NSInteger newRating = 0; ///새로운 레이팅을 위한 변수
    
    ///i가 maxrating-1로부터 0보다 크거나 같을 동안 작아지면서 반복. 즉, maxRating만큼 반복
    for(NSInteger i = self.imageViews.count - 1; i >= 0; i--) {
        UIImageView *imageView = [self.imageViews objectAtIndex:i];        
        if (touchLocation.x > imageView.frame.origin.x) { //터치된 가로 위치가 이미지뷰 자신의 프레임의 오리진보다 크다면 즉 3번쩨x와 4번째x 사이일 경우, i = 2 rating = 3
            newRating = i+1;
            break;
        }
    }
    
    self.rating = newRating;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    [self handleTouchAtLocation:touchLocation];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    [self handleTouchAtLocation:touchLocation];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //////////////Delegate
    [self.delegate rateView:self ratingDidChange:self.rating];
}

@end
