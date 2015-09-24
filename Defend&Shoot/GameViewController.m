//
//  GameViewController.m
//  Defend&Shoot
//
//  Created by Yazan Khayyat on 2015-09-14.
//  Copyright (c) 2015 Yazan. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"
#import "HomePage.h"

@implementation SKScene (Unarchive)

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    HomePage *scene1 = [[HomePage alloc] initWithSize:self.view.frame.size];
    scene1.scaleMode = SKSceneScaleModeResizeFill;
    
//    GameScene *scene2 = [[GameScene alloc] initWithSize:self.view.frame.size];
//    scene2.scaleMode = SKSceneScaleModeResizeFill;
    
    // Present the scene.
    [skView presentScene:scene1];
    
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
