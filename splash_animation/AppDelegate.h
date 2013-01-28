//
//  AppDelegate.h
//  splash_animation
//
//  Created by Tian on 23/01/13.
//  Copyright (c) 2013 Tian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressImageView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ProgressImageView *progressImageView;
@property (nonatomic) float progress;
@end
