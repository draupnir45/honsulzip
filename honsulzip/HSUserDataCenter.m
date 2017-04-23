//
//  JCPlistDataController.m
//  PlistPrac
//
//  Created by 박종찬 on 2017. 3. 3..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "HSUserDataCenter.h"
#import "HSRecipeDataCenter.h"
#import "HSRecipe.h"

@interface HSUserDataCenter ()

@property NSFileManager *fileManager;
@property NSString *documentDirPath;
@property (readwrite) NSMutableArray *bookmarks;
@property (readwrite) NSMutableArray *myRecipes;

@end


@implementation HSUserDataCenter


+ (instancetype)sharedData {
    static HSUserDataCenter *sharedData = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedData = [[HSUserDataCenter alloc] init];
    });
    
    return sharedData;
}




- (instancetype)init
{
    self = [super init];
    if (self) {

        self.documentDirPath = [HSUserDataCenter documentDiretoryPath];
        self.fileManager = [NSFileManager defaultManager];
        
        
        if ([self.fileManager fileExistsAtPath:self.documentDirPath]) {
            //저장했던 내용 로드
            self.userData = [[NSDictionary dictionaryWithContentsOfFile:self.documentDirPath] mutableCopy];
        } else  {
            
            NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"HSUserData" ofType:@"plist"];
            //최초접근시 데이터용 프로퍼티에 번들 내용을 넣음
            self.userData = [[NSDictionary dictionaryWithContentsOfFile:bundlePath] mutableCopy];

        }
        //정보를 우선 읽어와(non뮤터블) 뮤터블로 카피.
        self.bookmarks = [[self.userData objectForKey:BOOKMARKS_KEY] mutableCopy];
        self.myRecipes = [[self.userData objectForKey:MYRECIPES_KEY] mutableCopy];
        
        //다시 할당.
        [self.userData setObject:self.bookmarks forKey:BOOKMARKS_KEY];
        [self.userData setObject:self.myRecipes forKey:MYRECIPES_KEY];
        
    }
    return self;
}

- (void)saveData {

    if (![self.fileManager fileExistsAtPath:self.documentDirPath]) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"HSUserData" ofType:@"plist"];
        [self.fileManager copyItemAtPath:bundlePath toPath:self.documentDirPath error:nil];
    }
    
    [self.userData writeToFile:self.documentDirPath atomically:NO];
    
}


+ (NSString *)documentDiretoryPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docuPath = [(NSString *)([paths objectAtIndex:0]) stringByAppendingString:@"/HSUserData.plist"];
    
    return docuPath;
}

- (void)addBookmarkWithRecipeID:(NSInteger)recipeID {
    if (![self.bookmarks containsObject:[NSNumber numberWithInteger:recipeID]]) {
    
        [self.bookmarks addObject:[NSNumber numberWithInteger:recipeID]];
        [self saveData];
    }

}

- (void)removeBookmarkWithRecipeID:(NSInteger)recipeID {
    [self.bookmarks removeObject:[NSNumber numberWithInteger:recipeID]];
    [self saveData];
}

- (void)setStarRatingWithRecipeID:(NSInteger)recipeID rating:(NSInteger)rating {
    for (NSDictionary *item in self.myRecipes) {
        if ([[item objectForKey:@"recipeID"] integerValue] == recipeID) {
            [self.myRecipes removeObject:item];
            break;
        }
    }
    
    [self.myRecipes addObject:@{ @"recipeID":[NSNumber numberWithInteger:recipeID], @"rating":[NSNumber numberWithInteger:rating]}];
    [self saveData];
    
    NSArray *recipeDataArray = [[HSRecipeDataCenter sharedData] recipeDataArray];
    
    for (HSRecipe *recipe in recipeDataArray) {
        if (recipe.recipeID == recipeID) {
            recipe.rating = rating;
        }
    }
    
}

- (void)fetchRatings {
    NSArray *recipeDataArray = [[HSRecipeDataCenter sharedData] recipeDataArray];
    
    for (NSDictionary *item in self.myRecipes) {
        NSInteger recipeID = [[item objectForKey:@"recipeID"] integerValue];
        
        for (HSRecipe *recipe in recipeDataArray) {
            if (recipe.recipeID == recipeID) {
                recipe.rating = [[item objectForKey:@"rating"] integerValue];
            }
        }
        
    }
    
}

- (NSArray *)sortedMyRecipes {
    NSArray *sortedArray = [self.myRecipes sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSNumber *first = [obj1 objectForKey:@"rating"];
        NSNumber *second = [obj2 objectForKey:@"rating"];
        return [second compare:first];
    }];
    
    return sortedArray;
}

- (NSArray *)favoriteDataArray {
    
    NSArray *originalArray = @[
                       @{@"drink":@"맥주",@"recipeIDs":[NSMutableArray new]},
                       @{@"drink":@"소주",@"recipeIDs":[NSMutableArray new]},
                       @{@"drink":@"양주",@"recipeIDs":[NSMutableArray new]},
                       @{@"drink":@"와인",@"recipeIDs":[NSMutableArray new]},
                       @{@"drink":@"막걸리",@"recipeIDs":[NSMutableArray new]},
                       @{@"drink":@"칵테일",@"recipeIDs":[NSMutableArray new]},
                       @{@"drink":@"소맥",@"recipeIDs":[NSMutableArray new]}
                       ];
    NSArray *recipeArray = [[HSRecipeDataCenter sharedData] recipeDataArray];
    NSMutableArray *mutableArray = [originalArray mutableCopy];
    for (NSNumber *pk in self.bookmarks) {
        HSRecipe *item = recipeArray[[pk integerValue]];
        [[mutableArray[item.drink] objectForKey:@"recipeIDs"] addObject:[NSNumber numberWithInteger:item.recipeID]];
    }
    
    for (NSInteger i = 6; i>=0; i--) {
        if ([[mutableArray[i] objectForKey:@"recipeIDs"] count] == 0) {
            [mutableArray removeObject:mutableArray[i]];
        }
    }

    
    return mutableArray;
    
}

- (BOOL)isThisMyRecipe:(NSInteger)recipeID {
    if ([self.bookmarks containsObject:[NSNumber numberWithInteger:recipeID]]) {
        return YES;
    } else {
        return NO;
    }
}

@end
