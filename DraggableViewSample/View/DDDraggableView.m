//
//  DDDraggableView.m
//  DDDraggableViewSample
//
//  Created by daiki ichikawa on 2016/03/31.
//  Copyright © 2016年 Daiki Ichikawa. All rights reserved.
//

#import "DDDraggableView.h"
#import "DDOverlayView.h"

@interface DDDraggableView ()
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) DDOverlayView *overlayView;
@property (nonatomic) CGPoint originalPoint;
@end

@implementation DDDraggableView

+ (instancetype)view {
    NSString *className = NSStringFromClass([self class]);
    return [[[NSBundle mainBundle] loadNibNamed:className owner:nil options:0] firstObject];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder])
    {
        self.isDragged = NO;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initGestureRecognizer];
    [self loadImageAndStyle];
    [self loadOverlayView];
    
}

- (void)initGestureRecognizer {
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragged:)];
    [self addGestureRecognizer:self.panGestureRecognizer];
}

- (void)loadImageAndStyle {
    [self.myImageView setImage:[UIImage imageNamed:@"satomi"]];
    self.layer.cornerRadius = 8;
    self.layer.shadowOffset = CGSizeMake(7, 7);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.5;
}

- (void)loadOverlayView {
    self.overlayView = [DDOverlayView view];
    self.overlayView.alpha = 0;
    [self addSubview:self.overlayView];
}

- (void)dragged:(UIPanGestureRecognizer *)gestureRecognizer {
    CGFloat xDistance = [gestureRecognizer translationInView:self].x;
    CGFloat yDistance = [gestureRecognizer translationInView:self].y;
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:{
            self.isDragged = YES;
            self.originalPoint = self.center;
            break;
        };
        case UIGestureRecognizerStateChanged:{
            CGFloat rotationStrength = MIN(xDistance / 320, 1);
            CGFloat rotationAngle = (CGFloat) (2*M_PI/16 * rotationStrength);
            CGFloat scaleStrength = 1 - fabs(rotationStrength) / 4;
            CGFloat scale = MAX(scaleStrength, 0.93);
            
            
            CGAffineTransform transform = CGAffineTransformMakeRotation(rotationAngle);
            CGAffineTransform scaleTransform = CGAffineTransformScale(transform, scale, scale);
            CGAffineTransform translateTransfom = CGAffineTransformTranslate(scaleTransform, xDistance, yDistance);
            self.transform = translateTransfom;
            
            [self updateOverlay:xDistance];
            
            // This breaks autolayout, to avoid it, need to use transform property of uiview
            //self.center = CGPointMake(self.originalPoint.x + xDistance, self.originalPoint.y + yDistance);
            break;
        };
        case UIGestureRecognizerStateEnded: {
            [self resetViewPositionAndTransformations];
            break;
        };
        case UIGestureRecognizerStatePossible:break;
        case UIGestureRecognizerStateCancelled:break;
        case UIGestureRecognizerStateFailed:break;
    }
}

- (void)updateOverlay:(CGFloat)distance {
    if (distance > 0)
    {
        self.overlayView.mode = OverlayViewModeRight;
    }
    else if (distance <= 0)
    {
        self.overlayView.mode = OverlayViewModeLeft;
    }
    CGFloat overlayStrength = MIN(fabs(distance)/100, 0.4);
    self.overlayView.alpha = overlayStrength;
}

- (void)resetViewPositionAndTransformations {
    [UIView animateWithDuration:0.2
                     animations:^{
        self.overlayView.alpha = 0;
        self.transform = CGAffineTransformIdentity;
        self.isDragged = NO;
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)dealloc {
    [self removeGestureRecognizer:self.panGestureRecognizer];
}

@end
