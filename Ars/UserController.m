//
//  UserController.m
//  Ars
//
//  Created by Shuwei on 15/8/13.
//  Copyright (c) 2015年 jov. All rights reserved.
//

#import "UserController.h"
#import "Common.h"
#import "SKPSMTPMessage.h"
#import "SVProgressHUD.h"

@interface UserController ()
@property (weak, nonatomic) IBOutlet UITextView *msgText;

@end

@implementation UserController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor=[Common colorWithHexString:@"#e0e0e0"];
    self.tableView.tableFooterView=[[UIView alloc] init];
    self.msgText.delegate = self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)showSV{
    dispatch_async(dispatch_get_main_queue(),^ {
        [SVProgressHUD show];
    });
}
//secltion head
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *myHeader = [[UIView alloc] init];
    UILabel *myLabel = [[UILabel alloc] init];
    [myLabel setFrame:CGRectMake(8, 5, 200, 20)];
    [myLabel setTag:101];
    [myLabel setAlpha:0.5];
    [myLabel setFont: [UIFont fontWithName:@"Arial" size:14]];
    [myLabel setBackgroundColor:[UIColor clearColor]];
    [myHeader setBackgroundColor:[Common colorWithHexString:@"#e0e0e0"]];
    
    switch (section) {
        case 1:
            [myLabel setText:[NSString stringWithFormat:@"软件声明"]];
            break;
        case 2:
            [myLabel setText:[NSString stringWithFormat:@"应用标识"]];
            break;
        default:
            [myLabel setText:[NSString stringWithFormat:@" "]];
            break;
    }
    [myHeader addSubview:myLabel];
    return myHeader;
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
                               [NSString stringWithCString:[_msgText.text UTF8String] encoding:NSUTF8StringEncoding],kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    testMsg.parts = [NSArray arrayWithObjects:plainPart,nil];
    [testMsg send];
}
-(void)messageSent:(SKPSMTPMessage *)message{
    NSLog(@"%@",message);
    [SVProgressHUD showSuccessWithStatus:@"感谢您的留言!" ];
    
}
-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error{
    NSLog(@"%@,err:%@",message,error);
    [SVProgressHUD showErrorWithStatus:@"亲，发送失败了!"];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        if([Common isEmptyString:_msgText.text]){
            return YES;
        }else{
            [_msgText resignFirstResponder];
            [self showSV];
            [self sendMsg];
        }
        return NO;
    }
    return YES;
}
@end
