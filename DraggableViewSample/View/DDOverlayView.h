//
//  DDOverlayView.h
//  DraggableViewSample
//
//  Created by daiki ichikawa on 2016/04/01.
//  Copyright © 2016年 Daiki Ichikawa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, OverlayViewMode) {
    OverlayViewModeLeft,
    OverlayViewModeRight
};

@interface DDOverlayView : UIView
@property (nonatomic) OverlayViewMode mode;
+ (instancetype)view;
@end
