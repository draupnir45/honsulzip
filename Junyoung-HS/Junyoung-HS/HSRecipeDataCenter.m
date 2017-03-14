//
//  JCPlistDataController.m
//  PlistPrac
//
//  Created by 박종찬 on 2017. 3. 3..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "HSRecipeDataCenter.h"

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
        
        self.appData = [NSArray arrayWithContentsOfFile:bundlePath];

        
    }
    return self;
}

- (void)saveData {

    
    if (![self.fileManager fileExistsAtPath:self.documentDirPath]) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"appData" ofType:@"plist"];
        [self.fileManager copyItemAtPath:bundlePath toPath:self.documentDirPath error:nil];
    }
    
    [self.appData writeToFile:self.documentDirPath atomically:NO];
    
}



- (void)addAppDataObject:(NSDictionary *)object {
    
    id mutableCopy = [self.appData mutableCopy];
    
    [mutableCopy addObject:object];
    
    self.appData = mutableCopy;
    
    [self saveData];
}

- (void)removeAppDataObject:(NSDictionary *)object {
    
    id mutableCopy = [self.appData mutableCopy];
    
    [mutableCopy removeObject:object];
    
    self.appData = mutableCopy;
    
    [self saveData];
}

@end
