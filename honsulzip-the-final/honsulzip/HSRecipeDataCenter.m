//
//  JCPlistDataController.m
//  PlistPrac
//
//  Created by 박종찬 on 2017. 3. 3..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "HSRecipeDataCenter.h"
#import "HSRecipe.h"

@interface HSRecipeDataCenter ()

@property NSArray *appData;

@end


@implementation HSRecipeDataCenter


+ (instancetype)sharedData {
    static HSRecipeDataCenter *sharedData = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedData = [[HSRecipeDataCenter alloc] init];
    });
    
    return sharedData;
}




- (instancetype)init
{
    self = [super init];
    if (self) {

            NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"HSRecipeList" ofType:@"plist"];
        
        self.recipeDataArray = [HSRecipe fetchRecipesWithArray:[NSArray arrayWithContentsOfFile:bundlePath]];

        
    }
    return self;
}


@end
