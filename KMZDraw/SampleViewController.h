//
//  KMZViewController.h
//  KMZDraw
//
//  Created by Kentaro Matsumae on 12/06/09.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMZDrawView.h"

@interface SampleViewController : UIViewController <KMZDrawViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *penSelector;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *colorButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *undoButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *redoButtonItem;
@property (weak, nonatomic) IBOutlet KMZDrawView *drawView;

- (IBAction)touchUndoButton:(id)sender;
- (IBAction)touchRedoButton:(id)sender;
- (IBAction)touchColorButton:(id)sender;
- (IBAction)touchPenSelector:(id)sender;

@end
