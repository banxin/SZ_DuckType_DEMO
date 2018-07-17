//
//  SZBookProvider.h
//  SZ_DuckType_DEMO
//
//  Created by 山竹 on 2018/7/17.
//  Copyright © 2018年 shanzhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SZBookProviderProtocol<NSObject>

- (void)buyBookWithName:(NSString *)bookName;

@end

@interface SZBookProvider : NSObject

@end
