//
//  SZDIProxy.m
//  SZ_DuckType_DEMO
//
//  Created by 山竹 on 2018/7/13.
//  Copyright © 2018年 shanzhu. All rights reserved.
//

#import "SZDIProxy.h"

#import <objc/runtime.h>

@interface SZDIProxy : NSProxy<SZDIProxyProtocol>

@property (nonatomic, strong) NSMutableDictionary *implementations;

- (id)init;

@end

@implementation SZDIProxy

- (id)init
{
    self.implementations = [NSMutableDictionary dictionary];
    
    return self;
}

- (void)injectDependencyObject:(id)object forProtocol:(Protocol *)protocol
{
    NSParameterAssert(object && protocol);
    
    NSAssert([object conformsToProtocol:protocol], @"对象 -> : %@ 无法实现 协议 -> : %@", object, protocol);
    
    self.implementations[NSStringFromProtocol(protocol)] = object;
}

- (NSMethodSignature *)injectedMethodSignatureForSelector:(SEL)sel
{
    return [self methodSignatureForSelector:sel];
}

#pragma mark - private method

- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    for (NSString *protocolName in self.implementations.allKeys) {
        
        if (protocol_isEqual(aProtocol, NSProtocolFromString(protocolName))) {
            
            return YES;
        }
    }
    
    return [super conformsToProtocol:aProtocol];
}

#pragma mark - Message forwarding

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    for (id object in self.implementations.allValues) {
        
        if ([object respondsToSelector:sel]) {
            
            return [object methodSignatureForSelector:sel];
        }
    }
    
    return [super methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    for (id object in self.implementations.allValues) {
        
        if ([object respondsToSelector:invocation.selector]) {
            
            [invocation invokeWithTarget:object];
            
            return;
        }
    }
    
    [super forwardInvocation:invocation];
}

@end

id SZCreateDIProxy()
{
    return [[SZDIProxy alloc] init];
}
