//
//  PeekViewController.m
//  3DTouch
//
//  Created by pro on 16/1/18.
//  Copyright © 2016年 vickyTest. All rights reserved.
//

#import "PeekViewController.h"

@interface PeekViewController ()

@end

@implementation PeekViewController

//初始化preViewActionsItems
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems
{
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"action1" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"action 1 selected");
    }];
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"action2" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"action 2 selected");
    }];
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"action3" style:UIPreviewActionStyleSelected handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"action 3 selected");
    }];
    
    UIPreviewAction *tap1 = [UIPreviewAction actionWithTitle:@"tap1" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"tap 1 selected");
    }];
    UIPreviewAction *tap2 = [UIPreviewAction actionWithTitle:@"tap2" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"tap 2 selected");
    }];
    UIPreviewAction *tap3 = [UIPreviewAction actionWithTitle:@"tap3" style:UIPreviewActionStyleSelected handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"tap 3 selected");
    }];
    
    NSArray *actions = @[action1,action2,action3];
    NSArray *taps = @[tap1,tap2,tap3];
    UIPreviewActionGroup *group1 = [UIPreviewActionGroup actionGroupWithTitle:@"group1" style:UIPreviewActionStyleDefault actions:actions];
    UIPreviewActionGroup *group2 = [UIPreviewActionGroup actionGroupWithTitle:@"group2`" style:UIPreviewActionStyleSelected actions:taps];
    
    NSArray *group = @[group1,group2];
   
    return group;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, self.view.frame.size.width-200, 50)];
    label.text = self.sendData;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:25.0];
    label.userInteractionEnabled = YES;
    [label addGestureRecognizer:tap];
    [self.view addSubview:label];
}

#pragma mark - back method
- (void)back:(UITapGestureRecognizer *)tap
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
