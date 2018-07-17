//
//  SZDIProxy.h
//  SZ_DuckType_DEMO
//
//  Created by 山竹 on 2018/7/13.
//  Copyright © 2018年 shanzhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SZDIProxyProtocol<NSObject>

// 注入class
- (void)injectDependencyObject:(id)object forProtocol:(Protocol *)protocol;

// 已经注入的类 可以响应 方法的签名 (需要做包装的时候使用，比如 SZBetterDealerProxy 类)
- (NSMethodSignature *)injectedMethodSignatureForSelector:(SEL)sel;

@end

// 使用 C 函数，隐藏类名
extern id SZCreateDIProxy(void);
