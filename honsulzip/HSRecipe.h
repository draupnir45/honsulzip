//
//  HSRecipe.h
//  HonSulAnju
//
//  Created by 박종찬 on 2017. 3. 9..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HSRecipeTime){
    HSRecipeTimeTo5Min = 5, // 5분 미만
    HSRecipeTimeTo10Min = 10, // 10분 미만
    HSRecipeTimeTo15Min = 15, // 15분 미만
    HSRecipeTimeTo20Min = 20, // 20분 미만
    HSRecipeTimeOver20Min = 21 // 20분 이상
};

typedef NS_ENUM(NSUInteger, HSRecipeCost) {
    HSRecipeCostTo2000Won = 2000, //2000원 미만
    HSRecipeCostTo5000Won = 5000, //5000원 미만
    HSRecipeCostTo10000Won = 10000, //10000원 미만
    HSRecipeCostOver10000Won = 10001 // 10000원 이상
};

typedef NS_ENUM(NSUInteger, HSDirnkPrefer) {
    HSDirnkPreferNone, // 관계없음
    HSDirnkPreferGood, // 나름 어울림
    HSDirnkPreferBetter // 짱 어울림
};

typedef NS_ENUM(NSInteger, HSDrink) {
    HSDrinkBeer,
    HSDrinkSoju,
    HSDrinkWine
};




@interface HSRecipe : NSObject


@property (nonatomic) NSInteger recipeID; //레시피 ID
@property (nonatomic) NSString *name; //이름
@property (nonatomic) HSRecipeTime time; //걸리는 시간
@property (nonatomic) HSRecipeCost cost; //드는 예산
@property (nonatomic) HSDrink drink; //어울리는 술
@property (nonatomic) NSString *ingrediants; //재료 목록
@property (nonatomic) NSString *detail; //실제 레시피
@property (nonatomic) NSString *shortDescription; //간단 소개
@property (nonatomic) NSInteger rating; //별점

- (instancetype)initWithData:(NSDictionary *)data;
+ (NSArray *)fetchRecipesWithArray:(NSArray *)array;


@end
