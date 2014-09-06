//
//  KMZCanvasView.m
//  KMZDraw
//
//  Created by Kentaro Matsumae on 12/06/09.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "KMZDrawView.h"

@interface KMZDrawView()
@property (nonatomic) CGPoint lastPoint;
@property (nonatomic) KMZFrame* currentFrame;
@property (nonatomic) KMZLine* currentLine;
@property (nonatomic) KMZLinePenMode penMode;
@property (nonatomic) NSUInteger penWidth;
@property (nonatomic) UIColor* penColor;
@end

@implementation KMZDrawView

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

#pragma mark private functions

- (void)_setupWithFrame:(CGRect)frame {
    self.backgroundColor = [UIColor whiteColor];
    self.userInteractionEnabled = YES;

    self.currentFrame = [[KMZFrame alloc] init];
    self.penMode = KMZLinePenModePencil;
    self.penWidth = 10;
    self.penColor = [UIColor blackColor];
}

- (void)layoutSubviews {
    self.currentFrame.frameSize = self.frame.size;
}

#pragma mark UIResponder

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
	CGPoint pt = [[touches anyObject] locationInView:self];
    self.lastPoint = pt;
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    self.currentLine = [[KMZLine alloc] initWithPenMode:self.penMode
                                                  width:self.penWidth
                                                  color:self.penColor path:path];
    
	[self.currentFrame addLine:self.currentLine];
    
	[self.currentLine moveToPoint:pt];
    
    UIGraphicsBeginImageContext(self.frame.size);
	[self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	if (!self.currentLine) {
		return;
	}
	
	CGPoint pt = [[touches anyObject] locationInView:self];
   
	[self.currentLine addLineToPoint:pt];
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	[self.currentFrame drawLine:context line:self.currentLine beginPoint:self.lastPoint endPoint:pt];
	self.image = UIGraphicsGetImageFromCurrentImageContext();
	
	self.lastPoint = pt;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    UIGraphicsEndImageContext();
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if (!self.currentLine) {
        UIGraphicsEndImageContext();
		return;
	}
	
	CGPoint pt = [[touches anyObject] locationInView:self];
    
	[self.currentLine addLineToPoint:pt];
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	[self.currentFrame drawLine:context line:self.currentLine beginPoint:self.lastPoint endPoint:pt];
	self.image = UIGraphicsGetImageFromCurrentImageContext();
    
	UIGraphicsEndImageContext();
	
	self.currentFrame.image = self.image;
    
    [self.delegate drawView:self finishDrawLine:self.currentLine];
	self.currentLine = nil;
}

#pragma mark public function

- (void)setPenMode:(KMZLinePenMode)penMode {
    _penMode = penMode;
}

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
