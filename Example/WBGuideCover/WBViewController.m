//
//  WBViewController.m
//  WBGuideCover_Example
//
//  Created by penghui8 on 2018/8/3.
//  Copyright © 2018年 彭辉. All rights reserved.
//

#import "WBViewController.h"
#import "WBGuideCoverViewController.h"

@interface WBViewController ()

@end

@implementation WBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)guideCoverAction:(id)sender {
    WBGuideCoverViewController *viewController = [[WBGuideCoverViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
