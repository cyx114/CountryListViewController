/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

#import <UIKit/UIKit.h>

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (ViewFrameGeometry)

@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

@property (nonatomic, assign) CGFloat lx_centerX;
@property (nonatomic, assign) CGFloat lx_centerY;

/**
 *  移动位置
 *
 *  @param delta 移动位置的距离
 */
- (void) moveBy: (CGPoint) delta;
/**
 *  缩放
 *
 *  @param scaleFactor 因子
 */
- (void) scaleBy: (CGFloat) scaleFactor;
/**
 *  Ensure that both dimensions fit within the given size by scaling down
 *
 *  @param aSize <#aSize description#>
 */
- (void) fitInSize: (CGSize) aSize;
/**
 *  判断两个view是否重合
 *
 *  @param view 另一个view
 *
 *  @return 是否重合
 */
- (BOOL)lx_intersectsWithView:(UIView *)view;
/**
 *  从nib文件中加载view，xib名字必须与类名一致
 *
 *  @return view
 */
+ (instancetype)lx_viewFromXib;


@end