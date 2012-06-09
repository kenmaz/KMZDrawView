//
//  KMZViewController.m
//  KMZDraw
//
//  Created by Kentaro Matsumae on 12/06/09.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SampleViewController.h"

@interface SampleViewController ()

@end

@implementation SampleViewController
@synthesize penSelector;
@synthesize colorButton;
@synthesize canvasView;
@synthesize undoButtonItem;
@synthesize redoButtonItem;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setCanvasView:nil];
    [self setColorButton:nil];
    [self setUndoButtonItem:nil];
    [self setRedoButtonItem:nil];
    [self setPenSelector:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)touchUndoButton:(id)sender {
    [self.canvasView undo];
}

- (IBAction)touchRedoButton:(id)sender {
    [self.canvasView redo];
}

- (IBAction)touchColorButton:(id)sender {
}

- (IBAction)touchPenSelector:(id)sender {
    NSInteger idx = self.penSelector.selectedSegmentIndex;
    if (idx == 0) {
        self.canvasView.penMode = KMZLinePenModePencil;
    } else {
        self.canvasView.penMode = KMZLinePenModeEraser;   
    }
}

@end
