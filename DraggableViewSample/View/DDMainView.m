//
//  MainView.m
//  DraggableViewSample
//
//  Created by daiki ichikawa on 2016/03/31.
//  Copyright © 2016年 Daiki Ichikawa. All rights reserved.
//

#import "DDMainView.h"
#import "DDDraggableView.h"

@interface DDMainView()
@property (nonatomic, strong) DDDraggableView *draggableView;
@end

@implementation DDMainView

- (id)init {
    if (self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        [self loadDraggableView];
    }
    return self;
}

- (void)loadDraggableView {
    self.draggableView = [DDDraggableView view];
    [self addSubview:self.draggableView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!self.draggableView.isDragged)
    {
        self.draggableView.frame = CGRectMake(60, 60, 200, 250);
    }
}

@end
