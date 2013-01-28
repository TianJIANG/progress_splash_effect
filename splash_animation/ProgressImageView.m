//
//  ProgressImageView.m
//  splash_animation
//
//  Created by Tian on 23/01/13.
//  Copyright (c) 2013 Tian. All rights reserved.
//

#import "ProgressImageView.h"


@interface UIImage (Partial)

- (UIImage *) partialImageWithPercentage:(float)percentage reverse:(BOOL)reverse;

@end


@implementation UIImage (Partial)

- (UIImage *) partialImageWithPercentage:(float)percentage reverse:(BOOL)reverse {
    const int ALPHA = 0;
    const int RED = 1;
    const int GREEN = 2;
    const int BLUE = 3;
    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0, 0, self.size.width * self.scale, self.size.height * self.scale);
    
    int width = imageRect.size.width;
    int height = imageRect.size.height;
    
    // the pixels will be painted to this array
    uint32_t *pixels = (uint32_t *) malloc(width * height * sizeof(uint32_t));
    
    // clear the pixels so any transparency is preserved
    memset(pixels, 0, width * height * sizeof(uint32_t));
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // create a context with RGBA pixels
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    
    // paint the bitmap to our context which will fill in the pixels array
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [self CGImage]);
    
    int x_origin = 0;
    int y_to = reverse? height : height * (1.f -percentage);
    int y_origin = reverse? height * percentage : 0;
    
    for(int y = y_origin; y < y_to; y++) {
        for(int x = x_origin; x < width; x++) {
            uint8_t *rgbaPixel = (uint8_t *) &pixels[y * width + x];
            rgbaPixel[ALPHA] = 0;
            rgbaPixel[RED] = 0;
            rgbaPixel[GREEN] = 0;
            rgbaPixel[BLUE] = 0;
        }
    }
    
    // create a new CGImageRef from our context with the modified pixels
    CGImageRef image = CGBitmapContextCreateImage(context);
    
    // we're done with the context, color space, and pixels
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(pixels);
    
    // make a new UIImage to return
    UIImage *resultUIImage = [UIImage imageWithCGImage:image
                                                 scale:self.scale
                                           orientation:UIImageOrientationUp];
    
    // we're done with image now too
    CGImageRelease(image);
    
    return resultUIImage;

}

@end




@implementation ProgressImageView

@synthesize progress = _progress;

#pragma mark - UIView lifecycle
- (void)dealloc
{
    _originalImage = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    _progress = 0.f;    
    _originalImage = self.image;
}

#pragma mark - Custom Accessor
- (void)setImage:(UIImage *)image
{
    [super setImage:image];
    
    if (!_internalUpdating) {
        _originalImage = image;
        [self updateDrawing];
    }
    
    _internalUpdating = NO;
}

- (void)setProgress:(float)progress
{
    _progress = MIN(MAX(0.f, progress), 1.f);
    [self updateDrawing];
}

#pragma mark - drawing
- (void)updateDrawing
{
    _internalUpdating = YES;
    self.image = [_originalImage partialImageWithPercentage:_progress reverse:YES];
}

@end
