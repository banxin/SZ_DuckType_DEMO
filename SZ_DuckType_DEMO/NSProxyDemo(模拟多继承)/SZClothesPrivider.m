//
//  SZClothesPrivider.m
//  SZ_DuckType_DEMO
//
//  Created by 山竹 on 2018/7/17.
//  Copyright © 2018年 shanzhu. All rights reserved.
//

#import "SZClothesPrivider.h"

@interface SZClothesPrivider ()<SZClothesPrividerProtocol>

@end

@implementation SZClothesPrivider

- (void)buyClothWithName:(NSString *)name
{
    NSLog(@"已经买好了衣服：%@", name);
}

@end
