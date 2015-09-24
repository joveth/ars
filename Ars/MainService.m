//
//  MainService.m
//  FirstDemo
//
//  Created by jov jov on 6/6/15.
//  Copyright (c) 2015 jov jov. All rights reserved.
//

#import "MainService.h"
#import "ShareData.h"

@implementation MainService

+(void) getImagesWithPageNo:(NSInteger )pageno andSuccess:(CallBackMutable)callback andError:(ErrorCallBack)err{
    
    NSURL *baseURL = [NSURL URLWithString:@"http://image.baidu.com"];
    NSString *key =@"%E5%8E%84%E9%BD%90%E5%B0%94";
    NSString *path=[NSString stringWithFormat:@"/i?tn=baiduimagejson&ie=utf-8&width=&height=&word=%@&rn=25&pn=%ld",key,pageno] ;
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    [client setDefaultHeader:@"Accept" value:@"text/javascript"];
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    client.allowsInvalidSSLCertificate=YES;
    [client postPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *ret = (NSDictionary *)responseObject;
        NSArray *data = [ret objectForKey:@"data"];
        NSMutableArray *urls = [[NSMutableArray alloc] init];
        if(data&&[data count]>0){
            for(int i=0;i<[data count];i++){
                NSDictionary *obj = [data objectAtIndex:i];
                NSString *url = [obj objectForKey:@"objURL"];
                if(url){
                    [urls addObject:url];
                }
            }
        }
        if(callback){
            callback(urls);
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(err){
            NSInteger code = operation.response.statusCode;
            err(code);
        }
    }];
}
+(void) getCartoonWithPageNo:(NSInteger )pageno andSuccess:(CallBackMutable)callback andError:(ErrorCallBack)err{
    
    NSURL *baseURL = [NSURL URLWithString:@"http://image.baidu.com"];
    NSString *key =@"%E5%8E%84%E9%BD%90%E5%B0%94%E5%8D%A1%E9%80%9A";
    NSString *path=[NSString stringWithFormat:@"/i?tn=baiduimagejson&ie=utf-8&width=&height=&word=%@&rn=25&pn=%ld",key,pageno] ;
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    [client setDefaultHeader:@"Accept" value:@"text/javascript"];
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    client.allowsInvalidSSLCertificate=YES;
    [client postPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *ret = (NSDictionary *)responseObject;
        NSArray *data = [ret objectForKey:@"data"];
        NSMutableArray *urls = [[NSMutableArray alloc] init];
        if(data&&[data count]>0){
            for(int i=0;i<[data count];i++){
                NSDictionary *obj = [data objectAtIndex:i];
                NSString *url = [obj objectForKey:@"objURL"];
                if(url){
                    [urls addObject:url];
                }
            }
        }
        if(callback){
            callback(urls);
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(err){
            NSInteger code = operation.response.statusCode;
            err(code);
        }
    }];
}
+(void) getTwitter:(NSInteger )pageno andSuccess:(CallBackMutable)callback andError:(ErrorCallBack)err{
    @try {
        NSString *URI_NEWS = @"https://isaac.herokuapp.com/m/getwitter";
        NSData *htmlData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:URI_NEWS]];
        IGHTMLDocument* node = [[IGHTMLDocument alloc] initWithHTMLData:htmlData encoding:nil error:nil];
        NSMutableArray *ret = [[NSMutableArray alloc] init];
        NSArray *arr =[[node queryWithCSS:@".content"]  allObjects];
        if(arr&&[arr count]>0){
            for(int i=0;i<[arr count];i++){
                IGXMLNode *node = [arr objectAtIndex:i];
                NSString *time =[NSString stringWithFormat:@" • %@",[[[node queryWithCSS:@"._timestamp"] firstObject ] text]];
                NSString *temp = [[[node queryWithCSS:@".TweetTextSize"] firstObject ] text];
                TwitterBean *bean = [TwitterBean new];
                temp =[temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                temp = [temp stringByAppendingString:time];
                bean.content=temp;
                IGXMLNode *im =[[node queryWithCSS:@".is-preview"] firstObject];
                if(im){
                    NSString *image = [im attribute:@"data-url"];
                    if(image){
                        image = [self findName:image];
                        NSInteger index =[image rangeOfString:@":"].location;
                        if(index!=NSNotFound){
                            image = [image substringToIndex:index];
                            NSLog(@"image=%@",image);
                        }
                        bean.image=image;
                    }
                }
                [ret addObject:bean];
            }
        }
        if(callback){
            callback(ret);
        }
    }
    @catch (NSException *exception) {
        if(err){
            err(404);
        }
    }
    @finally {
        
    }
}
+(NSString *)findName:(NSString *)name{
    NSRange range = [name rangeOfString:@"/"];
    if (range.location != NSNotFound) {
        return [self findName:[name substringFromIndex:range.location+1]];
    }
    return name;
}
@end
