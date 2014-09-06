//
//  KMZCanvasView.h
//  KMZDraw
//
//  Created by Kentaro Matsumae on 12/06/09.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMZFrame.h"

@class KMZDrawView;

@protocol KMZDrawViewDelegate
- (void)drawView:(KMZDrawView*)drawView finishDrawLine:(KMZLine*)line;
@end

@interface KMZDrawView : UIImageView

@property (nonatomic, weak) id<KMZDrawViewDelegate> delegate;

- (void)setPenMode:(KMZLinePenMode)penMode;
- (void)undo;
- (void)redo;
- (BOOL)isUndoable;
- (BOOL)isRedoable;

@end
