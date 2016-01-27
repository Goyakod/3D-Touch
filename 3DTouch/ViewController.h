//
//  ViewController.h
//  3DTouch
//
//  Created by pro on 16/1/15.
//  Copyright © 2016年 vickyTest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIViewControllerPreviewingDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@end

