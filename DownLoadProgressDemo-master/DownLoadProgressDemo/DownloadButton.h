//
//  DownloadButton.h
//  DownLoadProgressDemo
//
//  Created by sidney on 2019/4/25.
//  Copyright © 2019 sidney. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DownloadButton : UIView<CAAnimationDelegate>
@property (assign, nonatomic) CGFloat progressBarHeight;
@property (assign, nonatomic) CGFloat progressBarWidth;
@end

NS_ASSUME_NONNULL_END
