//
//  KMZFrame.m
//  KMZDraw
//
//  Created by Kentaro Matsumae on 12/06/09.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "KMZFrame.h"

@implementation KMZFrame

@synthesize lines;
@synthesize frameSize;
@synthesize image;

- (id)initWithSize:(CGSize)size {
    if ((self = [super init])) {
        self.frameSize = size;
        self.lines = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)dealloc {
    self.lines = nil;
    self.image = nil;
}

#pragma mark public

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
	CGContextAddPath(contextRef, line.path);
	CGContextStrokePath(contextRef);
}

- (void)drawImage {
	UIGraphicsBeginImageContext(self.frameSize);
	CGContextRef contextRef = UIGraphicsGetCurrentContext();
	
	for(KMZLine *line in self.lines){
		[self drawLine:contextRef line:line];
	}
	
	CGImageRef imgRef = CGBitmapContextCreateImage(contextRef);
	self.image = [UIImage imageWithCGImage:imgRef];
	CGImageRelease(imgRef);
	UIGraphicsEndImageContext();
}

- (void)drawImage:(CGContextRef)contextRef {   
	for(KMZLine *line in self.lines){
		[self drawLine:contextRef line:line];
	}
}

- (BOOL)isUndoable {
	return [self.lines count] > 0;
}

- (void)undo {
	if ([self isUndoable]) {
		[self.lines removeLastObject];
		[self drawImage];
	}
}

#pragma mark private

- (void)_drawSetup:(CGContextRef)contextRef line:(KMZLine*)line {
	CGContextSetLineCap(contextRef, kCGLineCapRound);
	CGContextSetLineJoin(contextRef, kCGLineJoinRound);
	
	if (line.penMode == KMZLinePenModeEraser) {
		CGContextSetRGBStrokeColor(contextRef, 1.0, 1.0, 1.0, 1.0);
	} else {
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
