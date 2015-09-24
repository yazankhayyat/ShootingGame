//
//  HomePage.m
//  Defend&Shoot
//
//  Created by Yazan Khayyat on 2015-09-14.
//  Copyright (c) 2015 Yazan. All rights reserved.
//

#import "HomePage.h"
#import <AVFoundation/AVFoundation.h>
#import "GameScene.h"

@implementation HomePage

-(id)initWithSize:(CGSize)size{
    
    if (self = [super initWithSize:size]) {
        
        self.view.backgroundColor = [UIColor redColor];
        
        SKLabelNode *welcomeLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        welcomeLabel.text = @"Defend & Shoot!";
        welcomeLabel.fontSize = 20;
        welcomeLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                            CGRectGetMaxY(self.frame) - 40);
        
        [self addChild:welcomeLabel];
        
        SKLabelNode *startLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        startLabel.text = @"Start Game";
        startLabel.fontSize = 35;

        startLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        self.startButton = startLabel;
        
        
        [self addChild:startLabel];

    }
    return self;
}

-(void)didMoveToView:(SKView *)view{
    
    SKLabelNode *goldLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger retrievedGold  = [defaults integerForKey:@"Gold"];
    
    self.gold = retrievedGold;
    
    
    goldLabel.text = [NSString stringWithFormat:@"Gold: %ld",(long)self.gold];
    goldLabel.fontSize = 15;
    
    goldLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 80);
    
    [self addChild:goldLabel];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    

    CGPoint aPoint = [[touches anyObject] locationInNode:self];

    if (self.startButton == [self nodeAtPoint:aPoint]) {
        GameScene *scene = [[GameScene alloc]initWithSize:self.frame.size];

        SKTransition *transition = [SKTransition fadeWithColor:[UIColor grayColor] duration:0.2];
        
        [self.view presentScene:scene transition:transition];
        scene.initialPlayerPosition = scene.playerShooter.position;
    }
    

}


@end
