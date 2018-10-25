//
//  AnyModel.h
//  SHMDatabase
//
//  Created by teason23 on 2018/10/25.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "AccessObj.h"
#import "Father.h"
#import "SomeInfo.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnyModel : Father
@property (nonatomic) int       age;
@property (nonatomic) float     floatVal;
@property (nonatomic) long long tick;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * abcabc;
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, copy) NSArray<SomeInfo *> *myArr; // Array<SomeInfo>
@property (nonatomic, copy) NSDictionary *myDic; // Dict <NSString,AccessObj> 不可变, 都可以
@property (strong, nonatomic) NSDate *  today;
@property (strong, nonatomic) SomeInfo *sInfo; // 什么都不用做

// 更新数据库
//@property (nonatomic,copy)      NSString *lztmjyxjzdzmy ; //

+ (instancetype)customRandomModel;

@end

NS_ASSUME_NONNULL_END
