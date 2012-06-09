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
@synthesize drawView;
@synthesize undoButtonItem;
@synthesize redoButtonItem;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.drawView.delegate = self;
    [self updateUndoRedoButton];
}

- (void)viewDidUnload
{
    [self setDrawView:nil];
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
    [self.drawView undo];
    [self updateUndoRedoButton];
}

- (IBAction)touchRedoButton:(id)sender {
    [self.drawView redo];
    [self updateUndoRedoButton];
}

- (IBAction)touchColorButton:(id)sender {
}

- (IBAction)touchPenSelector:(id)sender {
    NSInteger idx = self.penSelector.selectedSegmentIndex;
    if (idx == 0) {
        self.drawView.penMode = KMZLinePenModePencil;
    } else {
        self.drawView.penMode = KMZLinePenModeEraser;   
    }
}

- (void)updateUndoRedoButton {
    self.undoButtonItem.enabled = [self.drawView isUndoable];
    self.redoButtonItem.enabled = [self.drawView isRedoable];
}

#pragma mark KMZDrawViewDelegate
- (void)drawView:(KMZDrawView*)drawView finishDrawLine:(KMZLine*)line {
    [self updateUndoRedoButton];
}

@end
