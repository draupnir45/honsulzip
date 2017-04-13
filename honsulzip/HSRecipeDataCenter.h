//
//  JCDataCenter.h
//  PlistPrac
//
//  Created by 박종찬 on 2017. 3. 3..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSRecipeDataCenter : NSObject

@property NSFileManager *fileManager;
@property NSString *documentDirPath;
@property NSArray *recipeDataArray;


///저장된 데이터를 가진 싱글톤 클래스 객체를 반환합니다.
+ (instancetype)sharedData;



@end
