//
//  ViewController.m
//  Calltelephone&SendMessage&SendEmail
//
//  Created by 黄海燕 on 14/5/18.
//  Copyright © 2016年 AnBang. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MFMessageComposeViewController.h>
#import <MessageUI/MFMailComposeViewController.h>
@interface ViewController ()<MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>
@property (nonatomic,strong) UIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (IBAction)callTelephone:(id)sender {
//    //点击手机号直接跳到拨打界面
//    NSString *telNum = @"18749627117";
//    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel://%@",telNum];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
    /*
     *先弹出一个选择视图，选择呼叫再跳到拨打界面
     */
    if (_webView == nil) {
        _webView = [[UIWebView alloc]init];
    }
    
    NSURL *url = [NSURL URLWithString:@"tel://18749627117"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

- (IBAction)sendMessage:(id)sender {
    // 判断用户设备能否发送短信
    if (![MFMessageComposeViewController canSendText]) {
        return;
    }
    // 1. 实例化一个控制器
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    
    // 2. 设置短信内容
    // 1) 收件人
    controller.recipients = @[@"18749627117"];
    
    // 2) 短信内容
    controller.body = @"你好，很高兴遇到你！";
    
    // 3) 设置代理
    controller.messageComposeDelegate = self;
    
    // 3. 显示短信控制器
    [self presentViewController:controller animated:YES completion:nil];
    
}

- (IBAction)sendEmail:(id)sender {
    
    // 1. 先判断能否发送邮件
    if (![MFMailComposeViewController canSendMail]) {
        // 提示用户设置邮箱
        return;
    }
    
    // 2. 实例化邮件控制器，准备发送邮件
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    
    // 1) 主题
    [controller setSubject:@"你好"];
    // 2) 收件人
    [controller setToRecipients:@[@"1531398577@qq.com",@"huanghaiyanios@163.com"]];
    
    // 3) cc 抄送
    // 4) bcc 密送(偷偷地告诉，打个小报告)
    // 5) 正文
    [controller setMessageBody:@"这是我的<font color=\"blue\">工作报告</font>，请审阅！<BR />P.S. 我的头像牛X吗？" isHTML:YES];
    
    // 6) 附件
    UIImage *image = [UIImage imageNamed:@"1.jpg"];
    NSData *imageData = UIImagePNGRepresentation(image);
    // 1> 附件的二进制数据
    // 2> MIMEType 使用什么应用程序打开附件
    // 3> 收件人接收时看到的文件名称
    // 可以添加多个附件
    [controller addAttachmentData:imageData mimeType:@"image/png" fileName:@"1.jpg"];
    
    // 7) 设置代理
    [controller setMailComposeDelegate:self];
    
    // 显示控制器
    [self presentViewController:controller animated:YES completion:nil];
}


#pragma mark 短信控制器代理方法
/**
 短信发送结果
 
 MessageComposeResultCancelled,     取消发送
 MessageComposeResultSent,          发送成功
 MessageComposeResultFailed         发送失败
 */
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    NSLog(@"%d", result);
    
    //退出发送短信页面
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 邮件代理方法
/**
 MFMailComposeResultCancelled,      取消
 MFMailComposeResultSaved,          保存邮件
 MFMailComposeResultSent,           已经发送
 MFMailComposeResultFailed          发送失败
 */
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    // 根据不同状态提示用户
    NSLog(@"%d", result);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
