//
//  SZBetterDealerProxy.m
//  SZ_DuckType_DEMO
//
//  Created by 山竹 on 2018/7/17.
//  Copyright © 2018年 shanzhu. All rights reserved.
//

#import "SZBetterDealerProxy.h"

#import "SZDIProxy.h"

@interface SZBetterDealerProxy ()
{
    id<SZBookProviderProtocol, SZClothesPrividerProtocol, SZDIProxyProtocol> _proxy;
}

@end

@implementation SZBetterDealerProxy

#pragma mark - class method

+ (id)betterDealerProxy
{
    return [[SZBetterDealerProxy alloc] init];    
}

#pragma mark - init

- (instancetype)init
{
    _proxy = SZCreateDIProxy();
    
    SZBookProvider    *bookProvider  = [SZBookProvider new];
    SZClothesPrivider *clothProvider = [SZClothesPrivider new];
    
    [_proxy injectDependencyObject:bookProvider forProtocol:@protocol(SZBookProviderProtocol)];
    [_proxy injectDependencyObject:clothProvider forProtocol:@protocol(SZClothesPrividerProtocol)];
    
    return self;
}

#pragma mark - Message Forward

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [_proxy injectedMethodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    return [invocation invokeWithTarget:_proxy];
}

@end
