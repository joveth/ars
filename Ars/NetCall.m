//
//  NetCall.m
//  Ars
//
//  Created by Shuwei on 15/8/6.
//  Copyright (c) 2015年 jov. All rights reserved.
//

#import "NetCall.h"
#import "TFHpple.h"
#import "TFHppleElement.h"
#import "XPathQuery.h"

@implementation NetCall
+(void) queryTieWithPageNo:(NSInteger)pageno andCallBack:(CallBack)callback{
    
    NSString *URI_NEWS = @"http://tieba.baidu.com/f?kw=%E9%98%BF%E6%A3%AE%E7%BA%B3";
    NSData *htmlData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:URI_NEWS]];
    
    //NSData *toHtmlData = [self toUTF8:htmlData];
    
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:htmlData];
    NSArray *aArray = [xpathParser searchWithXPathQuery:@"//body"];
    
    if ([aArray count] > 0) {
        TFHppleElement *contentEle = [aArray objectAtIndex:0];
        NSLog(@"content%@",[contentEle content]);
        
        NSArray *contentArray = [contentEle searchWithXPathQuery:@"//div[@class='view-content']"];
        NSArray *pageArray = [contentEle searchWithXPathQuery:@"//li[@class='pager-last last']"];
        NSString *page = nil;
        if([pageArray count]>0){
            TFHppleElement *pageEle = [pageArray objectAtIndex:0];
            NSArray *last = [pageEle searchWithXPathQuery:@"//a"];
            if([last count]>0){
                TFHppleElement *lastEle = [last objectAtIndex:0];
                page =[[lastEle attributes] objectForKey:@"href"];
                NSInteger index =[page rangeOfString:@"="].location;
                if(index!=NSNotFound){
                    page = [page substringFromIndex:index];
                    NSLog(@"totalPage=%@",page);
                }
                
            }
            
        }
        
        if([contentArray count]>0){
            TFHppleElement *itemsEle = [contentArray objectAtIndex:0];
            NSArray *itemArray = [itemsEle searchWithXPathQuery:@"//li"];
            NSMutableArray *result = [[NSMutableArray alloc] init];
            for(int i=0;i<[itemArray count];i++){
                TFHppleElement *itemEle = [itemArray objectAtIndex:i];
//                NewsBean *bean = [[NewsBean alloc] init];
//                NSArray *image=[itemEle searchWithXPathQuery:@"//img"];
//                if([image count]==1){
//                    TFHppleElement *imageEle = [image objectAtIndex:0];
//                    bean.img =  [[imageEle attributes] objectForKey:@"src"];
//                    
//                }else{
//                    bean.img=nil;
//                }
//                NSArray *title=[itemEle searchWithXPathQuery:@"//div[@class='title']"];
//                if([title count]==0){
//                    continue;
//                }
//                TFHppleElement *titleEle = [title objectAtIndex:0];
//                
//                bean.title = [titleEle content];
//                NSArray *url=[titleEle searchWithXPathQuery:@"//a"];
//                if([url count]==0){
//                    continue;
//                }else{
//                    TFHppleElement *urlEle =[url objectAtIndex:0];
//                    bean.url =  [NSString stringWithFormat:@"http://edf.shmtu.edu.cn%@",[[urlEle attributes] objectForKey:@"href"]];
//                }
//                if(page){
//                    bean.totalPage = page;
//                }else{
//                    bean.totalPage=nil;
//                    
//                }
//                NSArray *date =[itemEle searchWithXPathQuery:@"//span"];
//                if([date count]>0){
//                    TFHppleElement *dateEle = [date objectAtIndex:0];
//                    bean.date = [dateEle content];
//                }
                
                //[result addObject:bean];
                
            }
            callback(result);
            return;
            
        }
    }
    callback(nil);
}

+(void) queryScoredWithWidth:(float)width andCallBack:(StringCallBack)callback{
    NSString *URI_NEWS = @"http://m.dongqiudi.com/status.html?competition=139&type=trank#";
    NSData *htmlData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:URI_NEWS]];
    
    //NSData *toHtmlData = [self toUTF8:htmlData];
    
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:htmlData];
    NSArray *aArray = [xpathParser searchWithXPathQuery:@"//div[@id='match-table']"];
    if ([aArray count] > 0) {
        TFHppleElement *contentEle = [aArray objectAtIndex:0];
        NSString *re =[contentEle content];
        NSLog(@"ret=%@",re);
        NSString *ret = [NSString stringWithFormat:@"<html><head><meta http-equiv='Content-Type' content='text/html; charset=utf-8'><meta name='viewport' content='width=%f, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no'> </head><body>%@</body></html>",width, [contentEle content]];
        NSLog(@"ret2=%@",ret);
        callback(ret);
        return;
    }
    callback(nil);
}
@end
