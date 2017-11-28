//
//  AppDelegate.m
//  Test3DTouchViews
//
//  Created by 王士良 on 2017/11/27.
//  Copyright © 2017年 wsliang. All rights reserved.
//

#import "AppDelegate.h"

#import "ContentViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    [self addIcon3DtouchItems];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




// 点击 图标显示的内容事件.
-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
        //判断先前我们设置的唯一标识
    NSDictionary *userInfo = shortcutItem.userInfo;
    NSLog(@"传递的内容 userInfo:%@",userInfo);

    if([shortcutItem.type isEqualToString:@"type4"] || [shortcutItem.type isEqualToString:@"type3"]){
        NSArray *arr = @[@"(3DTouch)hello:%@",shortcutItem.localizedTitle];
        UIActivityViewController *vc = [[UIActivityViewController alloc]initWithActivityItems:arr applicationActivities:nil];
            //设置当前的VC 为rootVC
        [self.window.rootViewController presentViewController:vc animated:YES completion:^{
            NSLog(@"显示 标签1 的界面 完成:%@",vc);
        }];

    }else if ([shortcutItem.type isEqual: @"type2"]) {
            // 点击标签2时，显示提示框
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"OPPS!" message:@"AppDelegate 收到的图标3D touch事件." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"关闭 弹出框 完成");
        }];
        [alertC addAction:alert];
        [self.window.rootViewController presentViewController:alertC animated:YES completion:^{
            NSLog(@"显示 标签2 的界面 完成:%@",alertC);
        }];

        return;
    } else if ([shortcutItem.type isEqual: @"type1"]) {
        ContentViewController *cvc = [ContentViewController new];
        cvc.title = @"love";
        cvc.testColor = [UIColor redColor];
[self showNewViewcontroller:cvc];
    } else if ([shortcutItem.type isEqual: @"type0"]) {
        ContentViewController *cvc = [ContentViewController new];
        cvc.title = @"home";
        cvc.testColor = [UIColor cyanColor];
        [self showNewViewcontroller:cvc];


    }

}

-(void)showNewViewcontroller:(UIViewController *)distVC
{
    if ([self.window.rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *rootvc = (id)self.window.rootViewController;
        [rootvc pushViewController:distVC animated:YES];
    }else{
        [self.window.rootViewController presentViewController:distVC animated:YES completion:nil];
    }
}

// 添加程序图标 3d touch 标签
-(void)addIcon3DtouchItems
{
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(shortcutItems)])
    {
        UIApplicationShortcutItem * item0 = [[UIApplicationShortcutItem alloc]initWithType:@"type0"
                                                                            localizedTitle:@"标签0"
                                                                         localizedSubtitle:@"222"
                                                                                      icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeHome]
                                                                                  userInfo:nil];

        UIApplicationShortcutItem * item1 = [[UIApplicationShortcutItem alloc]initWithType:@"type1"
                                                                            localizedTitle:@"标签1"
                                                                         localizedSubtitle:@"222"
                                                                                      icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLove]
                                                                                  userInfo:nil];

        UIApplicationShortcutItem * item2 = [[UIApplicationShortcutItem alloc]initWithType:@"type2"
                                                                            localizedTitle:@"标签2"
                                                                         localizedSubtitle:@"222"
                                                                                      icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeMessage]
                                                                                  userInfo:nil];
            // 设置自定义标签图片

        UIApplicationShortcutItem * item3 = [[UIApplicationShortcutItem alloc]initWithType:@"type3"
                                                                            localizedTitle:@"分享"
                                                                         localizedSubtitle:@"分享描述"
                                                                                      icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"img70"]
                                                                                  userInfo:nil];

        UIApplicationShortcutItem * item4 = [[UIApplicationShortcutItem alloc]initWithType:@"type4" // 必填
                                                                            localizedTitle:@"分享2" // 必填
                                                                         localizedSubtitle:@"分享2描述"
                                                                                      icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare]
                                                                                  userInfo:@{@"测试key":@[@"测试内容1"]}];

        [UIApplication sharedApplication].shortcutItems = @[item0, item1, item2, item3, item4];
        
    }
    

}




@end
