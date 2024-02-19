//
//  ViewController.m
//  TwitterCopy
//
//  Created by sidney on 2019/4/23.
//  Copyright © 2019 sidney. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //logo mask
    self.navigationController.view.layer.mask = [CALayer layer];
    self.navigationController.view.layer.mask.contents = (id)[UIImage imageNamed:@"logo"].CGImage;
    self.navigationController.view.layer.mask.position = self.view.center;
    self.navigationController.view.layer.mask.bounds = CGRectMake(0, 0, 105, 100);
        
    //logo mask background view
    UIView *maskBackgroundView = [[UIView alloc] initWithFrame:self.navigationController.view.bounds];
    maskBackgroundView.backgroundColor = [UIColor whiteColor];
    [self.navigationController.view addSubview:maskBackgroundView];
    [self.navigationController.view bringSubviewToFront:maskBackgroundView];

    CAKeyframeAnimation *transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
//    transformAnimation.delegate = self;
    transformAnimation.duration = 1.0f;
    transformAnimation.beginTime = CACurrentMediaTime() + 1.0f; //延迟一秒

    CGRect initalBounds = CGRectMake(0, 0, 100, 100);
    CGRect secondBounds = CGRectMake(0, 0, 80, 80);
    CGRect finalBounds = CGRectMake(0, 0, 2000, 2000);

    transformAnimation.values = @[[NSValue valueWithCGRect:initalBounds], [NSValue valueWithCGRect:secondBounds], [NSValue valueWithCGRect:finalBounds]];
    transformAnimation.keyTimes = @[@(0),@(0.5),@(1)];
    transformAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    transformAnimation.removedOnCompletion = NO;
    transformAnimation.fillMode = kCAFillModeForwards;
    [self.navigationController.view.layer.mask addAnimation:transformAnimation forKey:@"transformAnimation"];

    //mask background view animation
    [UIView animateWithDuration:0.1 delay:1.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        maskBackgroundView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [maskBackgroundView removeFromSuperview];
    }];

    [UIView animateWithDuration:0.25 delay:1.3 options:UIViewAnimationOptionTransitionNone animations:^{
        self.navigationController.view.transform = CGAffineTransformMakeScale(1.05, 1.05);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.navigationController.view.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {

        }];
    }];
}

@end
