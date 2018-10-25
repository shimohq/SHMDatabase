//
//  Father.m
//  SHMDatabase
//
//  Created by teason23 on 2018/10/25.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "Father.h"
#import "SomeInfo.h"

@implementation Father

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"fatherList" : [SomeInfo class],
             };
}

+ (instancetype)randomAFather {
    int randomNum = arc4random() % 100;
    ;
    
    Father *f    = [Father new];
    f.fatherName = [NSString stringWithFormat:@"fffatherff%d", randomNum];
    
    SomeInfo *info = [SomeInfo new];
    info.infoStr   = [@(randomNum) stringValue];
    info.infoID    = randomNum;
    f.fatherList   = @[ info ];
    
    return f;
}
@end
