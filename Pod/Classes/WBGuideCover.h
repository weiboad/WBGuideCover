//
//  WBGuideCover.h
//  WBKit_Example
//
//  Created by penghui8 on 2018/8/2.
//  Copyright © 2018年 huipengo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WBBezierPath) {
    /// 圆形
    WBBezierPathRound = 0,
    /// 矩形
    WBBezierPathSquare = 1,
};

@interface WBGuideCoverItem : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) CGRect frame;

@property (nonatomic, assign) CGFloat radius;

@property (nonatomic, assign) WBBezierPath bezierPath;

@end

@interface WBGuideCover : NSObject

@property (nonatomic, strong) NSMutableArray<WBGuideCoverItem *> *guideCoverItems;

+ (instancetype)getInstance;

- (void)showGuideCoverInView:(UIView *)superView completion:(void(^)(BOOL finished))completion;

@end
