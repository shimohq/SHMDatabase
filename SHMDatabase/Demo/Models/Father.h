//
//  Father.h
//  SHMDatabase
//
//  Created by teason23 on 2018/10/25.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SomeInfo;
NS_ASSUME_NONNULL_BEGIN

@interface Father : NSObject
@property (copy, nonatomic) NSString *           fatherName;
@property (copy, nonatomic) NSArray<SomeInfo *> *fatherList;

+ (instancetype)randomAFather;

@end

NS_ASSUME_NONNULL_END
