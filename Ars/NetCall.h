//
//  NetCall.h
//  Ars
//
//  Created by Shuwei on 15/8/6.
//  Copyright (c) 2015年 jov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetCall : NSObject
typedef void (^CallBack)(NSMutableArray *_ret);
typedef void (^ErrorCallBack)(NSInteger code);
typedef void (^StringCallBack)(NSString *_ret);

+(void) queryTieWithPageNo:(NSInteger)pageno andCallBack:(CallBack)callback;

@end
