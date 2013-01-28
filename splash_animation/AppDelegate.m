//
//  AppDelegate.m
//  splash_animation
//
//  Created by Tian on 23/01/13.
//  Copyright (c) 2013 Tian. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize progressImageView = _progressImageView;
@synthesize progress = _progress;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    _progress = 1.0f;
    _progressImageView = (ProgressImageView*)[self.window.rootViewController.view.subviews objectAtIndex:1];
    
    NSDate *d = [NSDate date];
    NSTimer *t = [[NSTimer alloc] initWithFireDate: d
                                          interval: 0.1f
                                            target: self
                                          selector:@selector(updateProgress:)
                                          userInfo:nil repeats:YES];
    
    NSRunLoop *runner = [NSRunLoop currentRunLoop];
    [runner addTimer:t forMode: NSDefaultRunLoopMode];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)updateProgress:(NSTimer *)timer {
    _progress -= 0.01f;
    [_progressImageView setProgress:_progress];
}

@end
