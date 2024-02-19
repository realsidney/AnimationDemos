//
//  ViewController.m
//  BubbleDemo
//
//  Created by sidney on 2019/5/6.
//  Copyright © 2019 sidney. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bubble;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1. cirle move
    
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.repeatCount = MAXFLOAT;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.duration = 7.0;
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGRect circleContainer = CGRectInset(_bubble.frame, _bubble.frame.size.width/2 - 3, _bubble.frame.size.width/2 -3);
    CGPathAddEllipseInRect(curvedPath, nil, circleContainer);
    pathAnimation.path = curvedPath;
    [_bubble.layer addAnimation:pathAnimation forKey:@"myCircleAnimation"];
    
    //2. scale X
    
    CAKeyframeAnimation *scaleX = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
    scaleX.values = @[@(1.0), @(1.1), @(1.0)];
    scaleX.keyTimes = @[@(0.0), @(0.5), @(1.0)];
    scaleX.repeatCount = MAXFLOAT;
    scaleX.autoreverses = YES;
    scaleX.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleX.duration = 3.0;
    [_bubble.layer addAnimation:scaleX forKey:@"myScaleXAnimation"];
    
    //3. scale Y
    
    CAKeyframeAnimation *scaleY = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleY.values = @[@(1.0), @(1.1), @(1.0)];
    scaleY.keyTimes = @[@(0.0), @(0.5), @(1.0)];
    scaleY.repeatCount = MAXFLOAT;
    scaleY.autoreverses = YES;
    scaleY.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleY.duration = 4.0;
    [_bubble.layer addAnimation:scaleY forKey:@"myScaleYAnimation"];
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(present)];
    
    [_bubble addGestureRecognizer:tapGr];
}

- (void)present {
    
    [self presentViewController:[SecondViewController new] animated:YES completion:nil];
}

@end
