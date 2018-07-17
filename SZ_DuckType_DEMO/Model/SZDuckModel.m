//
//  SZDuckModel.m
//  SZ_DuckType_DEMO
//
//  Created by 山竹 on 2018/7/12.
//  Copyright © 2018年 shanzhu. All rights reserved.
//

#import "SZDuckModel.h"

@interface SZDuckModel : NSProxy<SZDuckModelProtocol>

@property (nonatomic, strong) NSMutableDictionary *innerDictionary;

@end

@implementation SZDuckModel

@synthesize jsonString = _jsonString;

- (instancetype)initWithJSONString:(NSString *)json
{
    if (json) {
        
        self -> _jsonString = [json copy];
        
        NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
        
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            
            self.innerDictionary = [jsonObject mutableCopy];
        }
        
        return self;
    }
    
    return nil;
}

#pragma mark - Message Forwading

/*
 属性的getter和setter，这正对应了NSMutableDictionary的objectForKey:和setObjectForKey:，同时，JSON数据也会解析成字典，这就完成了巧妙的对接
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    // 变成 NSMutableDictionary 的 方法签名
    // getter -> objectForKey:
    // setter -> setObject:forKey:
    
    SEL changedSel = sel;
    
    if ([self propertyNameScanFromGetterSelector:sel]) {
        
        changedSel = @selector(objectForKey:);
        
    } else if ([self propertyNameScanFromSetterSelector:sel]) {
        
        changedSel = @selector(setObject:forKey:);
    }
    
    return [[self.innerDictionary class] instanceMethodSignatureForSelector:changedSel];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    NSString *propertyName = nil;
    
    // 尝试 getter
    propertyName = [self propertyNameScanFromGetterSelector:invocation.selector];
    if (propertyName) {
        invocation.selector = @selector(objectForKey:);
        [invocation setArgument:&propertyName atIndex:2]; // self, _cmd, key
        [invocation invokeWithTarget:self.innerDictionary];
        return;
    }
    
    // 尝试 setter
    propertyName = [self propertyNameScanFromSetterSelector:invocation.selector];
    
    if (propertyName) {
        
        invocation.selector = @selector(setObject:forKey:);
        
        [invocation setArgument:&propertyName atIndex:3]; // self, _cmd, obj, key
        
        [invocation invokeWithTarget:self.innerDictionary];
        
        return;
    }
    
    [super forwardInvocation:invocation];
}

#pragma mark - private method

- (NSString *)propertyNameScanFromGetterSelector:(SEL)selector
{
    NSString *selectorName = NSStringFromSelector(selector);
    
    NSUInteger parameterCount = [[selectorName componentsSeparatedByString:@":"] count] - 1;
    
    if (parameterCount == 0) {
        
        return selectorName;
    }
    
    return nil;
}

- (NSString *)propertyNameScanFromSetterSelector:(SEL)selector
{
    NSString *selectorName = NSStringFromSelector(selector);
    
    NSUInteger parameterCount = [[selectorName componentsSeparatedByString:@":"] count] - 1;
    
    if ([selectorName hasPrefix:@"set"] && parameterCount == 1) {
        
        NSUInteger firstColonLocation = [selectorName rangeOfString:@":"].location;
        
        // 将set方法中的 首字母 大写 改成小写，再拼接剩下的
        NSString *firstLetter = [selectorName substringWithRange:NSMakeRange(3, 1)].lowercaseString;
        
        return [NSString stringWithFormat:@"%@%@", firstLetter, [selectorName substringWithRange:NSMakeRange(4, firstColonLocation - 4)]];
    }
    
    return nil;
}

@end

id SZDuckModelCreateWithJSON(NSString *json)
{
    return [[SZDuckModel alloc] initWithJSONString:json];
}
