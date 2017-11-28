//
//  ViewController.m
//  Test3DTouchViews
//
//  Created by 王士良 on 2017/11/27.
//  Copyright © 2017年 wsliang. All rights reserved.
//

#import "ViewController.h"
#import "ContentViewController.h"

// 实现Peek & Pop交互的控件所在的控制器遵守UIViewControllerPreviewingDelegate协议
@interface ViewController ()<UIViewControllerPreviewingDelegate>

@property (nonatomic) UIColor *bgColorDefault;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.bgColorDefault = [UIColor colorWithRed:0 green:1 blue:0.05f alpha:1];
    self.view.backgroundColor = self.bgColorDefault;

        // 注册预览视图的代理和来源视图
//    在控制器内为需要实现Peek & Pop交互的控件注册Peek & Pop功能

    if ([self hasSupprot3DTouch]) {
        [self registerForPreviewingWithDelegate:(id)self sourceView:self.viewColorBg];

        [self registerForPreviewingWithDelegate:(id)self sourceView:self.effectView1.contentView];
        [self registerForPreviewingWithDelegate:(id)self sourceView:self.effectView2.contentView];

        [self registerForPreviewingWithDelegate:(id)self sourceView:self.viewOthers];
    }

}



-(BOOL)hasSupprot3DTouch
{
    BOOL hasSupport = NO;
    if ([self respondsToSelector:@selector(traitCollection)])
    {
        if ([self.traitCollection respondsToSelector:@selector(forceTouchCapability)])
        {
            if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)
            {
                    // 支持3D Touch
                hasSupport = YES;
            }
            else
            {
                    // 不支持3D Touch
            }
        }
    }

    return hasSupport;
}

// 3D touch 功能 可能随时关闭,状态切换通知?
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    NSLog(@"功能改变:traitCollectionDidChange:%@",previousTraitCollection);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)actionGestrueEvent:(UIGestureRecognizer *)sender {

    CGPoint point = [sender locationInView:self.view];
    NSLog(@"手势事件触发点:%@ , 事件类型:%@",NSStringFromCGPoint(point),sender);
}


/**
 (1)peek功能的实现
 Peek窗口的内容其实是目标VC【ps即将要显示的ViewController】的一个实时快照，但它不可以点击。Peek触发阶段有三种：

 长按【显示一个焦点视图，触发Peek的源视图高亮，其它视图都处于模糊状态】
 轻压【显示Peek窗口，此时如果Peek窗口支持Quick Actions，往上滑会显示Quick Actions菜单，此时的Peek窗口是不可以点击的】
 重压 【进入到真正的ViewController】

 */
#pragma mark - 按压图片进入预览模式
- (UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
        // previewingContext.sourceView: 触发Peek & Pop操作的视图
        // previewingContext.sourceRect: 设置触发操作的视图的不被虚化的区域
    UIView *sourceView = previewingContext.sourceView;
    UIColor *bgColor = sourceView.backgroundColor;
    if (sourceView == self.viewColorBg) { // 背景色view

    }else if (sourceView == self.effectView1.contentView) { // 背景色view1
        bgColor = [UIColor grayColor];

    }else if (sourceView == self.effectView2.contentView) { // 背景色view2
        bgColor = [UIColor lightGrayColor];

    }
    ContentViewController *content = [[ContentViewController alloc] init];
    content.testColor = bgColor;
        // 预览区域大小(可不设置)
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    content.preferredContentSize = CGSizeMake(screenSize.width*0.75f, screenSize.height*0.6f);

    content.title = @"测试页面";

    return content;

}

#pragma mark - 继续按压进入查看图片
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
//    viewControllerToCommit.view.backgroundColor = [UIColor whiteColor];
    [self showViewController:viewControllerToCommit sender:self];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    NSLog(@"touch点 数目:%lu , 当前:force:%f maximumPossibleForce:%f",touches.count,touch.force,touch.maximumPossibleForce);
    float force = touch.force/touch.maximumPossibleForce;

    UIColor *color = [UIColor colorWithRed:force green:1-force blue:0.05f alpha:1];
    self.view.backgroundColor = color;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
self.view.backgroundColor = self.bgColorDefault;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{

}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{

}





@end
