//
//  ContentViewController.m
//  Test3DTouchViews
//
//  Created by 王士良 on 2017/11/27.
//  Copyright © 2017年 wsliang. All rights reserved.
//

#import "ContentViewController.h"

static NSString *savedText;
@interface ContentViewController ()
@property (nonatomic) UIAlertController *alertC;

@property (nonatomic ,weak) IBOutlet UILabel *textDesc;

@end



@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (savedText) {
        self.title = savedText;
        self.textDesc.text = savedText;
    }

    if (self.testColor) {
        self.view.backgroundColor = self.testColor;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)actionBackLastView:(UIButton*)sender
{
    if (self.navigationController && self.navigationController.viewControllers.count>1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        if(self.presentingViewController){
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    NSLog(@"use default method");
}


    // 设置预览视图向上滑动时出现的视图
- (NSArray *)previewActionItems {

    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"Action 1" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction *action, UIViewController *previewViewController) {
            // 点击此选项触发
        NSLog(@"选项1 事件处理");
        savedText = action.title;
        self.textDesc.text = savedText;
        self.alertC = [UIAlertController alertControllerWithTitle:@"你查看的是:"
                                                          message:@"下一页内容介绍"
                                                   preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *alert = [UIAlertAction actionWithTitle:@"噢噢(确定)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }];
        [self.alertC addAction:alert];

            // 因为预览视图与根视图不在一个视图层级上，所以需要通过根视图去推出这个
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self.alertC animated:YES completion:^{

        }];

    }];

    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"选项二" style:UIPreviewActionStyleSelected handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"选项2 事件处理");
        savedText = action.title;
        self.textDesc.text = savedText;
    }];

    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"选项三" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"选项3 事件处理");
        savedText = action.title;
        self.textDesc.text = savedText;
    }];

    UIPreviewActionGroup *actionGroup = [UIPreviewActionGroup actionGroupWithTitle:@"选项组" style:UIPreviewActionStyleDefault actions:@[action3, action2]];

        // 可以添加多个选项
    return @[action1, action2, action3, actionGroup];

}









/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
