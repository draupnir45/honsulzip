//
//  HSRecipe.m
//  HonSulAnju
//
//  Created by 박종찬 on 2017. 3. 9..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "HSRecipe.h"

@implementation HSRecipe

- (instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        
        self.recipeID = [[data objectForKey:@"recipeID"] integerValue];
        self.name = [data objectForKey:@"name"];
        self.time = [[data objectForKey:@"time"] integerValue];
        self.cost = [[data objectForKey:@"cost"] integerValue];
        self.drinkDict = [data objectForKey:@"drinkDict"];
        self.drink = [[data objectForKey:@"drink"] integerValue];
        self.ingrediants = [data objectForKey:@"ingrediants"];
        self.detail = [data objectForKey:@"detail"];
        self.shortDescription = [data objectForKey:@"shortDescription"];
        
    }
    return self;
}

+ (NSArray *)fetchRecipesWithArray:(NSArray *)array {
    NSMutableArray *resultArr = [[NSMutableArray alloc] init];
    for (NSDictionary *data in array) {
        [resultArr addObject:[[HSRecipe alloc] initWithData:data]];
    }
    return resultArr;
}

@end
