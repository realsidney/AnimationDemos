//
//  PingInvertTransition.m
//  TransitionDemo
//
//  Created by sidney on 2019/4/23.
//  Copyright © 2019 sidney. All rights reserved.
//

#import "PingInvertTransition.h"
#import "ViewController.h"
#import "SecondViewController.h"

@interface  PingInvertTransition()<CAAnimationDelegate>
@property (strong, nonatomic) id <UIViewControllerContextTransitioning> transitionContext;
@end

@implementation PingInvertTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.7;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    NSLog(@"pinginvertTransition 方法");
    self.transitionContext = transitionContext;
    SecondViewController *fromVC = (SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ViewController *toVC = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIButton *button = toVC.button;
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    
    UIBezierPath *finalPath = [UIBezierPath bezierPathWithOvalInRect:button.frame];
    CGPoint finalPoint;
    finalPoint = CGPointMake(button.center.x - 0, button.center.y - CGRectGetMaxY(toVC.view.bounds) + 30);
    
    CGFloat radius = sqrt((finalPoint.x * finalPoint.x) + (finalPoint.y * finalPoint.y));
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(button.frame, -radius, -radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = finalPath.CGPath;
    fromVC.view.layer.mask = maskLayer;
    
    CABasicAnimation *pingAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pingAnimation.fromValue = (__bridge id _Nullable)(startPath.CGPath);
    pingAnimation.toValue = (__bridge id _Nullable)(finalPath.CGPath);
    pingAnimation.duration = [self transitionDuration:transitionContext];
    pingAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    pingAnimation.delegate = self;
    [maskLayer addAnimation:pingAnimation forKey:@"pingInvert"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
    
}


@end
