//
//  MainService.h
//  FirstDemo
//
//  Created by jov jov on 6/6/15.
//  Copyright (c) 2015 jov jov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFHpple.h"
#import "TFHppleElement.h"
#import "XPathQuery.h"
#import "IGHTMLQuery.h"
#import "RestKit.h"

@interface MainService : NSObject
typedef void (^CallBack)(NSArray *result);
typedef void (^CallBackMutable)(NSMutableArray *result);
typedef void (^CallBackString)(NSString *result);
typedef void (^ErrorCallBack)(NSInteger code);
typedef void (^CallBackMutAndPage)(NSMutableArray *result,NSInteger total);
+(void) getImagesWithPageNo:(NSInteger )pageno andSuccess:(CallBackMutable)callback andError:(ErrorCallBack)err;
+(void) getCartoonWithPageNo:(NSInteger )pageno andSuccess:(CallBackMutable)callback andError:(ErrorCallBack)err;
+(void) getTwitter:(NSInteger )pageno andSuccess:(CallBackMutable)callback andError:(ErrorCallBack)err;


@end
