//
//  SZBookProvider.m
//  SZ_DuckType_DEMO
//
//  Created by 山竹 on 2018/7/17.
//  Copyright © 2018年 shanzhu. All rights reserved.
//

#import "SZBookProvider.h"

@interface SZBookProvider ()<SZBookProviderProtocol>

@end

@implementation SZBookProvider

- (void)buyBookWithName:(NSString *)bookName
{
    NSLog(@"已经买好了书：%@", bookName);
}

@end
