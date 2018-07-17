//
//  SZDuckModel.h
//  SZ_DuckType_DEMO
//
//  Created by 山竹 on 2018/7/12.
//  Copyright © 2018年 shanzhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SZDuckModelProtocol <NSObject>

@property (nonatomic, copy, readonly) NSString *jsonString;

@end

extern id SZDuckModelCreateWithJSON(NSString *json);
