//
//  PingTransition.m
//  TransitionDemo
//
//  Created by sidney on 2019/4/23.
//  Copyright © 2019 sidney. All rights reserved.
//

#import "PingTransition.h"
#import "ViewController.h"
#import "SecondViewController.h"

@interface PingTransition()<CAAnimationDelegate>

@property (strong, nonatomic) id <UIViewControllerContextTransitioning>transitionContext;
@end
@implementation PingTransition


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.7;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    self.transitionContext = transitionContext;
    
    ViewController *fromVC = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    SecondViewController *toVC = (SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIButton *btn = fromVC.button;
    
    UIBezierPath *maskStartBP = [UIBezierPath bezierPathWithOvalInRect:btn.frame];
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    
    //创建两个圆形的 UIBezierPath 实例， 一个是 button 的 size，另一个的半径覆盖屏幕，动画在两个 path 之间进行。
    CGPoint finalPoint;
    finalPoint = CGPointMake(btn.center.x - 0, btn.center.y - CGRectGetMaxY(toVC.view.bounds) + 30);
    
    CGFloat radius = sqrt((finalPoint.x * finalPoint.x) + (finalPoint.y * finalPoint.y));
    UIBezierPath *maskFinalBP = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(btn.frame, -radius, -radius)];
    
    //创建一个 CAShapeLayer 来负责展示圆形遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskFinalBP.CGPath; //将他的 path 指定为最终的 path 来避免在动画完成后回弹
    toVC.view.layer.mask = maskLayer;
 
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id _Nullable)(maskStartBP.CGPath);
    maskLayerAnimation.toValue = (__bridge id _Nullable)(maskFinalBP.CGPath);
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    maskLayerAnimation.delegate = self;
    
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}

@end
