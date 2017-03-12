//
//  JCPlistDataController.m
//  PlistPrac
//
//  Created by 박종찬 on 2017. 3. 3..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "HSUserDataController.h"

@interface HSUserDataController ()

@property NSFileManager *fileManager;
@property NSString *documentDirPath;

@end


@implementation HSUserDataController


+ (instancetype)sharedData {
    static HSUserDataController *sharedData = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedData = [[HSUserDataController alloc] init];
    });
    
    return sharedData;
}




- (instancetype)init
{
    self = [super init];
    if (self) {

        self.documentDirPath = [HSUserDataController documentDiretoryPath];
        NSArray *favorite = @[];
        NSArray *myRecipes = @[];
        self.appData = [@{@"favorite" : favorite, @"myRecipes" : myRecipes} mutableCopy];
        
        self.fileManager = [NSFileManager defaultManager];
        
        if ([self.fileManager fileExistsAtPath:self.documentDirPath]) {
            //저장했던 내용 로드
            self.appData = [[NSDictionary dictionaryWithContentsOfFile:self.documentDirPath] mutableCopy];
        } else  {
            
            NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"HSUserData" ofType:@"plist"];
            //데이터용 프로퍼티에 번들 내용을 넣음
            self.appData = [[NSDictionary dictionaryWithContentsOfFile:bundlePath] mutableCopy];

        }
        
    }
    return self;
}

- (void)saveData {

    
    if (![self.fileManager fileExistsAtPath:self.documentDirPath]) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"HSUserData" ofType:@"plist"];
        [self.fileManager copyItemAtPath:bundlePath toPath:self.documentDirPath error:nil];
    }
    
    [self.appData writeToFile:self.documentDirPath atomically:NO];
    
}


+ (NSString *)documentDiretoryPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docuPath = [(NSString *)([paths objectAtIndex:0]) stringByAppendingString:@"/userData.plist"];
    
    return docuPath;
}


@end
