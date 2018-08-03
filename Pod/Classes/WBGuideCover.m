//
//  WBGuideCover.m
//  WBKit_Example
//
//  Created by penghui8 on 2018/8/2.
//  Copyright © 2018年 huipengo. All rights reserved.
//

#import "WBGuideCover.h"

#define MAIN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define MAIN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define wScreenRate (375.0f / MAIN_WIDTH)
#define wAutoFloat(float) (float / wScreenRate)
#define wAutoSize(width, height) CGSizeMake(width / wScreenRate, height / wScreenRate)
#define wAutoPoint(x, y) CGPointMake(x / wScreenRate, y / wScreenRate)
#define wAutoRect(x, y, width, heigth) CGRectMake(x / wScreenRate, y / wScreenRate, width / wScreenRate, heigth / wScreenRate)

static CGFloat const wArrowsImageViewWidth  = 60.0f;
static CGFloat const wArrowsImageViewHeight = 46.0f;

@implementation WBGuideCoverItem

@end

@interface WBGuideCover ()

@property (nonatomic, strong) CAShapeLayer *dashLayer;

@property (nonatomic, strong) UIImageView *arrowsImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *superView;

@property (nonatomic, copy) void(^finishedCompletion)(BOOL finished);

@end

@implementation WBGuideCover

- (void)dealloc {
    
}

- (NSMutableArray<WBGuideCoverItem *> *)guideCoverItems {
    if (!_guideCoverItems) {
        _guideCoverItems = [NSMutableArray array];
    }
    return _guideCoverItems;
}

static id _instance = nil;
static dispatch_once_t once_predicate;
+ (instancetype)getInstance {
    dispatch_once(&once_predicate, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void)showGuideCoverInView:(UIView *)superView completion:(void(^)(BOOL finished))completion {
    if (self.guideCoverItems.count <= 0) {
        
        self.superView = nil;
        !self.finishedCompletion?:self.finishedCompletion(YES);
        
        _instance = nil;
        once_predicate = 0;
        
        return;
    };
    
    self.finishedCompletion = completion;
    
    self.superView = superView?:[UIApplication sharedApplication].keyWindow;
    
    UIView *coverView = [[UIView alloc] initWithFrame:superView.bounds];
    coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.55f];
    [coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)]];
    [superView addSubview:coverView];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:superView.bounds];
    
    WBGuideCoverItem *coverItem = self.guideCoverItems.firstObject;
    
    if (coverItem.bezierPath == WBBezierPathRound) {
        CGPoint point = wAutoPoint(coverItem.frame.origin.x + coverItem.frame.size.width/2.0f, coverItem.frame.origin.y + coverItem.frame.size.height/2.0f);
        CGFloat radius = coverItem.radius;
        if (radius == 0.0f) {
            radius = 20.0f;
        }
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:point radius:wAutoFloat(radius) startAngle:0.0f endAngle:2 * M_PI clockwise:NO];
        [bezierPath appendPath:path];
        
        /* 贝塞尔曲线路径 */
        self.dashLayer.path = [UIBezierPath bezierPathWithArcCenter:point radius:wAutoFloat(radius + 2.0f) startAngle:0.0f endAngle:2 * M_PI clockwise:NO].CGPath;
    }
    else if (coverItem.bezierPath == WBBezierPathSquare) {
        CGFloat cornerRadius = 3.0f;
        
        UIBezierPath *path = [[UIBezierPath bezierPathWithRoundedRect:coverItem.frame cornerRadius:cornerRadius] bezierPathByReversingPath];
        [bezierPath appendPath:path];
        
        CGRect c_frame = coverItem.frame;
        CGFloat space = 3.0f;
        c_frame.origin.x -= space;
        c_frame.origin.y -= space;
        c_frame.size.width += (2 * space);
        c_frame.size.height += (2 * space);
        
        /* 贝塞尔曲线路径 */
        self.dashLayer.path = [[UIBezierPath bezierPathWithRoundedRect:c_frame cornerRadius:cornerRadius] bezierPathByReversingPath].CGPath;
    }
    
    /// 绘制透明区域
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    /* 贝塞尔曲线路径 */
    shapeLayer.path = bezierPath.CGPath;
    [coverView.layer setMask:shapeLayer];
    
    [coverView.layer insertSublayer:self.dashLayer below:shapeLayer];
    
    self.titleLabel.text = coverItem.title;
    [self resetSubViewsFrame:coverItem.frame superView:coverView];
    
    [self.guideCoverItems removeObjectAtIndex:0];
}

- (void)tapGestureRecognizer:(UIGestureRecognizer *)recognizer {
    UIView *coverView = recognizer.view;
    [coverView removeFromSuperview];
    [coverView removeGestureRecognizer:recognizer];
    [[coverView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    coverView = nil;
    
    [self showGuideCoverInView:self.superView completion:self.finishedCompletion];
}

- (void)resetSubViewsFrame:(CGRect)frame superView:(UIView *)view {
    
    CGFloat centerX = [UIScreen mainScreen].bounds.size.width/2;
    CGFloat centerY = [UIScreen mainScreen].bounds.size.height/2;
    CGFloat x = frame.origin.x;
    CGFloat y = frame.origin.y;
    CGFloat w = frame.size.width;
    CGFloat h = frame.size.height;
    
    CGFloat arrowsX = 0.0f;
    CGFloat arrowsY = 0.0f;
    CGFloat titleX = 0.0f;
    CGFloat titleY = 0.0f;
    CGSize title_size = [self sizeWithBoundingRectSize:CGSizeMake(200.0f, CGFLOAT_MAX)
                                         attributeFont:self.titleLabel.font text:self.titleLabel.text];
    
    CGFloat angle = 0.0f;
    if (x < centerX && y < centerY) {
        /// 左上
        /// 箭头旋转180°
        angle = M_PI;
        arrowsX = x + MIN(w, 100.0f)/2;
        arrowsY = y + h;
        titleX = arrowsX + wArrowsImageViewWidth;
        titleY = arrowsY + wArrowsImageViewHeight - title_size.height/2.0f - 10.0f;
    }
    else if (x >= centerX && y <= centerY) {
        /// 右上
        /// 箭头旋转-90°
        angle = -M_PI_2;
        arrowsX = x - wArrowsImageViewWidth / 2;
        arrowsY = y + h;
        titleX = arrowsX - title_size.width / 2 - 20.0f;
        titleY = arrowsY + wArrowsImageViewHeight;
    }
    else if (x >= centerX && y >= centerY) {
        /// 右下
        /// 箭头不旋转
        angle = 0.0f;
        arrowsX = x;
        arrowsY = y - wArrowsImageViewHeight;
        titleX = arrowsX - title_size.width + 0.0f;
        titleY = arrowsY - title_size.height + 20.0f;
    }
    else if (x < centerX && y > centerY) {
        /// 左下
        angle = M_PI_2;
        arrowsX = x + wArrowsImageViewWidth / 2 + 10.0f;
        arrowsY = y - h + 30.0f;
        titleX = arrowsX + wArrowsImageViewWidth;
        titleY = arrowsY + title_size.height / 2.0f - 10.0f;
    }
    
    self.arrowsImageView.transform = CGAffineTransformMakeRotation(angle);
    
    if (x < centerX && y > centerY) {
        self.arrowsImageView.transform = CGAffineTransformMakeScale(-1.0f, 1.0f);
    }
    
    self.arrowsImageView.frame = CGRectMake(arrowsX, arrowsY, wArrowsImageViewWidth, wArrowsImageViewHeight);
    self.titleLabel.frame = CGRectMake(titleX, titleY, title_size.width, title_size.height);
    if (![self.arrowsImageView isDescendantOfView:view]) {
        [view addSubview:self.arrowsImageView];
    }
    [self startArrowsAnimation];
    
    if (![self.titleLabel isDescendantOfView:view]) {
        [view addSubview:self.titleLabel];
    }
}

- (void)startArrowsAnimation {
    if (self.arrowsImageView.animationImages == nil) {
        NSMutableArray *images = [[NSMutableArray alloc] init];
        for (NSInteger i = 1; i <= 8; i++) {
            NSString *imageName = [NSString stringWithFormat:@"wb_guide_arrows%02ld@2x", (long)i];
            UIImage *image = [UIImage imageWithContentsOfFile:[[WBGuideCover wb_guideCoverBundle] pathForResource:imageName ofType:@"png"]];

            if (image) {
                [images addObject:image];
            }
        }
        self.arrowsImageView.animationImages = images;
        self.arrowsImageView.animationDuration = 0.5;
        self.arrowsImageView.animationRepeatCount = 0;
    }
    [self.arrowsImageView startAnimating];
}

- (void)stopArrowsAnimation {
    if ([self.arrowsImageView isAnimating]) {
        [self.arrowsImageView stopAnimating];
    }
}

- (CAShapeLayer *)dashLayer {
    if (!_dashLayer) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        /// 虚线的颜色
        layer.strokeColor = [UIColor whiteColor].CGColor;
        /// 填充虚线内的颜色
        layer.fillColor = nil;
        /// 虚线宽度
        layer.lineWidth = 0.7f;
        /* The cap style used when stroking the path. Options are `butt', `round'
         * and `square'. Defaults to `butt'. */
        layer.lineCap = @"square";
        /// 虚线的每个点长和两个点之间的空隙
        layer.lineDashPattern = @[@3, @2];
        _dashLayer = layer;
    }
    return _dashLayer;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15.0/wScreenRate];
    }
    return _titleLabel;
}

- (UIImageView *)arrowsImageView {
    if (!_arrowsImageView) {
        _arrowsImageView = [[UIImageView alloc] init];
    }
    return _arrowsImageView;
}

- (CGSize)sizeWithBoundingRectSize:(CGSize)rectSize attributeFont:(UIFont *)attributeFont text:(NSString *)text {
    if (!([text isKindOfClass:[NSString class]] && text.length > 0)) {
        return CGSizeZero;
    }
    NSDictionary *attributes = @{NSFontAttributeName: attributeFont};
    CGSize stringSize = [text boundingRectWithSize:rectSize
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                        attributes:attributes
                                           context:nil].size;
    return CGSizeMake(ceilf(stringSize.width), ceilf(stringSize.height));
}

+ (NSBundle *)wb_guideCoverBundle
{
    static NSBundle *bundle = nil;
    if (bundle == nil) {
        // 这里不使用mainBundle是为了适配pod 1.x和0.x
        NSString *bundlePath = [[NSBundle bundleForClass:[WBGuideCover class]] pathForResource:@"WBGuideCover" ofType:@"bundle"];
        bundle = [NSBundle bundleWithPath:bundlePath];
    }
    return bundle;
}

@end
