//
//  KMZFrame.h
//  KMZDraw
//
//  Created by Kentaro Matsumae on 12/06/09.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KMZLine.h"

@interface KMZFrame : NSObject

@property CGSize frameSize;
@property (nonatomic, strong) NSMutableArray* lines;
@property (nonatomic) NSInteger lineCursor;
@property (nonatomic, strong) UIImage* image;

- (void)addLine:(KMZLine*)line;
- (void)drawLine:(CGContextRef)contextRef 
            line:(KMZLine*)line 
      beginPoint:(CGPoint)beginPoint 
        endPoint:(CGPoint)endPoint;
- (void)drawImage;
- (void)drawImage:(CGContextRef)contextRef;

- (void)undo;
- (void)redo;
- (BOOL)isUndoable;
- (BOOL)isRedoable;

@end
