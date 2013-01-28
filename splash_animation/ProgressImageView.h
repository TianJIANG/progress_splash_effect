//
//  ProgressImageView.h
//  splash_animation
//
//  Created by Tian on 23/01/13.
//  Copyright (c) 2013 Tian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressImageView : UIImageView {
    UIImage *_originalImage;
    BOOL _internalUpdating;
}

@property (nonatomic) float progress;

- (void)commonInit;
- (void)updateDrawing;  // re-draw image with given parameters
- (void)setProgress:(float)progress;
- (void)setImage:(UIImage *)image;

@end