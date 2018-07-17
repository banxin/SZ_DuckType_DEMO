//
//  SZPersonProtocol.h
//  SZ_DuckType_DEMO
//
//  Created by 山竹 on 2018/7/12.
//  Copyright © 2018年 shanzhu. All rights reserved.
//

@protocol SZPersonProtocol<NSObject>

@property (nonatomic, copy)   NSString *name;
@property (nonatomic, strong) NSNumber *age;

@end

@protocol SZEmployeeProtocol<SZPersonProtocol>

@property (nonatomic, copy) NSString *departName;

@end
