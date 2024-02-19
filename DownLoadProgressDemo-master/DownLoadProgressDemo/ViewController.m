//
//  ViewController.m
//  DownLoadProgressDemo
//
//  Created by sidney on 2019/4/25.
//  Copyright © 2019 sidney. All rights reserved.
//

#import "ViewController.h"
#import "DownloadButton.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet DownloadButton *downloadButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _downloadButton.layer.cornerRadius = 50;
    _downloadButton.progressBarWidth = 200;
    _downloadButton.progressBarHeight = 30;
}


@end
