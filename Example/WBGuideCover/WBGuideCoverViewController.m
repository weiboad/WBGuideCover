//
//  WBGuideCoverViewController.m
//  WBKit_Example
//
//  Created by penghui8 on 2018/8/2.
//  Copyright © 2018年 huipengo. All rights reserved.
//

#import "WBGuideCoverViewController.h"
#import "WBGuideCover.h"

@interface WBGuideCoverViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation WBGuideCoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.image = [UIImage imageNamed:@"IMG"];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(tapGestureRecognizer:)]];
    
    [self showGuideCover];
}

- (void)tapGestureRecognizer:(UIGestureRecognizer *)sender {
    [self showGuideCover];
}

- (void)showGuideCover
{
    WBGuideCoverItem *item = [[WBGuideCoverItem alloc] init];
    item.title = @"点击可切换数据展示方式";
    item.frame = CGRectMake(60.0f, 100.0f, 100.0f, 40.0f);
    item.bezierPath = WBBezierPathRound;
    
    WBGuideCoverItem *item1 = [[WBGuideCoverItem alloc] init];
    item1.title = @"按住向左滑可进行置顶操作";
    item1.frame = CGRectMake(20.0f, 280.0f, [UIScreen mainScreen].bounds.size.width - 20.0f * 2, 60.0f);
    item1.bezierPath = WBBezierPathSquare;
    
    WBGuideCoverItem *item2 = [[WBGuideCoverItem alloc] init];
    item2.title = @"点击进入切换代理商列表";
    item2.frame = CGRectMake(50.0f, 520.0f, 100.0f, 50.0f);
    item2.bezierPath = WBBezierPathRound;
    
    WBGuideCoverItem *item3 = [[WBGuideCoverItem alloc] init];
    item3.title = @"点击进入切换代理商列表";
    item3.frame = CGRectMake(190.0f, 500.0f, 100.0f, 50.0f);
    item3.bezierPath = WBBezierPathRound;
    
    WBGuideCoverItem *item4 = [[WBGuideCoverItem alloc] init];
    item4.title = @"点击进入切换代理商列表";
    item4.frame = CGRectMake(190.0f, 405.0f, 100.0f, 50.0f);
    item4.bezierPath = WBBezierPathRound;
    
    [[WBGuideCover getInstance].guideCoverItems addObjectsFromArray:@[item, item1, item2, item3, item4]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[WBGuideCover getInstance] showGuideCoverInView:self.navigationController.view completion:^(BOOL finished) {
            
        }];
    });
}

@end
