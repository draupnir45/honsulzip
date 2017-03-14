//
//  JCDataCenter.h
//  PlistPrac
//
//  Created by 박종찬 on 2017. 3. 3..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSUserDataController : NSObject


@property NSMutableDictionary *appData;


///저장된 데이터를 가진 싱글톤 클래스 객체를 반환합니다.
+ (instancetype)sharedData;

///데이터를 저장합니다.
- (void)saveData;



@end
