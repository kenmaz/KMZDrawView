//
//  KMZFrame.m
//  KMZDraw
//
//  Created by Kentaro Matsumae on 12/06/09.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "KMZFrame.h"

@implementation KMZFrame

- (id)init {
    if ((self = [super init])) {
        self.lines = [[NSMutableArray alloc] init];
        self.lineCursor = 0;
    }
    return self;
}

#pragma mark public

- (void)addLine:(KMZLine*)line {
    if ([self.lines count] > self.lineCursor) {
        [self.lines removeObjectsInRange:NSMakeRange(self.lineCursor, [self.lines count] - self.lineCursor)];
    }
    [self.lines insertObject:line atIndex:self.lineCursor];
    self.lineCursor += 1;
}

- (void)drawLine:(CGContextRef)contextRef 
            line:(KMZLine*)line 
      beginPoint:(CGPoint)beginPoint 
        endPoint:(CGPoint)endPoint {
    
    [self _drawSetup:contextRef line:line];
    
	CGContextBeginPath(contextRef);
	CGContextMoveToPoint(contextRef, beginPoint.x, beginPoint.y);
	CGContextAddLineToPoint(contextRef, endPoint.x, endPoint.y);
	CGContextStrokePath(contextRef);
}

- (void)drawLine:(CGContextRef)contextRef line:(KMZLine*)line {
	[self _drawSetup:contextRef line:line];
	
	CGContextBeginPath(contextRef);
	CGContextAddPath(contextRef, (__bridge CGPathRef)line.path);
	CGContextStrokePath(contextRef);
}

- (void)drawImage {
	UIGraphicsBeginImageContext(self.frameSize);
	CGContextRef contextRef = UIGraphicsGetCurrentContext();
	
    [self drawImage:contextRef];
	
	CGImageRef imgRef = CGBitmapContextCreateImage(contextRef);
	self.image = [UIImage imageWithCGImage:imgRef];
	CGImageRelease(imgRef);
	UIGraphicsEndImageContext();
}

- (void)drawImage:(CGContextRef)contextRef {
    for (int i = 0; i < self.lineCursor; i++) {
        KMZLine* line = [self.lines objectAtIndex:i];
        [self drawLine:contextRef line:line];
    }
}

- (void)undo {
    self.lineCursor -= 1;
	[self drawImage];
}

- (void)redo {
    self.lineCursor += 1;
    [self drawImage];
}

- (BOOL)isUndoable {
    return self.lineCursor > 0;
}

- (BOOL)isRedoable {
    return [self.lines count] > self.lineCursor;
}

#pragma mark private

- (void)_drawSetup:(CGContextRef)contextRef line:(KMZLine*)line {
	CGContextSetLineCap(contextRef, kCGLineCapRound);
	CGContextSetLineJoin(contextRef, kCGLineJoinRound);
	
	if (line.penMode == KMZLinePenModeEraser) {
        CGContextSetBlendMode(contextRef, kCGBlendModeClear);

	} else {
        CGContextSetBlendMode(contextRef, kCGBlendModeNormal);
		CGColorRef ref = line.penColor.CGColor;
		const CGFloat *colors = CGColorGetComponents(ref);
		size_t numOfComponents = CGColorGetNumberOfComponents(ref);
		if (numOfComponents < 4) {
			CGContextSetRGBStrokeColor(contextRef, colors[0], colors[0], colors[0], colors[1]);
		} else {
			CGContextSetRGBStrokeColor(contextRef, colors[0], colors[1], colors[2], colors[3]);
		}
	}
	CGContextSetLineWidth(contextRef, line.penWidth);
}

@end
