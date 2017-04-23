//
//  JCDataCenter.h
//  PlistPrac
//
//  Created by 박종찬 on 2017. 3. 3..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const BOOKMARKS_KEY = @"bookmarks";
static NSString * const MYRECIPES_KEY = @"myRecipes";

@interface HSUserDataCenter : NSObject


@property NSMutableDictionary *userData;
@property (readonly) NSMutableArray *bookmarks;
@property (readonly) NSMutableArray *myRecipes;


///저장된 데이터를 가진 싱글톤 클래스 객체를 반환합니다.
+ (instancetype)sharedData;

///데이터를 저장합니다.
- (void)saveData;


- (void)addBookmarkWithRecipeID:(NSInteger)recipeID;
- (void)removeBookmarkWithRecipeID:(NSInteger)recipeID;
- (void)setStarRatingWithRecipeID:(NSInteger)recipeID rating:(NSInteger)rating;

- (void)fetchRatings;
- (NSArray *)sortedMyRecipes;
- (NSArray *)favoriteDataArray;

@end
