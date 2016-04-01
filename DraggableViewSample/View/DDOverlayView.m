//
//  OverlayView.m
//  DraggableViewSample
//
//  Created by daiki ichikawa on 2016/04/01.
//  Copyright © 2016年 Daiki Ichikawa. All rights reserved.
//

#import "DDOverlayView.h"

@interface DDOverlayView()
@property (nonatomic, strong) IBOutlet UIImageView *myImageView;
@end

@implementation DDOverlayView

+ (instancetype)view {
    NSString *className = NSStringFromClass([self class]);
    return [[[NSBundle mainBundle] loadNibNamed:className owner:nil options:0] lastObject];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder])
    {
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.myImageView setImage:[UIImage imageNamed:@"nope"]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setMode:(OverlayViewMode)mode {
    if (_mode == mode) return;
 
    _mode = mode;
    if (mode == OverlayViewModeLeft)
    {
        self.myImageView.image = [UIImage imageNamed:@"nope"];
    }
    else
    {
        self.myImageView.image = [UIImage imageNamed:@"like"];
    }
}

@end
