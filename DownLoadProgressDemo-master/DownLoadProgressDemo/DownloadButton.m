//
//  DownloadButton.m
//  DownLoadProgressDemo
//
//  Created by sidney on 2019/4/25.
//  Copyright © 2019 sidney. All rights reserved.
//

#import "DownloadButton.h"

@implementation DownloadButton{
    
    BOOL animating;
    CGRect orginFrame;
}

- (instancetype)init {
   self = [super init];
    [self setUp];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self setUp];
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}


- (void)setUp {
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:tapGr];
}

- (void)tapped:(UITapGestureRecognizer *)tapgr {
    orginFrame = self.frame;
    if (animating) {
        return;
    }
    animating = YES;
    
    self.backgroundColor = [UIColor colorWithRed:47/255.0 green:87/255.0 blue:255/255.0 alpha:1.0];
    
    for (CALayer *subLayer in self.layer.sublayers) {
        [subLayer removeFromSuperlayer];
    }
    self.layer.cornerRadius = self.progressBarHeight/2;
    CABasicAnimation *radiusShrinkAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    radiusShrinkAnimation.duration = 0.2f;
    radiusShrinkAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    radiusShrinkAnimation.fromValue = @(orginFrame.size.height/2);
    radiusShrinkAnimation.delegate = self;
    [self.layer addAnimation:radiusShrinkAnimation forKey:@"cornerRadiusShrinkAnim"];
}

- (void)animationDidStart:(CAAnimation *)anim {
    
    if ([anim isEqual:[self.layer animationForKey:@"cornerRadiusShrinkAnim"]]) {
        
        [UIView animateWithDuration:0.6f delay:0.0f usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.bounds = CGRectMake(0, 0, self.progressBarWidth, self.progressBarHeight);
        } completion:^(BOOL finished) {
            [self.layer removeAllAnimations];
            [self progressBarAnimation];
        }];
    }else if ([anim isEqual:[self.layer animationForKey:@"cornerRadiusExpandAnim"]]) {
        
        [UIView animateWithDuration:0.6f delay:0.0f usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.bounds = CGRectMake(0, 0, self->orginFrame.size.width, self->orginFrame.size.width);
            self.layer.cornerRadius = self->orginFrame.size.height/2;
            self.backgroundColor = [UIColor colorWithRed:0.18 green:0.8 blue:0.4 alpha:1.0];
        } completion:^(BOOL finished) {
            [self.layer removeAllAnimations];
            [self checkAnimation];
            self->animating = NO;
        }];
    }
    
    if ([[anim valueForKey:@"animationName"] isEqualToString:@"progressBarAnimation"] ||
        [[anim valueForKey:@"animationName"] isEqualToString:@"checkAnimation"]) {
        for (CALayer *subLayer in self.layer.sublayers) {
            subLayer.opaque = 1.0f;
        }
    }
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if ([[anim valueForKey:@"animationName"] isEqualToString:@"progressBarAnimation"]) {
        [UIView animateWithDuration:0.3 animations:^{
            for (CALayer *subLayer in self.layer.sublayers) {
                subLayer.opaque = 0.0f;
            }
            
        } completion:^(BOOL finished) {
            if (finished) {
                for (CALayer *subLayer in self.layer.sublayers) {
                    [subLayer removeFromSuperlayer];
                }
            }
            self.bounds = self->orginFrame;
            
            CABasicAnimation *radiusAnimation = [CABasicAnimation animationWithKeyPath:@"cornorRadius"];
            radiusAnimation.duration = 0.2f;
            radiusAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            radiusAnimation.fromValue = @(self->_progressBarHeight/2);
            radiusAnimation.delegate = self;
            [self.layer addAnimation:radiusAnimation forKey:@"cornerRadiusExpandAnim"];
        }];
    }
}

//helper

- (void)progressBarAnimation {
    CAShapeLayer *progressShapeLayer = [CAShapeLayer layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(_progressBarHeight/2, self.bounds.size.height/2)];
    [path addLineToPoint:CGPointMake(self.bounds.size.width - _progressBarHeight/2, self.bounds.size.height/2)];
    
    progressShapeLayer.path = path.CGPath;
    progressShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    progressShapeLayer.lineWidth = _progressBarHeight - 6;
    progressShapeLayer.opaque = 0.0f; //先透明，不然会闪一下
    progressShapeLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:progressShapeLayer];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 2.0f;
    pathAnimation.fromValue = @(0.0f);
    pathAnimation.toValue = @(1.0f);
    pathAnimation.delegate = self;
    [pathAnimation setValue:@"progressBarAnimation" forKey:@"animationName"];
    [progressShapeLayer addAnimation:pathAnimation forKey:nil];
    
}

- (void)checkAnimation {
    
    CAShapeLayer *checkLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGRect rectInCircle = CGRectInset(self.bounds, self.bounds.size.width*(1-1/sqrt(2.0))/2, self.bounds.size.width*(1-1/sqrt(2.0))/2);
    [path moveToPoint:CGPointMake(rectInCircle.origin.x + rectInCircle.size.width/9, rectInCircle.origin.y + rectInCircle.size.height*2/3)];
    [path addLineToPoint:CGPointMake(rectInCircle.origin.x + rectInCircle.size.width/3,rectInCircle.origin.y + rectInCircle.size.height*9/10)];
    [path addLineToPoint:CGPointMake(rectInCircle.origin.x + rectInCircle.size.width*8/10, rectInCircle.origin.y + rectInCircle.size.height*2/10)];
    
    checkLayer.path = path.CGPath;
    checkLayer.fillColor = [UIColor clearColor].CGColor;
    checkLayer.strokeColor = [UIColor whiteColor].CGColor;
    checkLayer.opaque = 0.0f; //先透明，不然会闪一下
    checkLayer.lineWidth = 10.0;
    checkLayer.lineCap = kCALineCapRound;
    checkLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:checkLayer];
    
    CABasicAnimation *checkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    checkAnimation.duration = 0.3f;
    checkAnimation.fromValue = @(0.0f);
    checkAnimation.toValue = @(1.0f);
    checkAnimation.delegate = self;
    [checkAnimation setValue:@"checkAnimation" forKey:@"animationName"];
    [checkLayer addAnimation:checkAnimation forKey:nil];
}

@end
