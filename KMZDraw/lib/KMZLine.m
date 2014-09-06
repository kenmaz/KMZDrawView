//
//  KMZLine.m
//  KMZDraw
//
//  Created by Kentaro Matsumae on 12/06/09.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "KMZLine.h"

@implementation KMZLine

#pragma mark public

- (id)initWithPenMode:(KMZLinePenMode)penMode
                width:(NSUInteger)penWidth
                color:(UIColor*)color
                 path:(CGMutablePathRef)path {
    
    if (self = [super init]) {
        self.points = [[NSMutableArray alloc] init];
        self.penMode = penMode;
        self.penWidth = penWidth;
        self.penColor = color;
        self.path = CFBridgingRelease(path);
    }
    return self;
}

- (void)moveToPoint:(CGPoint)point {
    CGMutablePathRef pathRef = (CGMutablePathRef)CFBridgingRetain(self.path);
    CGPathMoveToPoint(pathRef, NULL, point.x, point.y);
}

- (void)addLineToPoint:(CGPoint)point {
    CGMutablePathRef pathRef = (CGMutablePathRef)CFBridgingRetain(self.path);
    CGPathAddLineToPoint(pathRef, NULL, point.x, point.y);
}

@end
