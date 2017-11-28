//
//  ViewController.h
//  Test3DTouchViews
//
//  Created by 王士良 on 2017/11/27.
//  Copyright © 2017年 wsliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewColorBg;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *effectView1;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *effectView2;
@property (weak, nonatomic) IBOutlet UIView *viewOthers;

@property (strong, nonatomic) IBOutlet UILongPressGestureRecognizer *gestureLongPress;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *gestureTap;

- (IBAction)actionGestrueEvent:(id)sender;

@end

