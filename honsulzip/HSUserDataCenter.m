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
    NSString *docuPath = [(NSString *)([paths objectAtIndex:0]) stringByAppendingString:@"/userData.plist"];
    
    return docuPath;
}

- (void)addBookmarkWithRecipeID:(NSInteger)recipeID {
    [self.bookmarks addObject:[NSNumber numberWithInteger:recipeID]];
    [self saveData];
}

- (void)removeBookmarkWithRecipeID:(NSInteger)recipeID {
    [self.bookmarks removeObject:[NSNumber numberWithInteger:recipeID]];
    [self saveData];
}

- (void)setStarRatingWithRecipeID:(NSInteger)recipeID rating:(NSInteger)rating {
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

@end
