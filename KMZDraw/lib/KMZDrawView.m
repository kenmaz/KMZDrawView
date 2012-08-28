//
//  KMZCanvasView.m
//  KMZDraw
//
//  Created by Kentaro Matsumae on 12/06/09.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "KMZDrawView.h"

@implementation KMZDrawView

@synthesize delegate;

@synthesize lastPoint;
@synthesize currentFrame;
@synthesize currentLine;

@synthesize penMode;
@synthesize penWidth;
@synthesize penColor;

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self _setupWithFrame:self.frame];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _setupWithFrame:frame];
    }
    return self;
}

- (void)dealloc {
    self.delegate = nil;
    self.currentFrame = nil;
    self.currentLine = nil;
}

#pragma mark private functions

- (void)_setupWithFrame:(CGRect)frame {
    self.backgroundColor = [UIColor whiteColor];
    self.userInteractionEnabled = YES;

    self.currentFrame = [[KMZFrame alloc] initWithSize:frame.size];
    self.penMode = KMZLinePenModePencil;
    self.penWidth = 10;
    self.penColor = [UIColor blackColor];
}

#pragma mark UIResponder

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
	CGPoint pt = [[touches anyObject] locationInView:self];
    self.lastPoint = pt;
    
    CGMutablePathRef path = CGPathCreateMutable();
    self.currentLine = [[KMZLine alloc] initWithPenMode:self.penMode width:self.penWidth color:self.penColor path:path];
    
	[self.currentFrame addLine:currentLine];
    
	[currentLine moveToPoint:pt];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	if (!self.currentLine) {
		return;
	}
	
	CGPoint pt = [[touches anyObject] locationInView:self];
   
	[self.currentLine addLineToPoint:pt];
	
	UIGraphicsBeginImageContext(self.frame.size);
	[self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	CGContextRef context = UIGraphicsGetCurrentContext();
	[currentFrame drawLine:context line:currentLine beginPoint:self.lastPoint endPoint:pt];
	self.image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	self.lastPoint = pt;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if (!self.currentLine) {
		return;
	}
	
	CGPoint pt = [[touches anyObject] locationInView:self];
    
	[self.currentLine addLineToPoint:pt];
	
	UIGraphicsBeginImageContext(self.frame.size);
	[self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	CGContextRef context = UIGraphicsGetCurrentContext();
	[currentFrame drawLine:context line:self.currentLine beginPoint:self.lastPoint endPoint:pt];
	self.image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	self.currentFrame.image = self.image;
    
    [self.delegate drawView:self finishDrawLine:currentLine];
	self.currentLine = nil;
}

#pragma mark public function

- (void)undo {
    [self.currentFrame undo];
    self.image = self.currentFrame.image;
    self.currentLine = nil;
    [self setNeedsDisplay];
}

- (void)redo {
    [self.currentFrame redo];
    self.image = self.currentFrame.image;
    self.currentLine = nil;
    [self setNeedsDisplay];
}

- (BOOL)isUndoable {
    return [self.currentFrame isUndoable];
}

- (BOOL)isRedoable {
    return [self.currentFrame isRedoable];
}

@end
