//
//  MessageViewController.m
//  Ars
//
//  Created by Shuwei on 15/9/24.
//  Copyright © 2015年 jov. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController{
    UITextView *msg;
    MBProgressHUD *hud;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:hud];
    hud.labelText = @"发送中...";
    self.title=@"给我留言吧";
    NSString *text = @"如果你对我有什么话想说，或者不满，或者意见，或者建议，或者你认为我该怎么怎么样，等，请写下你的话，发给我，当然如果你希望我回复你，请留下联系方式，不然，这只是一个单项通信的功能啦。";
    CGSize size=[text sizeWithAttributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:14] forKey:NSFontAttributeName]];
    CGFloat width = [UIScreen mainScreen].applicationFrame.size.width-16;
    CGFloat line = size.width/width;
    line = [self clcLine:line];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 66, self.view.frame.size.width-16, line*size.height)];
    label.textColor=FlatBlack;
    label.numberOfLines=0;
    label.lineBreakMode=NSLineBreakByWordWrapping;
    label.text=text;
    label.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    UILabel *ln = [[UILabel alloc] initWithFrame:CGRectMake(0, line*size.height+74, self.view.frame.size.width, 1)];
    ln.backgroundColor=FlatGray;
    [self.view addSubview:ln];
    msg = [[UITextView alloc] initWithFrame:CGRectMake(8, line*size.height+76, self.view.frame.size.width-16, 120)];
    msg.delegate=self;
    msg.returnKeyType=UIReturnKeyDone;
    [self.view addSubview:msg];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, line*size.height+206, self.view.frame.size.width, 44)];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:FlatWhite forState:UIControlStateNormal];
    btn.backgroundColor=FlatRed;
    [btn addTarget:self action:@selector(sendBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}
-(IBAction)sendBtn:(id)sender{
    if([Common isEmptyString:msg.text]){
        return;
    }else{
        [msg resignFirstResponder];
        [hud show:YES];
        [self sendMsg];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)clcLine:(CGFloat)width{
    if(width<1){
        width=1;
    }else{
        NSString *th = [NSString stringWithFormat:@"%0.0f",width];
        NSInteger t = th.integerValue;
        if(width-t>0){
            width  = t+1;
        }else{
            width = t;
        }
    }
    return width;
}
-(void)sendMsg{
    SKPSMTPMessage *testMsg = [[SKPSMTPMessage alloc] init];
    testMsg.fromEmail = @"funny_ba@163.com";
    testMsg.toEmail = @"funny_ba@163.com";
    testMsg.bccEmail = @"funny_ba@163.com";
    testMsg.relayHost = @"smtp.163.com";
    
    testMsg.requiresAuth = YES;
    
    if (testMsg.requiresAuth) {
        testMsg.login = @"funny_ba@163.com";
        testMsg.pass = @"funny_ba@163";
    }
    testMsg.wantsSecure = YES;
    testMsg.subject = @"IOS Arsenal Mail ";
    testMsg.delegate = self;
    NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
                               [NSString stringWithCString:[msg.text UTF8String] encoding:NSUTF8StringEncoding],kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    testMsg.parts = [NSArray arrayWithObjects:plainPart,nil];
    [testMsg send];
}
-(void)messageSent:(SKPSMTPMessage *)message{
    NSLog(@"%@",message);
    [hud hide:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error{
    NSLog(@"%@,err:%@",message,error);
    [hud hide:YES];
    [Common showMessageWithOkButton:@"亲，发送失败了，怎么办？"];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        if([Common isEmptyString:msg.text]){
            return YES;
        }else{
            [msg resignFirstResponder];
            [hud show:YES];
            [self sendMsg];
        }
        return NO;
    }
    return YES;
}

@end
