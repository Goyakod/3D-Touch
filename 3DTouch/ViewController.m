//
//  ViewController.m
//  3DTouch
//
//  Created by pro on 16/1/15.
//  Copyright © 2016年 vickyTest. All rights reserved.
//

#import "ViewController.h"

#import "PeekViewController.h"

@interface ViewController (){
    
    NSMutableArray *_dataSource;
}

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
        [self registerForPreviewingWithDelegate:self sourceView:self.tableView];
        
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

#pragma mark - viewcontrollerPrewingdelegate
//Peek 代理方法：
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    if ([self.presentationController isKindOfClass:[PeekViewController class]]) {
        return nil;
    }else{
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            return nil;
        }
        
        previewingContext.sourceRect = cell.frame;
        PeekViewController *peekVC = [[PeekViewController alloc] initWithNibName:@"PeekViewController" bundle:nil];
        peekVC.preferredContentSize = CGSizeMake(0, 0);
        
        return peekVC;
    }
}

//Pop 代理方法：
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    PeekViewController *peekVC = [[PeekViewController alloc] initWithNibName:@"PeekViewController" bundle:nil];
    peekVC.sendData = @"from POP";
    [self presentViewController:peekVC animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSource = [NSMutableArray array];
    for (int i = 0; i < 20; i ++) {
        NSString *tmp = [NSString stringWithFormat:@"我是数据项%d",i];
        [_dataSource addObject:tmp];
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
}

#pragma mark tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [_dataSource objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PeekViewController *peekVC = [[PeekViewController alloc] initWithNibName:@"PeekViewController" bundle:nil];
    peekVC.sendData = [_dataSource objectAtIndex:indexPath.row];
    [self presentViewController:peekVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
