//
//  ViewController.m
//  TransitionDemo
//
//  Created by sidney on 2019/4/23.
//  Copyright © 2019 sidney. All rights reserved.
//

#import "ViewController.h"
#import "PingTransition.h"
#import "SecondViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush) {
        PingTransition *ping = [PingTransition new];
        return ping;
    }else {
        return nil;
    }
}
- (IBAction)clickBtn:(id)sender {
    [self.navigationController pushViewController:[SecondViewController new] animated:YES];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
