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
        self.name = [data objectForKey:@"name"];
        self.time = [[data objectForKey:@"time"] integerValue];
        self.cost = [[data objectForKey:@"cost"] integerValue];
        self.drinkDict = [data objectForKey:@"drinkDict"];
        self.ingrediantsArr = [data objectForKey:@"ingrediantsArr"];
        self.detailArr = [data objectForKey:@"detailArr"];
        self.imageName = [data objectForKey:@"imageName"];
        self.shortDescription = [data objectForKey:@"shortDescription"];
    }
    return self;
}

@end
