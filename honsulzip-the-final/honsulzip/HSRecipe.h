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


@property (nonatomic) NSInteger recipeID;
@property (nonatomic) NSString *name;
@property (nonatomic) HSRecipeTime time;
@property (nonatomic) HSRecipeCost cost;
@property (nonatomic) NSDictionary *drinkDict;
@property (nonatomic) HSDrink drink;
@property (nonatomic) NSString *ingrediants;
@property (nonatomic) NSString *detail;
@property (nonatomic) NSString *shortDescription;

- (instancetype)initWithData:(NSDictionary *)data;
+ (NSArray *)fetchRecipesWithArray:(NSArray *)array;


@end
