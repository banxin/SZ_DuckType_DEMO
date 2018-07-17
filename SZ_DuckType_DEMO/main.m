//
//  main.m
//  SZ_DuckType_DEMO
//
//  Created by 山竹 on 2018/7/12.
//  Copyright © 2018年 shanzhu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SZPersonProtocol.h"
#import "SZDuckModel.h"
#import "SZDIProxy.h"
#import "SZDITestA.h"
#import "SZDITestB.h"

#import "SZBookProvider.h"
#import "SZClothesPrivider.h"
#import "SZDealerProxy.h"

#import "SZBetterDealerProxy.h"

/*
 来源：
 
 https://www.jianshu.com/p/8e700673202b
 http://blog.sunnyxx.com/2014/08/26/objc-duck-advanced/
 */

void testDuckModel() {
    
    NSString *json = @"{\"name\": \"xxxname\", \"age\": 18, \"departName\": \"dev\"}";
    
    // 所有的model都可以使用@protocol而非子类化的方式来定义
    id<SZEmployeeProtocol, SZDuckModelProtocol> model = SZDuckModelCreateWithJSON(json);
    
    NSLog(@"%@, %@, %@, %@", model.jsonString, model.name, model.age, model.departName);
    
    model.name       = @"xxxname 2";
    model.age        = @30;
    model.departName = @"test";
    
    NSLog(@"%@, %@, %@", model.name, model.age, model.departName);
}

void testDI() {
    
    id<SZDITestProtocol, SZDIProxyProtocol> proxy = SZCreateDIProxy();
    
    SZDITestA *testA = [SZDITestA new];

    [proxy injectDependencyObject:testA forProtocol:@protocol(SZDITestProtocol)];
    
    [testA doTest];
    
    SZDITestB *testB = [SZDITestB new];
    
    [proxy injectDependencyObject:testB forProtocol:@protocol(SZDITestProtocolB)];
    
    [testB doTestB];
}

void testProxyDemo () {
    
    // 初始版
//    SZDealerProxy *dealerProxy = [SZDealerProxy dealerProxy];
//
//    [dealerProxy buyBookWithName:@"a book"];
//    [dealerProxy buyClothWithName:@"b cloth"];
    
    // 改进版
    SZBetterDealerProxy *betterDealerProxy = [SZBetterDealerProxy betterDealerProxy];
    
    [betterDealerProxy buyBookWithName:@"a book"];
    [betterDealerProxy buyClothWithName:@"b cloth"];
}

int main(int argc, const char * argv[]) {
    
    @autoreleasepool {
        
        testDuckModel();
    
        testDI();
        
        testProxyDemo();
    }
    
    return 0;
}
