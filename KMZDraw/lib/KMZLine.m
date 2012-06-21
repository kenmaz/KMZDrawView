//
//  KMZLine.m
//  KMZDraw
//
//  Created by Kentaro Matsumae on 12/06/09.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "KMZLine.h"

@implementation KMZLine

@synthesize penMode;
@synthesize penWidth;
@synthesize penColor;
@synthesize points;
@synthesize path;

#pragma mark public

- (id)initWithPenMode:(KMZLinePenMode)_penMode 
                width:(NSUInteger)_penWidth 
                color:(UIColor*)_color 
                 path:(CGMutablePathRef)_path {
    
    if (self = [super init]) {
        self.points = [[NSMutableArray alloc] init];
        self.penMode = _penMode;
        self.penWidth = _penWidth;
        self.penColor = _color;
        self.path = CFBridgingRelease(_path);
    }
    return self;
}

- (void)moveToPoint:(CGPoint)point {
    CGMutablePathRef pathRef = (CGMutablePathRef)CFBridgingRetain(self.path);
    CGPathMoveToPoint(pathRef, NULL, point.x, point.y);
    [self _addPoint:point];    
}

- (void)addLineToPoint:(CGPoint)point {
    CGMutablePathRef pathRef = (CGMutablePathRef)CFBridgingRetain(self.path);
    CGPathAddLineToPoint(pathRef, NULL, point.x, point.y);
    [self _addPoint:point];
}

- (void)dealloc {
    self.path = nil;
    self.points = nil;
    self.penColor = nil;
}

#pragma mark private

- (void)_addPoint:(CGPoint)point {
    
}

@end
