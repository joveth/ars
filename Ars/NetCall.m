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
    
    NSString *URI_NEWS = [NSString stringWithFormat:@"%@?page=%ld", @"http://edf.shmtu.edu.cn/news.htm",(long)pageno];
    NSData *htmlData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:URI_NEWS]];
    
    //NSData *toHtmlData = [self toUTF8:htmlData];
    
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:htmlData];
    NSArray *aArray = [xpathParser searchWithXPathQuery:@"//div[@id='block-system-main']"];
    
    if ([aArray count] > 0) {
        TFHppleElement *contentEle = [aArray objectAtIndex:0];
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
@end
