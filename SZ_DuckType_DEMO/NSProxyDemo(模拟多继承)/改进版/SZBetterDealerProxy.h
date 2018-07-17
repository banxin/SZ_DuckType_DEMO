//
//  SZBetterDealerProxy.h
//  SZ_DuckType_DEMO
//
//  Created by 山竹 on 2018/7/17.
//  Copyright © 2018年 shanzhu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SZBookProvider.h"
#import "SZClothesPrivider.h"

// 该处 写上 <SZBookProviderProtocol, SZClothesPrividerProtocol> 只是骗过编译器，实际的方法调用，走的是消息转发
@interface SZBetterDealerProxy : NSProxy<SZBookProviderProtocol, SZClothesPrividerProtocol>

+ (id)betterDealerProxy;

@end
