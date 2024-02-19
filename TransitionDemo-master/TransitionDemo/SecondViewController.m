//
//  SecondViewController.m
//  TransitionDemo
//
//  Created by sidney on 2019/4/23.
//  Copyright © 2019 sidney. All rights reserved.
//

#import "SecondViewController.h"
#import "PingInvertTransition.h"

@interface SecondViewController ()

@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *percentTransition;

@end

@implementation SecondViewController{
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   //添加手势
    UIScreenEdgePanGestureRecognizer *screenEdgePanGes = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePan:)];
    screenEdgePanGes.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:screenEdgePanGes];
}

- (IBAction)dismiss:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    return _percentTransition;
}

- (void)edgePan:(UIPanGestureRecognizer *)edgePanRecognizer {
    CGFloat per = [edgePanRecognizer translationInView:self.view].x / (self.view.bounds.size.width);
    NSLog(@"[edgePanRecognizer translationInView:self.view].x=======%.1f", [edgePanRecognizer translationInView:self.view].x);
    per = MIN(1.0, (MAX(0.0, per)));
    NSLog(@"%f",per);
    if (edgePanRecognizer.state == UIGestureRecognizerStateBegan) {
        _percentTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (edgePanRecognizer.state == UIGestureRecognizerStateChanged) {
        [_percentTransition updateInteractiveTransition:per];
        NSLog(@"UIGestureRecognizerStateChanged");
    }else if (edgePanRecognizer.state == UIGestureRecognizerStateEnded || edgePanRecognizer.state == UIGestureRecognizerStateCancelled) {
        if (per > 0.3) {
            [_percentTransition finishInteractiveTransition];
        }else {
            [_percentTransition cancelInteractiveTransition];
        }
        _percentTransition = nil;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        PingInvertTransition *pingInvert = [PingInvertTransition new];
        NSLog(@"创建 PingInvertTransition");
        return pingInvert;
    }else {
        
        return nil;
    }
}

//- (void)transitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL))completion {
//
//
//}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
