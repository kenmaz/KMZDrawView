//
//  KMZLine.h
//  KMZDraw
//
//  Created by Kentaro Matsumae on 12/06/09.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    KMZLinePenModePencil,
    KMZLinePenModeEraser
};
typedef NSUInteger KMZLinePenMode;

@interface KMZLine : NSObject

@property KMZLinePenMode penMode;
@property NSUInteger penWidth;
@property (nonatomic, strong) UIColor* penColor;
@property (nonatomic, strong) NSMutableArray* points;
@property (nonatomic, strong) id path;

- (id)initWithPenMode:(KMZLinePenMode)penMode width:(NSUInteger)penWidth color:(UIColor*)color path:(CGMutablePathRef)path;
- (void)moveToPoint:(CGPoint)point;
- (void)addLineToPoint:(CGPoint)point;

@end
