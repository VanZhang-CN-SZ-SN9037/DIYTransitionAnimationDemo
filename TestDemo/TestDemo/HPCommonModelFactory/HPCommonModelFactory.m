//
//  HPCommonModelFactory.m
//  HPCommonUI
//
//  Created by VanZhang on 2020/11/27.
//  Copyright © 2020 NebulaSky. All rights reserved.
//

#import "HPCommonModelFactory.h"

@implementation HPCommonModelFactory
+ (HPDelegate*)delegate{
    return [HPDelegate sharedInstance];
}
+ (HPDataSource*)datasource{
    return [HPDataSource sharedInstance];
}

 


//===============Instance====================//
//+ (instancetype)sharedInstance{
//    return [[self alloc]init];
//}
//===============SingleTon====================//
static id _instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
    });
    return _instance;
}
- (id)copyWithZone:(NSZone *)zone{
    return _instance;
}
- (id)mutableCopy{
    return _instance;
}
- (id)copy{
    return _instance;
}
+ (instancetype)sharedInstance{
    return [[self alloc]init];
}
//===================================//
//===================================//
@end
