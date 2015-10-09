//
//  InsetsTextField.m
//  UILabelEdgeInset
//
//  Created by Tears on 14-3-21.
//  Copyright (c) 2014年 Tears. All rights reserved.
//

#import "InsetsTextField.h"

@implementation InsetsTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 212, 38)];
    if (self) {
        self.borderStyle = UITextBorderStyleRoundedRect;
    }
    return self;
}

-(CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds , 6 , 0 );
}


-(CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds , 6 , 0 );
}

@end
