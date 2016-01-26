//
//  ViewController.m
//  3DTouch
//
//  Created by pro on 16/1/15.
//  Copyright © 2016年 vickyTest. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "PeekViewController.h"
#import "PopViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//在这里判断设备是否开启了3D Touch功能
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        NSLog(@"3D Touch 可用");
    }else if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityUnavailable){
        NSLog(@"3D Touch 不可用");
    }else{
        NSLog(@"3D Touch 未检测");
    }
}

//生命周期内可以通过这个方法重新检测3D Touch功能
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        //可用的情况下注册
        [self registerForPreviewingWithDelegate:self sourceView:self.label];
        
        NSLog(@"已注册");
    }else{
        NSLog(@"没注册");
    }
}

//测试压力的最大值 3/20
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    NSLog(@"force value: %f",touch.force);
//    self.view.backgroundColor = [UIColor colorWithRed:touch.force/touch.maximumPossibleForce green:0 blue:1 alpha:1.0];
//    if (touch.force == touch.maximumPossibleForce) {
//         NSLog(@"force max: %f",touch.force);
//    }
//}

#pragma mark - 3D Touch delegate
//Peek 代理方法：
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    if ([self.presentationController isKindOfClass:[PeekViewController class]]) {
        return nil;
    }else{
        PeekViewController *peekVC = [[PeekViewController alloc] initWithNibName:@"PeekViewController" bundle:nil];
        return peekVC;
    }
}

//Pop 代理方法：
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    PopViewController *popVC = [[PopViewController alloc] initWithNibName:@"PopViewController" bundle:nil];
    [self showViewController:popVC sender:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
    self.label.text = @"Peek And Pop";
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.backgroundColor = [UIColor colorWithRed:137.0/255.0 green:137.0/255.0 blue:137.0/255.0 alpha:1.0];
    self.label.font = [UIFont systemFontOfSize:20.0];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 200, self.view.frame.size.width, 50);
    button.backgroundColor = [UIColor colorWithRed:137.0/255.0 green:137.0/255.0 blue:137.0/255.0 alpha:1.0];
    [button setTitle:@"Button" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    [self.view addSubview:self.label];
}

- (void)buttonPress:(UIButton *)button
{
    SecondViewController *secondVC = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    [self presentViewController:secondVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
